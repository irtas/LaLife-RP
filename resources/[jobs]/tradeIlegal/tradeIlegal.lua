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
    Recolet={x=,y=,z=, distance=20, bli},
    traitement={x=,y=,z=, distance=20},
    vente={x=,y=,z=, distance=20}
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
  DrawText(x , y)
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

local ShowMsgtime = {msg="",time=0}
local weedcount = 0

AddEventHandler("tradeill:cbgetQuantity", function(itemQty)
  weedcount = itemQty
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if ShowMsgtime.time ~= 0 then
        drawTxt(ShowMsgtime.msg, 0,1,0.5,0.8,0.6,255,255,255,255)
        ShowMsgtime.time = ShowMsgtime.time - 1
      end
    end
end)

Citizen.CreateThread(function()

    if DrawBlipTradeShow then
        --SetBlipTrade(140, "~g~ Ceuillette ~b~Cannabis", 2, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z)
        --SetBlipTrade(50, "~g~ Préparation ~b~Cannabis", 1, Position.traitement.x, Position.traitement.y, Position.traitement.z)
        --SetBlipTrade(277, "~g~ Vendre ~b~Cannabis", 1, Position.vente.x, Position.vente.y, Position.vente.z)
    end

    while true do
       Citizen.Wait(0)
       if DrawMarkerShow then
          DrawMarker(1, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
          DrawMarker(1, Position.traitement.x, Position.traitement.y, Position.traitement.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
          DrawMarker(1, Position.vente.x, Position.vente.y, Position.vente.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
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
             ShowInfo('~b~Appuyer sur ~g~E~b~ pour récolter', 0)
             if IsControlJustPressed(1,38) then
                  weedcount = 0
                  -- TriggerEvent("player:getQuantity", 4, function(data)
                  --     weedcount = data.count
                  -- end)
                  TriggerEvent("player:getQuantity", 4)
                  Wait(100)
                  Citizen.Wait(1)
                  if weedcount < 30 then
                          ShowMsgtime.msg = '~g~ Récolter ~b~Cannabis'
                          ShowMsgtime.time = 250
                          TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                          Wait(2500)
                          ShowMsgtime.msg = '~g~ + 1 ~b~Cannabis'
                          ShowMsgtime.time = 150
                          TriggerEvent("player:receiveItem", 4, 1)
                  else
                          ShowMsgtime.msg = '~r~ Inventaire plein !'
                          ShowMsgtime.time = 150
                  end
             end
          end
        end

        local distanceWeedFarm = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement.x, Position.traitement.y, Position.traitement.z, true)
        if not IsInVehicle() then
          if distanceWeedFarm < Position.traitement.distance then
             ShowInfo('~b~Appuyer sur ~g~E~b~ pour rouler ~b~Cannabis', 0)
             if IsControlJustPressed(1,38) then
                  weedcount = 0
                  -- TriggerEvent("player:getQuantity", 4, function(data)
                  --      weedcount = data.count
                  -- end)
                  TriggerEvent("player:getQuantity", 4)
                  Wait(100)
                  if weedcount ~= 0 then
                          ShowMsgtime.msg = '~g~ Rouler ~b~Cannabis'
                          ShowMsgtime.time = 250
                          TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                          Wait(2500)
                          ShowMsgtime.msg = '~g~ + 1 ~b~Cannabis roulé'
                          ShowMsgtime.time = 150

                          TriggerEvent("player:looseItem", 4, 1)
                          TriggerEvent("player:receiveItem", 5, 1)
                  else
                          ShowMsgtime.msg = "~r~ Vous n'avez pas de Cannabis !"
                          ShowMsgtime.time = 150
                  end
             end
           end
        end

        local distanceWeedFarm = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.vente.x, Position.vente.y, Position.vente.z, true)
        if not IsInVehicle() then
          if distanceWeedFarm < Position.vente.distance then
             ShowInfo('~b~ Appuyer sur ~g~E~b~ pour vendre', 0)
             if IsControlJustPressed(1,38) then
                  weedcount = 0
                  -- TriggerEvent("player:getQuantity", 5, function(data)
                  --         weedcount = data.count
                  -- end)
                  TriggerEvent("player:getQuantity", 5)
                  Wait(100)
                  if weedcount ~= 0 then
                          ShowMsgtime.msg = '~g~ Vendre ~b~Cannabis roulé'
                          ShowMsgtime.time = 250
                          TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                          Wait(2500)
                          ShowMsgtime.msg = '~g~ +'.. Price ..'$'
                          ShowMsgtime.time = 150
                          TriggerEvent("player:sellItem", 5, Price)
                  else
                          ShowMsgtime.msg = "~r~ Vous n'avez pas de Cannabis roulé !"
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
