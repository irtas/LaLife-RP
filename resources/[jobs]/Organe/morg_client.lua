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
local random = 1
local Blip
local vehicle
local vehicleSorti = false
local morgue = {
  [1] = {["name"] = "Disposition",["x"] = 289.727600097656, ["y"] = -1344.177734375, ["z"] = 24.5377960205078},
  [2] = {["name"] = "Véhicule Morgue",["x"] = 245.443954467773, ["y"] = -1410.55725097656, ["z"] = 30.587495803833},
  [3] = {["name"] = "Morgue",["x"] = 223.208068847656, ["y"] = -1387.89562988281, ["z"] = 30.5365390777588},
}
local hopital = {
  [1] = {["name"] = "Hôpital",["x"]=-261.992340087891,["y"]=6333.66162109375,["z"]=32.4210891723633},
  [2] = {["name"] = "Hôpital",["x"]=1864.72619628906,["y"]=3702.21899414063,["z"]=33.4716033935547},
  [3] = {["name"] = "Hôpital",["x"]=-654.125671386719,["y"]=309.119750976563,["z"]=82.9213256835938},
  [4] = {["name"] = "Hôpital",["x"]=-910.559753417969,["y"]=-335.803131103516,["z"]=38.979133605957},
  [5] = {["name"] = "Hôpital",["x"]=-427.751342773438,["y"]=-328.891357421875,["z"]=33.1089820861816},
  [6] = {["name"] = "Hôpital",["x"]=319.811828613281,["y"]=-557.3583984375,["z"]=28.7437915802002},
  [7] = {["name"] = "Hôpital",["x"]=375.525451660156,["y"]=-1443.37231445313,["z"]=29.4315452575684},
  [8] = {["name"] = "Hôpital",["x"]=1136.01513671875,["y"]=-1599.89086914063,["z"]=34.6925392150879},
}

local organe = {
  [1] = {["name"] = "Récolte d'organes",["x"] = 425.209655761719, ["y"] = -978.861267089844, ["z"] = 30.7105674743652, ["cost"] = 5000},
  [2] = {["name"] = "Emballage d'organes",["x"] = 425.209655761719, ["y"] = -978.861267089844, ["z"] = 30.7105674743652, ["cost"] = 5000},
  [3] = {["name"] = "Identification d'organes",["x"] = 425.209655761719, ["y"] = -978.861267089844, ["z"] = 30.7105674743652, ["cost"] = 5000},
  [4] = {["name"] = "Vente d'organes",["x"] = 425.209655761719, ["y"] = -978.861267089844, ["z"] = 30.7105674743652, ["cost"] = 5000},
}

local MISSION = {}

MISSION.start = false
MISSION.toDest = false
MISSION.tailer = false
MISSION.truck = false

MISSION.hashTruck = 0
MISSION.hashTrailer = 0

local BLIP = {}

BLIP.company = 0
BLIP.truckReturn = 0

BLIP.trailer = {}
BLIP.trailer.i = 0

BLIP.destination = {}
BLIP.destination.i = 0

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
local org = 0
local nborg = 0

RegisterNetEvent('org:f_getcorp')
AddEventHandler('org:f_getcorp',function(org)
  nborg = org
end)

AddEventHandler("tradeill:cbgetQuantity", function(itemQty)
  org = itemQty
end)

local myjob = 0

RegisterNetEvent("mine:getJobs")
AddEventHandler("mine:getJobs", function(job)
  myjob = job
end)

local plate = ""

RegisterNetEvent("org:f_plate")
AddEventHandler('org:f_plate', function(plaque)
  plate = plaque
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
    SetBlipTrade(310, "~g~ Morgue", 2, morgue[3].x, morgue[3].y, morgue[3].z)
  end

  while true do
    Citizen.Wait(0)
    if DrawMarkerShow then
       DrawMarker(1, morgue[1].x, morgue[1].y, morgue[1].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
      -- DrawMarker(1, Position.traitement.x, Position.traitement.y, Position.traitement.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
      -- DrawMarker(1, Position.traitement2.x, Position.traitement2.y, Position.traitement2.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
      -- DrawMarker(1, Position.traitement3.x, Position.traitement3.y, Position.traitement3.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
      -- DrawMarker(1, Position.vente.x, Position.vente.y, Position.vente.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local playerPos = GetEntityCoords(GetPlayerPed(-1))

    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, morgue[3].x, morgue[3].y, morgue[3].z, true)
    if not IsInVehicle() then
      if distance < 5 then
		if vehicleSorti == false then
        ShowInfo('~b~Appuyer sur ~g~E~b~ pour obtenir la destination', 0)
        if IsControlJustPressed(1,38) then
          TriggerServerEvent("poleemploi:getjobs")
          Wait(100)
          if myjob == 12 then
            TriggerEvent("vmenu:JobOutfit", 2, 162)
            local car = GetHashKey("Burrito3")
            RequestModel(car)
            while not HasModelLoaded(car) do
              Wait(1)
            end
            vehicle =  CreateVehicle(car, morgue[2].x,  morgue[2].y,  morgue[2].z, 0.0, true, false)
            SetVehicleOnGroundProperly(vehicle)
           	TriggerServerEvent("org:plate")
			      Wait(200)
			      SetVehicleNumberPlateText(vehicle, plate)
			      Wait(200)
			      SetVehicleHasBeenOwnedByPlayer(vehicle,true)
            Wait(200)
            SetVehRadioStation(vehicle, "OFF")
  		      SetVehicleColours(vehicle, 25, 25)
            SetVehicleLivery(vehicle, 4)
            SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
            SetVehicleEngineOn(vehicle, true, false, false)
            SetEntityAsMissionEntity(vehicle, true, true)
            random = math.random(1, 8)
            Blip = AddBlipForCoord(hopital[random].x, hopital[random].y, hopital[random].z)

            SetBlipSprite(Blip, 273)
            SetBlipColour(Blip, 2)
            SetBlipRoute(Blip,true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Allez chercher le corps")
            EndTextCommandSetBlipName(Blip)
            -- TriggerEvent("player:getQuantity", 4, function(data)
            --     weedcount = data.count
            -- end)
            Wait(100)
			vehicleSorti = true
            Citizen.Wait(1)
          else
            ShowMsgtime.msg = '~r~ Vous devez être préposé à la morgue !'
            ShowMsgtime.time = 150
          end
        end
		else
		ShowInfo('~b~Appuyer sur ~g~E~b~ pour terminer votre journée de travail', 0)
        if IsControlJustPressed(1,38) then
          TriggerServerEvent("poleemploi:getjobs")
          Wait(100)
          if myjob == 12 then
		            TriggerServerEvent("poleemploi:getjobs")
					Wait(100)
					vehicleSorti = false
					Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
					RemoveBlip(Blip)
					ShowMsgtime.msg = '~r~ Vous avez terminer votre journée de travail !'
					ShowMsgtime.time = 150

					TriggerServerEvent("vmenu:lastChar")
					vehicleSorti = false
				end
            end
		end
      end
    end

    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, hopital[random].x, hopital[random].y, hopital[random].z, true)
    if not IsInVehicle() then
      if distance < 5 then
        ShowInfo('~b~Appuyer sur ~g~E~b~ pour obtenir un corps', 0)
        if IsControlJustPressed(1,38) then
          TriggerServerEvent("poleemploi:getjobs")
          Wait(100)
          if myjob == 12 then
            -- TriggerEvent("player:getQuantity", 4, function(data)
            --      weedcount = data.count
            -- end)
            TriggerEvent("player:getQuantity", 26)
            Wait(100)
            if org < 1 then
              ShowMsgtime.msg = '~g~ Ramassage du corps'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~Corps '
              ShowMsgtime.time = 150
              TriggerEvent("player:receiveItem", 26, 1)
              ShowMsgtime.msg = '~r~ Allez porter le corp dans la morgue !'
              ShowMsgtime.time = 150
              RemoveBlip(Blip)
              Blip = AddBlipForCoord(morgue[3].x, morgue[3].y, morgue[3].z)

              SetBlipSprite(Blip, 273)
              SetBlipColour(Blip, 2)
              SetBlipRoute(Blip,true)

              BeginTextCommandSetBlipName("STRING")
              AddTextComponentString("Morgue")
              EndTextCommandSetBlipName(Blip)
            else
              ShowMsgtime.msg = '~g~ Vous avez déjà un ~b~corps, allez le porter à la morgue '
              ShowMsgtime.time = 150
              RemoveBlip(Blip)
              Blip = AddBlipForCoord(morgue[3].x, morgue[3].y, morgue[3].z)

              SetBlipSprite(Blip, 273)
              SetBlipColour(Blip, 2)
              SetBlipRoute(Blip,true)

              BeginTextCommandSetBlipName("STRING")
              AddTextComponentString("Morgue")
              EndTextCommandSetBlipName(Blip)
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être préposé à la morgue !'
            ShowMsgtime.time = 150
            RemoveBlip(Blip)
          end
        end
      end
    end

    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, morgue[1].x, morgue[1].y, morgue[1].z, true)
    if not IsInVehicle() then
      if distance < 5 then
        ShowInfo('~b~ Appuyer sur ~g~E~b~ pour préparer le corps', 0)
        if IsControlJustPressed(1,38) then
          TriggerServerEvent("poleemploi:getjobs")
          Wait(100)
          if myjob == 12 then
            weedcount = 0
            -- TriggerEvent("player:getQuantity", 5, function(data)
            --         weedcount = data.count
            -- end)
            TriggerEvent("player:getQuantity", 26)
            Wait(100)
            if org ~= 0 then
              ShowMsgtime.msg = '~g~ Préparation du corps'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              TriggerServerEvent("org:addcorp")
              TriggerServerEvent("org:getcorp")
              TriggerEvent("inventory:sell",0, 1, 26, Price, "")

              random = math.random(1, 8)
              Blip = AddBlipForCoord(hopital[random].x, hopital[random].y, hopital[random].z)

              SetBlipSprite(Blip, 273)
              SetBlipColour(Blip, 2)
              SetBlipRoute(Blip,true)

              BeginTextCommandSetBlipName("STRING")
              AddTextComponentString("Allez chercher le corps")
              EndTextCommandSetBlipName(Blip)
              --SetEntityAsNoLongerNeeded(Blip.company)
            else
              ShowMsgtime.msg = "~r~ Vous n'avez pas de corps, allez en chercher un !"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être préposé à la morgue !'
            ShowMsgtime.time = 150
            RemoveBlip(Blip)
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
