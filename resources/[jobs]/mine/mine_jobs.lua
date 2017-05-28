----------------------------------------------------
--===================Aurelien=====================--
----------------------------------------------------
------------------------Lua-------------------------

local DrawMarkerShow = true
local DrawBlipTradeShow = true

-- -900.0, -3002.0, 13.0
-- -800.0, -3002.0, 13.0
-- -1078.0, -3002.0, 13.0

local Price = 1500
local chance = 1
local qte = 0
local Position = {
  Recolet={x=2969.47827148438,y=2777.9873046875,z=38.5488739013672, distance=10},
  traitement={x=2682.16967773438,y=2795.44555664063,z=40.6961441040039, distance=10},
  vente={x=2553.89819335938,y=2743.69409179688,z=42.3442268371582, distance=10},
  venteDiams={x=-619.454223632813,y=-226.972839355469,z=38.0569648742676, distance=10},
}

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
  DrawText(x, y)
end

function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

local ShowMsgtime = { msg = "", time = 0 }
local roche = 0
local cuivre = 0
local fer = 0
local diams = 0

AddEventHandler("tradeill:cbgetQuantity", function(itemQty)
  qte = 0
  qte = itemQty
end)

local myjob = 0

RegisterNetEvent("mine:getJobs")
AddEventHandler("mine:getJobs", function(job)
  myjob = job
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if ShowMsgtime.time ~= 0 then
      drawTxt(ShowMsgtime.msg, 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
      ShowMsgtime.time = ShowMsgtime.time - 1
    end
  end
end)


Citizen.CreateThread(function()

  if DrawBlipTradeShow then
    SetBlipTrade(78, "Mine", 2, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z)
    SetBlipTrade(50, "Traitement de métaux", 2, Position.traitement.x, Position.traitement.y, Position.traitement.z)
    SetBlipTrade(277, "Vente de mineraux", 2, Position.vente.x, Position.vente.y, Position.vente.z)
    SetBlipTrade(277, "Vente de diamant", 2, Position.venteDiams.x, Position.venteDiams.y, Position.venteDiams.z)
  end

  while true do
    Citizen.Wait(0)
    if DrawMarkerShow then
      DrawMarker(1, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.traitement.x, Position.traitement.y, Position.traitement.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.vente.x, Position.vente.y, Position.vente.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.venteDiams.x, Position.venteDiams.y, Position.venteDiams.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local playerPos = GetEntityCoords(GetPlayerPed(-1))

    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, true)
    if not IsInVehicle() then
      if distance < Position.Recolet.distance then
        ShowInfo('~b~Appuyez sur ~g~E~b~ pour récolter', 0)
        if IsControlJustPressed(1, 38) then
          TriggerServerEvent("poleemploi:getjobs")
          Wait(100)
          if myjob == 4 then
            TriggerEvent("player:getQuantity", 23)
            roche = qte
            TriggerEvent("player:getQuantity", 17)
            cuivre = qte
            TriggerEvent("player:getQuantity", 18)
            fer = qte
            TriggerEvent("player:getQuantity", 19)
            diams = qte
            -- TriggerEvent("player:getQuantity", 4, function(data)
            --     weedcount = data.count
            -- end)
            local chance_mat = math.random(chance,100)
            Wait(100)
            Citizen.Wait(1)
            if (roche+cuivre+fer+diams) < 30 and chance_mat <=50  then
              ShowMsgtime.msg = 'Miner'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~Roche'
              ShowMsgtime.time = 150
              TriggerEvent("player:receiveItem", 23, 1)
              chance = chance + 1

            elseif (roche+cuivre+fer+diams) < 30 and chance_mat <=80  then
              ShowMsgtime.msg = 'Miner'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~cuivre'
              ShowMsgtime.time = 150
              TriggerEvent("player:receiveItem", 17, 1)
              chance = chance + 1

            elseif (roche+cuivre+fer+diams) < 30 and chance_mat <= 98 then
              ShowMsgtime.msg = 'Miner'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~fer'
              ShowMsgtime.time = 150
              TriggerEvent("player:receiveItem", 18, 1)
              chance = chance + 1

            elseif (roche+cuivre+fer+diams) < 30 and chance_mat <= 100  then
              ShowMsgtime.msg = 'Miner'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~Diamant'
              ShowMsgtime.time = 150
              TriggerEvent("player:receiveItem", 19, 1)
              chance = 1

            else
              ShowMsgtime.msg = '~r~ Inventaire plein !'
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être mineur !'
            ShowMsgtime.time = 150
          end
        end
      end
    end
    -------------------------Bloc Pour rajouter un traitement-------------------------------------------
    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement.x, Position.traitement.y, Position.traitement.z, true)
    if not IsInVehicle() then
        if distance < Position.traitement.distance then
          ShowInfo('~b~Appuyez sur ~g~E~b~ pour traiter le ~b~minerai', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 4 then
            TriggerEvent("player:getQuantity", 23)
            roche = qte
            TriggerEvent("player:getQuantity", 17)
            cuivre = qte
            TriggerEvent("player:getQuantity", 18)
            fer = qte
            TriggerEvent("player:getQuantity", 19)
            diams = qte
            -- TriggerEvent("player:getQuantity", 6, function(data)
            --      weedcount = data.count
            -- end)
            Wait(100)
            if roche ~= 0 then
              ShowMsgtime.msg = '~g~ Traitement ~b~du minerai'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~Roche traitée'
              ShowMsgtime.time = 150

              TriggerEvent("player:looseItem", 23, 1)
              TriggerEvent("player:receiveItem", 24, 1)
            elseif cuivre ~= 0 then
              ShowMsgtime.msg = '~g~ Traitement ~b~du minerai'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~Cuivre traité'
              ShowMsgtime.time = 150

              TriggerEvent("player:looseItem", 17, 1)
              TriggerEvent("player:receiveItem", 20, 1)
            elseif fer ~= 0 then
              ShowMsgtime.msg = '~g~ Traitement ~b~du minerai'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~Fer traité'
              ShowMsgtime.time = 150

              TriggerEvent("player:looseItem", 18, 1)
              TriggerEvent("player:receiveItem", 21, 1)
            elseif diams ~= 0 then
              ShowMsgtime.msg = '~g~ Traitement ~b~du minerai'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~Diams traité'
              ShowMsgtime.time = 150

              TriggerEvent("player:looseItem", 19, 1)
              TriggerEvent("player:receiveItem", 22, 1)
            else
              ShowMsgtime.msg = "~r~ Vous n'avez plus aucun minerai !"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être mineur !'
            ShowMsgtime.time = 150
          end
        end
      end
    end
    -------------------------Fin Du Bloc Pour rajouter un traitement-------------------------------------------
    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.vente.x, Position.vente.y, Position.vente.z, true)
    if not IsInVehicle() then
        if distance < Position.vente.distance then
          ShowInfo('~b~ Appuyez sur ~g~E~b~ pour vendre', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 4 then
            TriggerEvent("player:getQuantity", 24)
            roche = qte
            TriggerEvent("player:getQuantity", 20)
            cuivre = qte
            TriggerEvent("player:getQuantity", 21)
            fer = qte
            TriggerEvent("player:getQuantity", 22)
            diams = qte
            -- TriggerEvent("player:getQuantity", 7, function(data)
            --         weedcount = data.count
            -- end)
            Wait(100)
            if roche ~= 0 then
              ShowMsgtime.msg = '~g~ Vendre ~b~minerai'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ +'..Price..'$'
              ShowMsgtime.time = 150
              TriggerEvent("inventory:sell",0, 1, 24, Price, "")
            elseif cuivre ~= 0 then
              ShowMsgtime.msg = '~g~ Vendre ~b~minerai'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ +'..Price..'$'
              ShowMsgtime.time = 150
              TriggerEvent("inventory:sell", 0, 1, 20, Price, "")
            elseif fer ~= 0 then
              ShowMsgtime.msg = '~g~ Vendre ~b~minerai'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ +'..Price..'$'
              ShowMsgtime.time = 150
              TriggerEvent("inventory:sell", 0, 1, 21, Price, "")
            elseif diams ~= 0 then
              ShowMsgtime.msg = '~g~ Vendre ~b~minerai'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ +'..Price..'$'
              ShowMsgtime.time = 150
              TriggerEvent("inventory:sell", 0, 1, 22, Price, "")
            else
              ShowMsgtime.msg = "~r~ Vous n'avez plus aucun minerai !"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être mineur !'
            ShowMsgtime.time = 150
          end
        end
      end
    end


    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.venteDiams.x, Position.venteDiams.y, Position.venteDiams.z, true)
    if not IsInVehicle() then
        if distance < Position.vente.distance then
          ShowInfo('~b~ Appuyez sur ~g~E~b~ pour vendre', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 4 then
            TriggerEvent("player:getQuantity", 22)
            diams = qte
            -- TriggerEvent("player:getQuantity", 7, function(data)
            --         weedcount = data.count
            -- end)
            Wait(100)
            if diams ~= 0 then
              ShowMsgtime.msg = '~g~ Vendre ~b~ du diamant'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ +'..Price..'$'
              ShowMsgtime.time = 150
              TriggerEvent("inventory:sell",0, 1, 22, price, "")
            else
              ShowMsgtime.msg = "~r~ Vous n'avez plus aucun minerai !"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être mineur !'
            ShowMsgtime.time = 150
          end
        end
      end
    end
  end
end)

function SetBlipTrade(id, text, color, x, y, z)
  local Blip = AddBlipForCoord(x, y, z)

  SetBlipSprite(Blip, id)
  SetBlipColour(Blip, color)
  SetBlipAsShortRange(Blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(text)
  EndTextCommandSetBlipName(Blip)
end
