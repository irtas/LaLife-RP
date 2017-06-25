----------------------------------------------------
--===================Aurelien=====================--
----------------------------------------------------
------------------------Lua-------------------------

local DrawMarkerShow = true
local DrawBlipTradeShow = true

-- -900.0, -3002.0, 13.0
-- -800.0, -3002.0, 13.0
-- -1078.0, -3002.0, 13.0

local PrixRoche = 1500
local PrixCuivre = 1500
local PrixFer = 1500
local PrixDiams = 1500
local chance = 10
local qte = 0
local camionSortie = false
local vehicle
local money = 0
local carJob = false
local Position = {
  Compagnie={x=978.145690917969,y=-1919.07055664063,z=31.1356315612793,distance=10},
  SpawnCamion={x=978.145690917969,y=-1919.07055664063,z=31.1356315612793,distance=10},
  Recolet={x=2969.47827148438,y=2777.9873046875,z=38.5488739013672, distance=10},
  traitement={x=2682.16967773438,y=2795.44555664063,z=40.6961441040039, distance=10},
  vente={x=1137.62316894531,y=2344.03442382813,z=54.3110084533691, distance=10},
  venteDiams={x=-619.454223632813,y=-226.972839355469,z=38.0569648742676, distance=10},
}

local BlipMine
local BlipTraitement
local BlipVenteMine
local BlipVenteDiams

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

local roche = 0
local cuivre = 0
local fer = 0
local diams = 0

AddEventHandler("tradeill:cbgetQuantity", function(itemQty)
  qte = 0
  qte = itemQty
end)

Citizen.CreateThread(function()
  --Création des blips pour les faire aparaitre et disparaitre --
  if DrawBlipTradeShow then
    SetBlipTrade(426, "~g~ Compagnie Minière", 2, Position.Compagnie.x, Position.Compagnie.y, Position.Compagnie.z)
  end

  while true do
    Citizen.Wait(0)
    if DrawMarkerShow then
      DrawMarker(1, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.traitement.x, Position.traitement.y, Position.traitement.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.vente.x, Position.vente.y, Position.vente.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.venteDiams.x, Position.venteDiams.y, Position.venteDiams.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.Compagnie.x, Position.Compagnie.y, Position.Compagnie.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    if(IsInVehicle()) then
      if(IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), GetHashKey("Tiptruck2", _r))) then
        carJob = true
        Wait(300000)
      else
        carJob = false
      end
    else
      carJob = false
    end
    Wait(5000)
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local playerPos = GetEntityCoords(GetPlayerPed(-1))

    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Compagnie.x, Position.Compagnie.y, Position.Compagnie.z, true)
    if not IsInVehicle() then
      if distance < Position.Compagnie.distance then
        if onJobLegal == 0 then
          ShowInfo('~b~Appuyer sur ~g~E~b~ pour obtenir votre camion', 0)
          if IsControlJustPressed(1,38) then
            TriggerServerEvent("poleemploi:getjobs")
            TriggerServerEvent("job:getCash_s")
            Wait(200)
            if myjob == 4 then
              if ArgentJoueur >= 3000 then
                onJobLegal = 1
                local car = GetHashKey("Tiptruck2")
                RequestModel(car)
                while not HasModelLoaded(car) do
                  Wait(1)
                end
                TriggerEvent("vmenu:JobOutfit", 11, 124)
                vehicle =  CreateVehicle(car, Position.SpawnCamion.x,  Position.SpawnCamion.y,  Position.SpawnCamion.z, 0.0, true, false)
                MISSION.truck = vehicle
                SetVehicleOnGroundProperly(vehicle)
				        SetVehicleNumberPlateText(vehicle, job.plate)
				        Wait(100)
				        SetVehicleHasBeenOwnedByPlayer(vehicle,true)
                SetVehRadioStation(vehicle, "OFF")
                SetVehicleColours(vehicle, 25, 25)
                SetVehicleLivery(vehicle, 4)
                SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                SetVehicleEngineOn(vehicle, true, false, false)
                SetEntityAsMissionEntity(vehicle, true, true)
                Wait(100)
                Citizen.Wait(1)
                AfficherBlip()
                TriggerServerEvent("job:removeMoney",3000)
                ShowMsgtime.msg = "Allez à la mine et n'oubliez pas de ramener le camion pour être remboursé"
                ShowMsgtime.time = 300
              else
                ShowMsgtime.msg = "Vous devez fournir 3000$ de caution pour prendre le véhicule"
                ShowMsgtime.time = 300
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être mineur !'
              ShowMsgtime.time = 150
            end
          end
        else
          if myjob == 4 then
            ShowInfo('~b~Appuyer sur ~g~E~b~ pour ranger votre camion', 0)
            if IsControlJustPressed(1,38) and EndingDay == false then
              EndingDay = true
              TriggerServerEvent("poleemploi:getjobs")
              Wait(100)

              TriggerServerEvent("job:addMoney",3000)
              mineEnding()
              ShowMsgtime.msg = "~r~ Vous avez été remboursé"
              ShowMsgtime.time = 300
              money = 0
            end
          end
        end
      end
    end

    if onJobLegal == 1 and myjob == 4 then
      local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, true)
      if not IsInVehicle() then
        if distance < Position.Recolet.distance then
          ShowInfo('~b~Appuyez sur ~g~E~b~ pour miner', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 4 then
              if carJob == true then
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
                local chance_mat = math.random(chance,1000)
                Wait(100)
                Citizen.Wait(1)
                if (roche+cuivre+fer+diams) < 30 and chance_mat <=500  then
                  ShowMsgtime.msg = 'Miner'
                  ShowMsgtime.time = 250
                  TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~Roche'
                  ShowMsgtime.time = 150
                  TriggerEvent("player:receiveItem", 23, 1)
                  chance = chance + 1

                elseif (roche+cuivre+fer+diams) < 30 and chance_mat <=800  then
                  ShowMsgtime.msg = 'Miner'
                  ShowMsgtime.time = 250
                  TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~cuivre'
                  ShowMsgtime.time = 150
                  TriggerEvent("player:receiveItem", 17, 1)
                  chance = chance + 1

                elseif (roche+cuivre+fer+diams) < 30 and chance_mat <= 980 then
                  ShowMsgtime.msg = 'Miner'
                  ShowMsgtime.time = 250
                  TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~fer'
                  ShowMsgtime.time = 150
                  TriggerEvent("player:receiveItem", 18, 1)
                  chance = chance + 1

                elseif (roche+cuivre+fer+diams) < 30 and chance_mat <= 1000  then
                  ShowMsgtime.msg = 'Miner'
                  ShowMsgtime.time = 250
                  TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~Diamant'
                  ShowMsgtime.time = 150
                  TriggerEvent("player:receiveItem", 19, 1)
                  chance = 1

                else
                  ShowMsgtime.msg = '~r~ Inventaire plein, allez au traitement !'
                  ShowMsgtime.time = 150
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
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
              if carJob == true then
                TriggerEvent("player:getQuantity", 23)
                roche = qte
                TriggerEvent("player:getQuantity", 17)
                cuivre = qte
                TriggerEvent("player:getQuantity", 18)
                fer = qte
                TriggerEvent("player:getQuantity", 19)
                diams = qte

                local roche_trait = 0
                local cuivre_trait =0
                local fer_trait =0
                local diams_trait =0

                TriggerEvent("player:getQuantity", 24)
                roche_trait = qte
                TriggerEvent("player:getQuantity", 20)
                cuivre_trait = qte
                TriggerEvent("player:getQuantity", 21)
                fer_trait = qte
                TriggerEvent("player:getQuantity", 22)
                diams_trait = qte
                -- TriggerEvent("player:getQuantity", 6, function(data)
                --      weedcount = data.count
                -- end)
                Wait(100)
                if roche ~= 0 and (roche_trait+cuivre_trait+fer_trait+diams_trait) < 30 then
                  ShowMsgtime.msg = '~g~ Traitement ~b~du minerai'
                  ShowMsgtime.time = 250
                  TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~Roche traitée'
                  ShowMsgtime.time = 150

                  TriggerEvent("player:looseItem", 23, 1)
                  TriggerEvent("player:receiveItem", 24, 1)
                elseif cuivre ~= 0 and (roche_trait+cuivre_trait+fer_trait+diams_trait) < 30 then
                  ShowMsgtime.msg = '~g~ Traitement ~b~du minerai'
                  ShowMsgtime.time = 250
                  TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~Cuivre traité'
                  ShowMsgtime.time = 150

                  TriggerEvent("player:looseItem", 17, 1)
                  TriggerEvent("player:receiveItem", 20, 1)
                elseif fer ~= 0 and (roche_trait+cuivre_trait+fer_trait+diams_trait) < 30 then
                  ShowMsgtime.msg = '~g~ Traitement ~b~du minerai'
                  ShowMsgtime.time = 250
                  TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~Fer traité'
                  ShowMsgtime.time = 150

                  TriggerEvent("player:looseItem", 18, 1)
                  TriggerEvent("player:receiveItem", 21, 1)
                elseif diams ~= 0 and (roche_trait+cuivre_trait+fer_trait+diams_trait) < 30 then
                  ShowMsgtime.msg = '~g~ Traitement ~b~du minerai'
                  ShowMsgtime.time = 250
                  TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~Diams traité'
                  ShowMsgtime.time = 150

                  TriggerEvent("player:looseItem", 19, 1)
                  TriggerEvent("player:receiveItem", 22, 1)
                else
                  ShowMsgtime.msg = "~r~ Vous n'avez plus aucun minerai, allez à l'acheteur !"
                  ShowMsgtime.time = 300
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
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
              if carJob == true then
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
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ 1 roche taillé vendu +' .. ' ' .. PrixRoche .. '$'
                  TriggerEvent("inventory:sell",0, 1, 24, PrixRoche, "")
                  ShowMsgtime.time = 150
                elseif cuivre ~= 0 then
                  ShowMsgtime.msg = '~g~ Vendre ~b~minerai'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ 1 lingot de cuivre vendu +' .. ' ' .. PrixCuivre .. '$'
                  TriggerEvent("inventory:sell",0, 1, 20, PrixCuivre, "")
                  ShowMsgtime.time = 150
                elseif fer ~= 0 then
                  ShowMsgtime.msg = '~g~ Vendre ~b~minerai'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ 1 lingot de fer vendu +' .. ' ' .. PrixFer .. '$'
                  TriggerEvent("inventory:sell",0, 1, 21, PrixFer, "")
                  ShowMsgtime.time = 150
                else
                  ShowMsgtime.msg = "~r~ Vous n'avez plus aucun minerai, allez rendre votre camion pour recevoir votre argent !"
                  ShowMsgtime.time = 300
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
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
              if carJob == true then
                TriggerEvent("player:getQuantity", 22)
                diams = qte
                -- TriggerEvent("player:getQuantity", 7, function(data)
                --         weedcount = data.count
                -- end)
                Wait(100)
                if diams ~= 0 then
                  ShowMsgtime.msg = '~g~ Vendre ~b~ du diamant'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ 1 diamant vendu + ' .. ' ' .. PrixDiams .. '$'
                  ShowMsgtime.time = 150
                  TriggerEvent("inventory:sell",0, 1, 22, PrixDiams, "")
                  money = money + PrixDiams
                else
                  ShowMsgtime.msg = "~r~ Vous n'avez plus aucun minerai !"
                  ShowMsgtime.time = 150
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
                ShowMsgtime.time = 150
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être mineur !'
              ShowMsgtime.time = 150
            end
          end
        end
      end
      --------------------------------------------
    end

  end
end)

function AfficherBlip()

  BlipMine = AddBlipForCoord(Position.Recolet.x, Position.Recolet.y, Position.Recolet.z)

  SetBlipSprite(BlipMine, 78)
  SetBlipColour(BlipMine, 2)
  SetBlipAsShortRange(BlipMine, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Mine')
  EndTextCommandSetBlipName(BlipMine)

  BlipTraitement = AddBlipForCoord(Position.traitement.x, Position.traitement.y, Position.traitement.z)

  SetBlipSprite(BlipTraitement, 233)
  SetBlipColour(BlipTraitement, 2)
  SetBlipAsShortRange(BlipTraitement, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Traitement de minéraux')
  EndTextCommandSetBlipName(BlipTraitement)

  BlipVenteMine = AddBlipForCoord(Position.vente.x, Position.vente.y, Position.vente.z)

  SetBlipSprite(BlipVenteMine, 277)
  SetBlipColour(BlipVenteMine, 2)
  SetBlipAsShortRange(BlipVenteMine, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Acheteur de minéraux')
  EndTextCommandSetBlipName(BlipVenteMine)

  BlipVenteDiams = AddBlipForCoord(Position.venteDiams.x, Position.venteDiams.y, Position.venteDiams.z)

  SetBlipSprite(BlipVenteDiams, 277)
  SetBlipColour(BlipVenteDiams, 2)
  SetBlipAsShortRange(BlipVenteDiams, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Acheteur de diamant')
  EndTextCommandSetBlipName(BlipVenteDiams)
end

function mineEnding()
  removeBlip()
  Wait(100)
  onJobLegal = 2
  TriggerServerEvent("vmenu:lastChar")
end

RegisterNetEvent("jobslegal:mineEnding")
AddEventHandler("jobslegal:mineEnding", function()
  mineEnding()
end)

function removeBlip()
  RemoveBlip(BlipVenteDiams)
  RemoveBlip(BlipVenteMine)
  RemoveBlip(BlipTraitement)
  RemoveBlip(BlipMine)
end

function SetBlipTrade(id, text, color, x, y, z)
  local Blip = AddBlipForCoord(x, y, z)

  SetBlipSprite(Blip, id)
  SetBlipColour(Blip, color)
  SetBlipAsShortRange(Blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(text)
  EndTextCommandSetBlipName(Blip)
end
