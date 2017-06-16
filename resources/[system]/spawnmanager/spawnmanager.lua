-- in-memory spawnpoint array for this script execution instance
local spawnPoints = {}

-- auto-spawn enabled flag
local autoSpawnEnabled = false
local autoSpawnCallback

-- support for mapmanager maps
AddEventHandler('getMapDirectives', function(add)
  -- call the remote callback
  add('spawnpoint', function(state, model)
    -- return another callback to pass coordinates and so on (as such syntax would be [spawnpoint 'model' { options/coords }])
    return function(opts)
      local x, y, z, heading

      local s, e = pcall(function()
        -- is this a map or an array?
        if opts.x then
          x = opts.x
          y = opts.y
          z = opts.z
        else
          x = opts[1]
          y = opts[2]
          z = opts[3]
        end

        x = x + 0.0001
        y = y + 0.0001
        z = z + 0.0001

        -- get a heading and force it to a float, or just default to null
        heading = opts.heading and (opts.heading + 0.01) or 0

        -- add the spawnpoint
        addSpawnPoint({
          x = x, y = y, z = z,
          heading = heading,
          model = model
        })

        -- recalculate the model for storage
        if not tonumber(model) then
          model = GetHashKey(model, _r)
        end

        -- store the spawn data in the state so we can erase it later on
        state.add('xyz', { x, y, z })
        state.add('model', model)
      end)

      if not s then
        Citizen.Trace(e .. "\n")
      end
    end
    -- delete callback follows on the next line
  end, function(state, arg)
    -- loop through all spawn points to find one with our state
    for i, sp in ipairs(spawnPoints) do
      -- if it matches...
      if sp.x == state.xyz[1] and sp.y == state.xyz[2] and sp.z == state.xyz[3] and sp.model == state.model then
        -- remove it.
        table.remove(spawnPoints, i)
        return
      end
    end
  end)
end)


-- loads a set of spawn points from a JSON string
function loadSpawns(spawnString)
  -- decode the JSON string
  local data = json.decode(spawnString)

  -- do we have a 'spawns' field?
  if not data.spawns then
    error("no 'spawns' in JSON data")
  end

  -- loop through the spawns
  for i, spawn in ipairs(data.spawns) do
    -- and add it to the list (validating as we go)
    addSpawnPoint(spawn)
  end
end

function addSpawnPoint(spawn)
  -- validate the spawn (position)
  if not tonumber(spawn.x) or not tonumber(spawn.y) or not tonumber(spawn.z) then
    error("invalid spawn position")
  end

  -- heading
  if not tonumber(spawn.heading) then
    error("invalid spawn heading")
  end

  -- model (try integer first, if not, hash it)
  local model = spawn.model

  if not tonumber(spawn.model) then
    model = GetHashKey(spawn.model)
  end

  -- is the model actually a model?
  if not IsModelInCdimage(model) then
    error("invalid spawn model")
  end

  -- is is even a ped?
  -- not in V?
  --[[if not IsThisModelAPed(model) then
  error("this model ain't a ped!")
end]]

-- overwrite the model in case we hashed it
spawn.model = model

-- all OK, add the spawn entry to the list
table.insert(spawnPoints, spawn)
end

-- changes the auto-spawn flag
function setAutoSpawn(enabled)
  autoSpawnEnabled = enabled
end

-- sets a callback to execute instead of 'native' spawning when trying to auto-spawn
function setAutoSpawnCallback(cb)
  autoSpawnCallback = cb
  autoSpawnEnabled = true
end

-- function as existing in original R* scripts
local function freezePlayer(id, freeze)
  local player = id
  SetPlayerControl(player, not freeze, false)

  local ped = GetPlayerPed(player)

  if not freeze then
    if not IsEntityVisible(ped) then
      SetEntityVisible(ped, true)
    end

    if not IsPedInAnyVehicle(ped) then
      SetEntityCollision(ped, true)
    end

    FreezeEntityPosition(ped, false)
    --SetCharNeverTargetted(ped, false)
    SetPlayerInvincible(player, false)
  else
    if IsEntityVisible(ped) then
      SetEntityVisible(ped, false)
    end

    SetEntityCollision(ped, false)
    FreezeEntityPosition(ped, true)
    --SetCharNeverTargetted(ped, true)
    SetPlayerInvincible(player, true)
    --RemovePtfxFromPed(ped)

    if not IsPedFatallyInjured(ped) then
      ClearPedTasksImmediately(ped)
    end
  end
end

function loadScene(x, y, z)
  NewLoadSceneStart(x, y, z, 0.0, 0.0, 0.0, 20.0, 0)

  while IsNewLoadSceneActive() do
    networkTimer = GetNetworkTimer()

    NetworkUpdateLoadScene()
  end
end

-- to prevent trying to spawn multiple times
local spawnLock = false

local coords = {}
local spawnReceived = false
RegisterNetEvent("es:sendingSpawnData")
AddEventHandler("es:sendingSpawnData", function(lecoords)
  coords = lecoords
  spawnReceived = true
end)

local finishedLoading = false
RegisterNetEvent("es:finishedLoading")
AddEventHandler("es:finishedLoading", function()
  finishedLoading = true
end)

local ShowMsgtime = {msg="",time=0}

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x , y)
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if ShowMsgtime.time ~= 0 then
      drawTxt(ShowMsgtime.msg, 0,1,0.5,0.8,0.6,255,255,255,255)
      ShowMsgtime.time = ShowMsgtime.time - 1
    end
  end
end)

-- spawns the current player at a certain spawn point index (or a random one, for that matter)
function spawnPlayer(spawnIdx, cb)
  if spawnLock then
    return
  end

  spawnLock = true

  Citizen.CreateThread(function()
    -- freeze the local player
    freezePlayer(PlayerId(), true)


    DoScreenFadeOut(500)

    while IsScreenFadingOut() do
      Citizen.Wait(0)
    end

    while not finishedLoading do
      Citizen.Wait(0)
    end

    Citizen.Trace("Finished")

    TriggerServerEvent("es:requestingSpawnData")
    while not spawnReceived do
      Citizen.Wait(0)
    end
    Wait(5000)
    -- if the spawn isn't set, select a random one
    if not spawnIdx then
      spawnIdx = GetRandomIntInRange(1, #spawnPoints + 1)
    end

    -- get the spawn from the array
    local spawn

    if type(spawnIdx) == 'table' then
      spawn = spawnIdx
    else
      spawn = spawnPoints[spawnIdx]
    end

    -- validate the index
    if not spawn then
      Citizen.Trace("tried to spawn at an invalid spawn index\n")
      spawnLock = false
      return
    end

    -- if the spawn has a model set
    if spawn.model then
      RequestModel(spawn.model)

      -- load the model for this spawn
      while not HasModelLoaded(spawn.model) do
        RequestModel(spawn.model)
        Wait(0)
      end

      -- change the player model
      Citizen.Trace("spawnmanager -- "..tostring(spawn.model))
      SetPlayerModel(PlayerId(), spawn.model)

      -- release the player model
      SetModelAsNoLongerNeeded(spawn.model)
    end

    -- preload collisions for the spawnpoint
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)

    -- spawn the player
    --ResurrectNetworkPlayer(GetPlayerId(), spawn.x, spawn.y, spawn.z, spawn.heading)
    local ped = GetPlayerPed(-1)

    -- V requires setting coords as well
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, spawn.heading, true, true, false)

    -- gamelogic-style cleanup stuff
    ClearPedTasksImmediately(ped)
    --SetEntityHealth(ped, 300) -- TODO: allow configuration of this?
    RemoveAllPedWeapons(ped) -- TODO: make configurable (V behavior?)
    ClearPlayerWantedLevel(PlayerId())

    freezePlayer(PlayerId(), false)

    -- ShutdownLoadingScreen()
    -- DoScreenFadeIn(500)
    --
    -- while IsScreenFadingIn() do
    --   Citizen.Wait(0)
    -- end

    TriggerEvent('playerSpawned', spawn)
    if cb then
      cb(spawn)
    end
    Citizen.Trace("There")

    spawnLock = false
  end)
end

-- spawns the current player at a certain spawn point index (or a random one, for that matter)
function spawnPlayerAfterDeath(spawnIdx, cb)
  if spawnLock then
    return
  end

  spawnLock = true

  Citizen.CreateThread(function()
    -- freeze the local player
    freezePlayer(PlayerId(), true)

    DoScreenFadeOut(500)

    while IsScreenFadingOut() do
      Citizen.Wait(0)
    end

    TriggerServerEvent("es:requestingSpawnData")
    Wait(1000)
    -- if the spawn isn't set, select a random one
    if not spawnIdx then
      spawnIdx = GetRandomIntInRange(1, #spawnPoints + 1)
    end

    -- get the spawn from the array
    local spawn

    if type(spawnIdx) == 'table' then
      spawn = spawnIdx
    else
      spawn = spawnPoints[spawnIdx]
    end

    -- validate the index
    if not spawn then
      Citizen.Trace("tried to spawn at an invalid spawn index\n")
      spawnLock = false
      return
    end

    -- if the spawn has a model set
    if spawn.model then
      RequestModel(spawn.model)

      -- load the model for this spawn
      while not HasModelLoaded(spawn.model) do
        RequestModel(spawn.model)
        Wait(0)
      end

      -- change the player model
      Citizen.Trace("spawnmanager -- "..tostring(spawn.model))
      SetPlayerModel(PlayerId(), spawn.model)

      -- release the player model
      SetModelAsNoLongerNeeded(spawn.model)
    end

    -- preload collisions for the spawnpoint
    RequestCollisionAtCoord(spawn.x, spawn.y, spawn.z)

    -- spawn the player
    --ResurrectNetworkPlayer(GetPlayerId(), spawn.x, spawn.y, spawn.z, spawn.heading)
    local ped = GetPlayerPed(-1)

    -- V requires setting coords as well
    SetEntityCoordsNoOffset(ped, spawn.x, spawn.y, spawn.z, false, false, false, true)
    NetworkResurrectLocalPlayer(spawn.x, spawn.y, spawn.z, spawn.heading, true, true, false)

    -- gamelogic-style cleanup stuff
    ClearPedTasksImmediately(ped)
    --SetEntityHealth(ped, 300) -- TODO: allow configuration of this?
    RemoveAllPedWeapons(ped) -- TODO: make configurable (V behavior?)
    ClearPlayerWantedLevel(PlayerId())
    Wait(10000)
    freezePlayer(PlayerId(), false)

    TriggerEvent('playerSpawned', spawn)
    if cb then
      cb(spawn)
    end

    ShutdownLoadingScreen()
    DoScreenFadeIn(500)

    while IsScreenFadingIn() do
      Citizen.Wait(0)
    end
    spawnLock = false
  end)
end

-- automatic spawning monitor thread, too
local respawnForced
local diedAt
local respawnDead

Citizen.CreateThread(function()
  -- main loop thing
  while true do
    Citizen.Wait(50)

    local playerPed = GetPlayerPed(-1)

    if playerPed and playerPed ~= -1 then
      -- check if we want to autospawn
      if autoSpawnEnabled then
        if NetworkIsPlayerActive(PlayerId()) then
          if (diedAt and (GetTimeDifference(GetGameTimer(), diedAt) > 2000)) or respawnForced then
            Citizen.Trace("forcin' respawn!\n")

            if respawnDead then
              if autoSpawnCallback then
                autoSpawnCallback()
              else
                spawnPlayerAfterDeath()
              end
              respawnDead = false
            else
              if autoSpawnCallback then
                autoSpawnCallback()
              else
                spawnPlayer()
              end
            end


            respawnForced = false
          end
        end
      end

      if IsEntityDead(playerPed) then
        TriggerEvent("food:drink", {name="Criss de marde", id=1, price=5, value=100})
        TriggerEvent("food:eat", {name="Criss de marde", id=1, price=5, value=100})
        if not diedAt then
          diedAt = GetGameTimer()
          respawnDead = true
        end
      else
        diedAt = nil
      end
    end
  end
end)

function forceRespawn()
  spawnLock = false
  respawnForced = true
end



--[[AddEventHandler('playerInfoCreated', function()
loadSpawns(json.encode({
spawns = {
{ x = -238.511, y = 954.025, z = 11.0803, heading = 90.0, model = 'ig_brucie' },
{ x = -310.001, y = 945.603, z = 14.3728, heading = 90.0, model = 'ig_bulgarin' },
}
}))
end)

AddEventHandler('playerActivated', function()
respawnForced = true
end)]]
