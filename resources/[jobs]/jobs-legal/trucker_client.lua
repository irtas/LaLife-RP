local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

--use this for debugging
function Chat(t)
  TriggerEvent("chatMessage", 'TRUCKER', { 0, 255, 255}, "" .. tostring(t))
end

--locations
--arrays
local TruckingCompany = {
  [0] = {["name"] = "Livraison de citerne", ["x"] = 1515.51, ["y"] = -2138.76, ["z"] = 76.7922},
  [1] = {["name"] = "Livraison de conteneur", ["x"] = 642.97, ["y"] = -3015.34, ["z"] = 7.33618},
  [2] = {["name"] = "Livraison de médicaments", ["x"] = 3514.814, ["y"] = 3759.489, ["z"] = 30.0171},
  [3] = {["name"] = "Livraison de bois", ["x"] = -552.829, ["y"] = 5348.613, ["z"] = 74.754}
}
-- SPAWN POS OF THE TRAILER DEPENDING OF THE TRAILER, PLACE WE ARE ON THE MAP
local TruckingTrailer = {
  [0] = {["x"] = 1413.43, ["y"] = -2274.77, ["z"] = 65.673, ['heading'] = 0.0},
  [1] = {["x"] = 608.197, ["y"] = -2987.5, ["z"] = 6.04521, ['heading'] = 0.0},
  [2] = {['x'] = 3453.6435546875, ['y'] = 3675.5283203125, ['z'] = 32.491413116455, ['heading'] = 0.0 },
  [3] = {['x'] = -548.77838134766, ['y'] = 5270.96484375, ['z'] = 74.14525604248, ['heading'] = 154.69729614258}
}
-- SPAWN POS OF THE TRUCK DEPENDING OF THE TRAILER, PLACE WE ARE ON THE MAP
local TruckingTruck = {
  [0] = {["x"] = 1542.18, ["y"] = -2151.85, ["z"] = 77.5319},
  [1] = {["x"] = 655.661, ["y"] = -3011.45, ["z"] = 6.04521},
  [2] = {["x"] = 3514.787, ["y"] = 3768.379, ["z"] = 29.929},
  [3] = {["x"] = -565.238, ["y"] = 5361.238, ["z"] = 70.214}
}

local Truck = {"HAULER", "PACKER", "PHANTOM"}
local Trailer = {"TANKER", "TRAILERS", "TRAILERS2", "TRAILERLOGS"}

local MissionData = {}
MISSION = {}

MISSION.toDest = false
MISSION.tailer = false
MISSION.truck = false

MISSION.hashTruck = 0
MISSION.hashTrailer = 0

local currentMission = -1

local playerCoords
local playerPed

--text for mission
local text1 = false
local text2 = false

--blips
local BLIP = {}

BLIP.company = 0
BLIP.truckReturn = 0

BLIP.trailer = {}
BLIP.trailer.i = 0

BLIP.destination = {}
BLIP.destination.i = 0

--focus button color
local r = 0
local g= 128
local b = 192
local alpha = 200

function clear()
  onJobLegal = 2
  SetBlipRoute(BLIP.company, false)
  SetBlipRoute(BLIP.destination[BLIP.destination.i], false)
  SetEntityAsNoLongerNeeded(BLIP.destination[BLIP.destination.i])

  MISSION.hashTruck = 0
  currentMission = -1
  MissionData = {}
end

function trailerclear(timer)
  SetBlipRoute(BLIP.company, true)
  SetBlipRoute(BLIP.destination[BLIP.destination.i], false)
  SetBlipSprite(BLIP.destination[BLIP.destination.i], 2) --invisible
  Wait(timer)
  if ( DoesEntityExist(MISSION.trailer) ) then
    SetEntityAsMissionEntity(MISSION.trailer, true, true)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(MISSION.trailer))
  end
  MISSION.trailer = 0
  MISSION.hashTrailer = 0
end

local initload = false
Citizen.CreateThread(function()
  while true do
    Wait(0)
    playerPed = GetPlayerPed(-1)
    playerCoords = GetEntityCoords(playerPed, 0)

    if (not initload) then
      init()
      initload = true
    end
    tick()
  end
end)

function init()
  for i=0,#TruckingCompany do
    local BLIPC = AddBlipForCoord(TruckingCompany[i]["x"], TruckingCompany[i]["y"], TruckingCompany[i]["z"])
    SetBlipSprite(BLIPC, 85)
    SetBlipColour(BLIPC, 2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(TruckingCompany[i]["name"])
    EndTextCommandSetBlipName(BLIPC)
    SetBlipAsShortRange(BLIPC,true)
    SetBlipAsMissionCreatorBlip(BLIPC,true)
    SetBlipScale(BLIPC, 1.1)
  end
end

--Draw Text / Menus
function tick()

  --debugging stange things
  if ( type(BLIP.trailer[BLIP.trailer.i]) == "boolean" ) then
  elseif( BLIP.trailer[BLIP.trailer.i] == nil ) then
  else
    BLIP.trailer[BLIP.trailer.i] = BLIP.trailer[BLIP.trailer.i]
    BLIP.destination[BLIP.destination.i] = BLIP.destination[BLIP.destination.i]
  end

  if( onJobLegal == 1 and ( myjob == 6 or myjob == 7 or myjob == 8 or myjob == 9 ) ) then

    MISSION.markerUpdate(IsEntityAttached(MISSION.trailer))
    if( IsEntityAttached(MISSION.trailer) and text1 == false) then
      TriggerEvent("mt:missiontext", "Conduire jusqu'à la ~g~destination~w~ sur votre carte.", 10000)
      SetBlipSprite(BLIP.company, 2) --invisible
      text1 = true
    elseif( not IsEntityAttached(MISSION.trailer) and text2 == false ) then
      TriggerEvent("mt:missiontext", "Attacher votre ~o~remorque~w~.", 15000)
      text2 = true
    end
    Wait(2000)
    local trailerCoords = GetEntityCoords(MISSION.trailer, 0)
    local truckCoords = GetEntityCoords(MISSION.truck, 0)
    if ( GetDistanceBetweenCoords(currentMission[1], currentMission[2], currentMission[3], trailerCoords ) < 25 and not IsEntityAttached(MISSION.trailer) and MISSION.toDest == false) then
      --TriggerServerEvent("job:success", tonumber(currentMission[4]))
      TriggerEvent("mt:missiontext", "Retourner votre camion à la ~y~compagnie de transport", 15000)
      trailerclear(10000)
      MISSION.toDest = true
    elseif ( GetDistanceBetweenCoords(currentMission[1], currentMission[2], currentMission[3], trailerCoords ) < 25 and IsEntityAttached(MISSION.trailer) and MISSION.toDest == false ) then
      TriggerEvent("mt:missiontext", "Vous êtes arrivé. Détacher votre ~o~remorque~w~ avec la touche ~r~H~w~", 15000)
    end
    ----- BACK TO BASE
    if (IsEntityAttached(MISSION.trailer) and MISSION.toDest == true) then
      TriggerEvent("mt:missiontext", "Détacher votre ~o~remorque~w~ avec la touche ~r~H~w~", 15000)
    end
    if ( GetDistanceBetweenCoords(BLIP.truckReturn[1], BLIP.truckReturn[2], BLIP.truckReturn[3], truckCoords ) < 25 and not IsEntityAttached(MISSION.trailer) and MISSION.toDest) then
      distance = GetDistanceBetweenCoords(BLIP.truckReturn[1], BLIP.truckReturn[2], BLIP.truckReturn[3], currentMission[1], currentMission[2], currentMission[3], true)
      distance = tonumber(math.floor(distance))
      TriggerServerEvent("job:success", distance)
      TriggerEvent("mt:missiontext", "Vous êtes arrivé. Vous avez obtenu ~g~$"..distance, 10000)
      SetBlipRoute(BLIP.company, false)
      MISSION.toDest = false
      MISSION.removeMarker()
      clear()
    end

    if ( IsEntityDead(MISSION.trailer) and MISSION.toDest == false ) or ( IsEntityDead(MISSION.truck) ) or ( onJobLegal == 0 and ( myjob == 6 or myjob == 7 or myjob == 8 or myjob == 9 ) ) then
      MISSION.removeMarker()
      trailerclear(3000)
      clear()
    end
  end --if onJobLegal == 0
end



---------------------------------------
---------------------------------------
---------------------------------------
----------------MISSON-----------------
---------------------------------------
---------------------------------------
---------------------------------------

AddEventHandler("transporter:optionMisson2", function(trailerN)
  BLIP.company = AddBlipForCoord(TruckingCompany[trailerN]["x"], TruckingCompany[trailerN]["y"], TruckingCompany[trailerN]["z"])
  BLIP.truckReturn = {TruckingTruck[trailerN]["x"], TruckingTruck[trailerN]["y"], TruckingTruck[trailerN]["z"]}
  MissionData = {}
  if trailerN == 0 then
    MissionData = {                     -- TANKER
    [1] = {529.998, -2285.18, 5.98135, 10000},
    [2] = {263.392, -2851.05, 5.99999, 5000}, --x,y,z,money
    [3] = {2935.05, 4308.76, 51.0919, 15000},
    [4] = {-275.528, 6044.54, 31.6137, 20000},
  }
elseif trailerN == 1 then
  MissionData = {                 -- CONTAINER
  [1] = {1730.39, -1569.42, 112.628, 10000},
  [2] = {1253.4, 1865.69, 79.6297, 15000},
  [3] = {-1658.26, 3070.84, 31.1018, 5000}, --x,y,z,money
  [4] = {10.9037, 6274.51, 31.2464, 15000},
}
elseif trailerN == 2 then
  MissionData = {                      -- FRIGORIGIQUE
  [1] = {1815.92749023438,3698.14306640625,33.9835662841797, 15000},
  [2] = {-238.370208740234,6332.79248046875,32.4256858825684, 15000},
  [3] = {-654.866943359375,308.018859863281,82.8393630981445, 15000},
  [4] = {380.510467529297,-581.022399902344,28.670919418335, 15000},
  [5] = {-931.446960449219,-318.014434814453,39.1533203125, 15000},
  [6] = {-654.866943359375,308.018859863281,82.8393630981445, 15000},
  [7] = {98.501, -1607.326, 29.559, 5000}, --x,y,z,money
  [8] = {294.517,-1438.098,29.804, 10000},
  [9] = {1144.44201660156,-1484.60327148438,34.6925354003906, 15000},
}
elseif trailerN == 3 then
  MissionData = {                      -- LOG
  [1] = {257.960, 2901.558, 43.101, 20000},
  [2] = {1373.795, -739.679, 67.232, 5000}, --x,y,z,money
  [3] = {-198.747, -1090.453, 21.687, 15000},
  [4] = {-493.225, -961.148, 23.681, 10000},
}
end

--select trailer
MISSION.hashTrailer = GetHashKey(Trailer[trailerN + 1])
RequestModel(MISSION.hashTrailer)

while not HasModelLoaded(MISSION.hashTrailer) do
  Wait(1)
end

--select random truck
local randomTruck = GetRandomIntInRange(1, #Truck)

MISSION.hashTruck = GetHashKey(Truck[randomTruck])
RequestModel(MISSION.hashTruck)

while not HasModelLoaded(MISSION.hashTruck) do
  Wait(1)
end
end)

local distance = 0

AddEventHandler("transporter:mission2", function(missionN, trailerN)
  --currently one destination per ride
  BLIP.trailer.i = BLIP.trailer.i + 1
  BLIP.destination.i = BLIP.destination.i + 1
  currentMission = MissionData[missionN]

  -- Added by Tim34
  local truckpos = GetClosestVehicle(TruckingTruck[trailerN]["x"], TruckingTruck[trailerN]["y"], TruckingTruck[trailerN]["z"], 10.000, 0, 70)
  local trailerpos = GetClosestVehicle(TruckingTrailer[trailerN]["x"], TruckingTrailer[trailerN]["y"], TruckingTrailer[trailerN]["z"], 10.000, 0, 70)

  if DoesEntityExist(truckpos) or DoesEntityExist(trailerpos) then
    TriggerEvent("mt:missiontext", "The parking space is occupied, please wait", 5000)
  else
    onJobLegal = 1
    MISSION.spawnTrailer(trailerN)
    MISSION.spawnTruck(trailerN)
  end
end)

RegisterNetEvent("transporter:endingDay")
AddEventHandler("transporter:endingDay", function()
  trailerclear(1000)
  MISSION.removeMarker()
  clear()
end)

function MISSION.spawnTruck(spawnID)
  MISSION.truck = CreateVehicle(MISSION.hashTruck, TruckingTruck[spawnID]["x"], TruckingTruck[spawnID]["y"], TruckingTruck[spawnID]["z"], 0.0, true, false)
  SetVehicleOnGroundProperly(MISSION.trailer)
  SetVehicleNumberPlateText(MISSION.truck, "M15510")
  SetVehRadioStation(MISSION.truck, "OFF")
  SetPedIntoVehicle(playerPed, MISSION.truck, -1)
  SetVehicleEngineOn(MISSION.truck, true, false, false)
  SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 11, 66, 2, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 4, 39, 2, 0)
  SetPedComponentVariation(GetPlayerPed(-1), 6, 39, 0, 0)

  SetPedPropIndex(GetPlayerPed(-1), 0, 64, 7, 1)
  --important
  --SetEntityAsMissionEntity(MISSION.truck, true, true);
end

function MISSION.spawnTrailer(spawnID)
  MISSION.trailer = CreateVehicle(MISSION.hashTrailer, TruckingTrailer[spawnID]["x"], TruckingTrailer[spawnID]["y"], TruckingTrailer[spawnID]["z"], TruckingTrailer[spawnID]["heading"], true, false)
  SetVehicleLivery(MISSION.trailer, 2)
  SetVehicleOnGroundProperly(MISSION.trailer)

  --setMarker on trailer
  MISSION.trailerMarker()
end

local oneTime = false

function MISSION.trailerMarker()
  --BLIP.trailer.i = BLIP.trailer.i + 1 this happens in GUI.mission()
  BLIP.trailer[BLIP.trailer.i] = AddBlipForEntity(MISSION.trailer)
  SetBlipSprite(BLIP.trailer[BLIP.trailer.i], 1)
  SetBlipColour(BLIP.trailer[BLIP.trailer.i], 17)
  SetBlipRoute(BLIP.trailer[BLIP.trailer.i], false)
  Wait(50)
end

function MISSION.markerUpdate(trailerAttached)
  if( not BLIP.destination[BLIP.destination.i] and trailerAttached) then
    -- BLIP.destination.i = BLIP.destination.i + 1 this happens in GUI.mission()
    BLIP.destination[BLIP.destination.i]  = AddBlipForCoord(currentMission[1], currentMission[2], currentMission[3])
    SetBlipSprite(BLIP.destination[BLIP.destination.i], 1)
    SetBlipColour(BLIP.destination[BLIP.destination.i], 2)
    SetBlipRoute(BLIP.destination[BLIP.destination.i], true)
  end
  if( trailerAttached ) then
    SetBlipSprite(BLIP.trailer[BLIP.trailer.i], 2) --invisible
  elseif ( not trailerAttached and BLIP.trailer[BLIP.trailer.i]) then
    SetBlipSprite(BLIP.trailer[BLIP.trailer.i], 1) --visible
    SetBlipColour(BLIP.trailer[BLIP.trailer.i], 17)
  end
  Wait(50)
end

function MISSION.removeMarker()
  SetBlipSprite(BLIP.company, 2) --invisible
  SetBlipSprite(BLIP.destination[BLIP.destination.i], 2)--invisible
  SetBlipSprite(BLIP.trailer[BLIP.trailer.i], 2) --invisible
  RemoveBlip(BLIP.company)
  RemoveBlip(BLIP.destination[BLIP.destination.i])
  RemoveBlip(BLIP.trailer[BLIP.trailer.i], 2)
end
