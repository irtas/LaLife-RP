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

local Position = {
    -- VOS POINTS ICI
    Recolet={x=,y=,z=, distance=2},
    traitement={x=,y=,z=, distance=2},
    traitement2={x=,y=,z=, distance=5},
    traitement3={x=,y=,z=, distance=2},
    vente={x=,y=,z=, distance=2}
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
local weedcount = 0

AddEventHandler("tradeill:cbgetQuantity", function(itemQty)
  weedcount = itemQty
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
        --SetBlipTrade(273, "~g~ Voler ~b~Organe", 2, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z)
        --SetBlipTrade(42, "~g~ Emballage... ~b~d'organe", 1, Position.traitement.x, Position.traitement.y, Position.traitement.z)
        --SetBlipTrade(171, "~g~ Analyse... ~b~des organes", 1, Position.traitement2.x, Position.traitement2.y, Position.traitement2.z)
        --SetBlipTrade(459, "~g~ Recherche... ~b~de client potentiel", 1, Position.traitement3.x, Position.traitement3.y, Position.traitement3.z)
        --SetBlipTrade(458, "~g~ Vendre ~b~organe emballé", 1, Position.vente.x, Position.vente.y, Position.vente.z)
    end

    while true do
                    Citizen.Wait(0)
       if DrawMarkerShow then
          --DrawMarker(1, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
          --DrawMarker(1, Position.traitement.x, Position.traitement.y, Position.traitement.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
          --DrawMarker(1, Position.traitement2.x, Position.traitement2.y, Position.traitement2.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
        --  DrawMarker(1, Position.traitement3.x, Position.traitement3.y, Position.traitement3.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
          --DrawMarker(1, Position.vente.x, Position.vente.y, Position.vente.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
       end
    end
end)

Citizen.CreateThread(function()
    while true do
                    Citizen.Wait(0)
        local playerPos = GetEntityCoords(GetPlayerPed(-1))

        local distanceWeedFarm = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, true)
        if not IsInVehicle() then
          if distanceWeedFarm < Position.Recolet.distance then
             ShowInfo('~b~Appuyer sur ~g~E~b~ pour ramasser', 0)
             if IsControlJustPressed(1, 38) then
                   weedcount = 0
                   -- TriggerEvent("player:getQuantity", 4, function(data)
                   --     weedcount = data.count
                   -- end)
                  TriggerEvent("player:getQuantity", 13)
                  Wait(100)
                  Citizen.Wait(1)
                  if weedcount < 30 then
                          ShowMsgtime.msg = '~g~ Prendre ~b~un organe'
                          ShowMsgtime.time = 250
                          TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                          Wait(2500)
                          ShowMsgtime.msg = '~g~ + 1 ~b~organe'
                          ShowMsgtime.time = 150
                          TriggerEvent("player:receiveItem", 13, 1) --13
                  else
                          ShowMsgtime.msg = '~r~ Inventaire plein !'
                          ShowMsgtime.time = 150
                  end
             end
          end
        end
-------------------------Bloc Pour rajouter un traitement-------------------------------------------
        local distanceWeedFarm = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement.x, Position.traitement.y, Position.traitement.z, true)
        if not IsInVehicle() then
          if distanceWeedFarm < Position.traitement.distance then
             ShowInfo('~b~Appuyer sur ~g~E~b~ pour emballer ~b~organe', 0)
             if IsControlJustPressed(1, 38) then
                   weedcount = 0
                   -- TriggerEvent("player:getQuantity", 6, function(data)
                   --      weedcount = data.count
                   -- end)
                  TriggerEvent("player:getQuantity", 13) --13
                  Wait(100)
                  if weedcount ~= 0 then
                          ShowMsgtime.msg = '~g~ Emballer ~b~organe'
                          ShowMsgtime.time = 250
                          TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                          Wait(2500)
                          ShowMsgtime.msg = '~g~ + 1 ~b~Organe emballé'
                          ShowMsgtime.time = 150

                          TriggerEvent("player:looseItem", 13, 1) --13
                          TriggerEvent("player:receiveItem", 14, 1) --14
                  else
                          ShowMsgtime.msg = "~r~ Vous n'avez pas d'organe !"
                          ShowMsgtime.time = 150
                  end
             end
           end
        end

		local distanceWeedFarm = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement2.x, Position.traitement2.y, Position.traitement2.z, true)
        if not IsInVehicle() then
          if distanceWeedFarm < Position.traitement2.distance then
             ShowInfo('~b~Appuyer sur ~g~E~b~ pour analyser ~b~Organe emballé', 0)
             if IsControlJustPressed(1, 38) then
                   weedcount = 0
                   -- TriggerEvent("player:getQuantity", 6, function(data)
                   --      weedcount = data.count
                   -- end)
                  TriggerEvent("player:getQuantity", 14)
                  Wait(100)
                  if weedcount ~= 0 then
                          ShowMsgtime.msg = '~g~ Analyser ~b~Organe emballé'
                          ShowMsgtime.time = 250
                          TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                          Wait(2500)
                          ShowMsgtime.msg = '~g~ + 1 ~b~Organe analysé'
                          ShowMsgtime.time = 150

                          TriggerEvent("player:looseItem", 14, 1) --14
                          TriggerEvent("player:receiveItem", 15, 1) --15
                  else
                          ShowMsgtime.msg = "~r~ Vous n'avez pas d'organe emballé !"
                          ShowMsgtime.time = 150
                  end
             end
           end
        end

		local distanceWeedFarm = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement3.x, Position.traitement3.y, Position.traitement3.z, true)
        if not IsInVehicle() then
          if distanceWeedFarm < Position.traitement3.distance then
             ShowInfo('~b~Appuyer sur ~g~E~b~ pour ~b~trouver des clients', 0)
             if IsControlJustPressed(1, 38) then
                   weedcount = 0
                   -- TriggerEvent("player:getQuantity", 6, function(data)
                   --      weedcount = data.count
                   -- end)
                  TriggerEvent("player:getQuantity", 15)
                  Wait(100)
                  if weedcount ~= 0 then
                          ShowMsgtime.msg = '~g~ Recherche... ~b~de clients potentiels...'
                          ShowMsgtime.time = 250
                          TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                          Wait(2500)
                          ShowMsgtime.msg = '~g~ Vous avez trouvé un ~b~client'
                          ShowMsgtime.time = 150

                          TriggerEvent("player:looseItem", 15, 1) --16
                          TriggerEvent("player:receiveItem", 16, 1) --17
                  else
                          ShowMsgtime.msg = "~r~ Vous n'avez pas d'organe analysé !"..weedcount
                          ShowMsgtime.time = 150
                  end
             end
           end
        end
-------------------------Fin Du Bloc Pour rajouter un traitement-------------------------------------------
        local distanceWeedFarm = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.vente.x, Position.vente.y, Position.vente.z, true)
        if not IsInVehicle() then
          if distanceWeedFarm < Position.vente.distance then
             ShowInfo('~b~ Appuyer sur ~g~E~b~ pour vendre', 0)
             if IsControlJustPressed(1, 38) then
                   weedcount = 0
                   -- TriggerEvent("player:getQuantity", 7, function(data)
                   --         weedcount = data.count
                   -- end)
                  TriggerEvent("player:getQuantity", 16)
                  Wait(100)
                  if weedcount ~= 0 then
                          ShowMsgtime.msg = '~g~ Vendre ~b~organe'
                          ShowMsgtime.time = 250
                          TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                          Wait(2500)
                          ShowMsgtime.msg = '~g~ +'..Price..'$'
                          ShowMsgtime.time = 150
                          TriggerEvent("player:sellItem", 16, Price) --17
                  else
                          ShowMsgtime.msg = "~r~Vous n'avez pas organe !"
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

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(Blip)
end
