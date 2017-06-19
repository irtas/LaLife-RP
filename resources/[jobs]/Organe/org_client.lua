----------------------------------------------------
--===================Aurelien=====================--
----------------------------------------------------
------------------------Lua-------------------------

local DrawMarkerShow = true
local DrawBlipTradeShow = true
local vehicle
local vehicleSorti = false
local Blip_tombe
local tombe = 1
local Price = 1500
-- -900.0, -3002.0, 13.0
-- -800.0, -3002.0, 13.0
-- -1078.0, -3002.0, 13.0

local morgue = {
  [1] = {["name"] = "Cimetière",["x"]=-1664.8740234375,["y"]=-281.862365722656,["z"]=51.863655090332},
  [2] = {["name"] = "Disposition",["x"] = 289.727600097656, ["y"] = -1344.177734375, ["z"] = 24.5377960205078},
  [3] = {["name"] = "Disposition",["x"] = 296.644805908203, ["y"] = -1348.23889160156, ["z"] = 24.5394287109375},
  [4] = {["name"] = "Véhicule",["x"] = -1677.12182617188, ["y"] = -299.135681152344, ["z"] = 51.8119201660156},
  [5] = {["name"] = "Véhicule Morgue",["x"] = 219.917922973633, ["y"] = -1391.60754394531, ["z"] = 30.5874881744385},
  [6] = {["name"] = "Morgue",["x"] = 223.208068847656, ["y"] = -1387.89562988281, ["z"] = 30.5365390777588},
}

local cimetiere = {
  [0] = {["name"] = "Rien",["x"]=0.0,["y"]=0.0,["z"]=0.0},
  [1] = {["name"] = "Tombe",["x"]=-1729.2099609375,["y"]=-192.654098510742,["z"]=58.4898414611816},
  [2] = {["name"] = "Tombe",["x"]=-1773.28063964844,["y"]=-196.667633056641,["z"]=56.1827926635742},
  [3] = {["name"] = "Tombe",["x"]=-1768.30749511719,["y"]=-192.655792236328,["z"]=56.9271774291992},
  [4] = {["name"] = "Tombe",["x"]=-1758.29870605469,["y"]=-201.903778076172,["z"]=56.7077598571777},
  [5] = {["name"] = "Tombe",["x"]=-1745.16662597656,["y"]=-213.337142944336,["z"]=56.7146682739258},
  [6] = {["name"] = "Tombe",["x"]=-1728.36486816406,["y"]=-225.234893798828,["z"]=56.2776718139648},
  [7] = {["name"] = "Tombe",["x"]=-1721.46691894531,["y"]=-225.751083374023,["z"]=56.3679847717285},
  [8] = {["name"] = "Tombe",["x"]=-1714.33276367188,["y"]=-226.125350952148,["z"]=56.4017333984375},
  [9] = {["name"] = "Tombe",["x"]=-1708.78796386719,["y"]=-234.912734985352,["z"]=55.118480682373},
  [10] = {["name"] = "Tombe",["x"]=-1717.10021972656,["y"]=-234.750869750977,["z"]=55.1552238464355},
  [11] = {["name"] = "Tombe",["x"]=-1726.14587402344,["y"]=-234.471145629883,["z"]=55.0515403747559},
  [12] = {["name"] = "Tombe",["x"]=-1733.15283203125,["y"]=-233.935119628906,["z"]=54.9668273925781},
  [13] = {["name"] = "Tombe",["x"]=-1747.21118164063,["y"]=-233.117523193359,["z"]=54.0030555725098},
  [14] = {["name"] = "Tombe",["x"]=-1757.38464355469,["y"]=-228.898696899414,["z"]=53.9718399047852},
  [15] = {["name"] = "Tombe",["x"]=-1762.30993652344,["y"]=-225.503982543945,["z"]=53.9051666259766},
  [16] = {["name"] = "Tombe",["x"]=-1768.38073730469,["y"]=-221.236145019531,["z"]=53.7444076538086},
  [17] = {["name"] = "Tombe",["x"]=-1776.58752441406,["y"]=-219.643020629883,["z"]=53.178638458252},
  [18] = {["name"] = "Tombe",["x"]=-1783.71765136719,["y"]=-231.466445922852,["z"]=51.3533782958984},
  [19] = {["name"] = "Tombe",["x"]=-1779.47509765625,["y"]=-234.526718139648,["z"]=51.4625244140625},
  [20] = {["name"] = "Tombe",["x"]=-1775.92224121094,["y"]=-237.01921081543,["z"]=51.6251373291016},
  [21] = {["name"] = "Tombe",["x"]=-1773.07849121094,["y"]=-239.144958496094,["z"]=51.7389755249023},
  [22] = {["name"] = "Tombe",["x"]=-1768.84057617188,["y"]=-242.327224731445,["z"]=51.9160690307617},
  [23] = {["name"] = "Tombe",["x"]=-1765.34655761719,["y"]=-244.851165771484,["z"]=51.9186592102051},
  [24] = {["name"] = "Tombe",["x"]=-1760.96301269531,["y"]=-247.916717529297,["z"]=51.8838310241699},
  [25] = {["name"] = "Tombe",["x"]=-1755.681640625,["y"]=-251.58447265625,["z"]=51.6725997924805},
  [26] = {["name"] = "Tombe",["x"]=-1750.240234375,["y"]=-254.894989013672,["z"]=51.408332824707},
  [27] = {["name"] = "Tombe",["x"]=-1763.04577636719,["y"]=-262.646026611328,["z"]=48.2130241394043},
  [28] = {["name"] = "Tombe",["x"]=-1772.20959472656,["y"]=-258.008941650391,["z"]=49.2689971923828},
  [29] = {["name"] = "Tombe",["x"]=-1776.42846679688,["y"]=-254.989837646484,["z"]=49.2840843200684},
  [30] = {["name"] = "Tombe",["x"]=-1781.00158691406,["y"]=-251.873092651367,["z"]=49.1853446960449},
  [31] = {["name"] = "Tombe",["x"]=-1785.98645019531,["y"]=-248.150955200195,["z"]=48.9917297363281},
  [32] = {["name"] = "Tombe",["x"]=-1789.74182128906,["y"]=-244.521423339844,["z"]=48.8842315673828},
  [33] = {["name"] = "Tombe",["x"]=-1792.21166992188,["y"]=-239.977767944336,["z"]=49.0164756774902},
  [34] = {["name"] = "Tombe",["x"]=-1795.48400878906,["y"]=-233.975463867188,["z"]=49.1097183227539},
  [35] = {["name"] = "Tombe",["x"]=-1801.73986816406,["y"]=-237.621643066406,["z"]=47.0440139770508},
  [36] = {["name"] = "Tombe",["x"]=-1795.41418457031,["y"]=-247.38752746582,["z"]=46.965705871582},
  [37] = {["name"] = "Tombe",["x"]=-1792.98486328125,["y"]=-250.835418701172,["z"]=46.9102668762207},
  [38] = {["name"] = "Tombe",["x"]=-1789.69836425781,["y"]=-253.766677856445,["z"]=47.0804481506348},
  [39] = {["name"] = "Tombe",["x"]=-1786.23510742188,["y"]=-256.537414550781,["z"]=47.2369499206543},
  [40] = {["name"] = "Tombe",["x"]=-1775.43835449219,["y"]=-271.304412841797,["z"]=46.0329818725586},
  [41] = {["name"] = "Tombe",["x"]=-1779.87109375,["y"]=-267.740570068359,["z"]=45.9990425109863},
  [42] = {["name"] = "Tombe",["x"]=-1784.87756347656,["y"]=-263.963562011719,["z"]=45.8425483703613},
  [43] = {["name"] = "Tombe",["x"]=-1788.98413085938,["y"]=-260.682525634766,["z"]=45.5267715454102},
  [44] = {["name"] = "Tombe",["x"]=-1793.28259277344,["y"]=-257.442016601563,["z"]=45.1631088256836},
  [45] = {["name"] = "Tombe",["x"]=-1798.48767089844,["y"]=-252.834762573242,["z"]=44.7189292907715},
  [46] = {["name"] = "Tombe",["x"]=-1803.42724609375,["y"]=-246.677520751953,["z"]=44.5778274536133},
  [47] = {["name"] = "Tombe",["x"]=-1794.24780273438,["y"]=-268.913970947266,["z"]=44.7625465393066},
  [48] = {["name"] = "Tombe",["x"]=-1779.00390625,["y"]=-282.270324707031,["z"]=45.8467903137207},
  [49] = {["name"] = "Tombe",["x"]=-1759.75329589844,["y"]=-300.615783691406,["z"]=46.5620231628418},
  [50] = {["name"] = "Tombe",["x"]=-1753.23156738281,["y"]=-305.738586425781,["z"]=47.0741004943848},
  [51] = {["name"] = "Tombe",["x"]=-1634.83483886719,["y"]=-178.456253051758,["z"]=56.0517539978027},
  [52] = {["name"] = "Tombe",["x"]=-1635.80334472656,["y"]=-175.342468261719,["z"]=56.3629493713379},
  [53] = {["name"] = "Tombe",["x"]=-1639.37780761719,["y"]=-171.057846069336,["z"]=56.7617149353027},
  [54] = {["name"] = "Tombe",["x"]=-1648.09033203125,["y"]=-144.836791992188,["z"]=58.4411773681641},
  [55] = {["name"] = "Tombe",["x"]=-1661.94006347656,["y"]=-125.99658203125,["z"]=60.2258529663086},
  [56] = {["name"] = "Tombe",["x"]=-1675.38647460938,["y"]=-125.566627502441,["z"]=60.3688354492188},
  [57] = {["name"] = "Tombe",["x"]=-1654.65808105469,["y"]=-155.896820068359,["z"]=57.767822265625},


}

local organe = {
  [1] = {["name"] = "Récolte d'organes",["x"] = 257.384490966797, ["y"] = -1344.62365722656, ["z"] = 24.544189453125, ["cost"] = 5000},
  [2] = {["name"] = "Emballage d'organes",["x"] = 249.921401977539, ["y"] = -1347.94091796875, ["z"] = 24.537805557251, ["cost"] = 5000},
  [3] = {["name"] = "Identification d'organes",["x"] = 249.739166259766, ["y"] = -1374.78088378906, ["z"] = 39.5343742370605, ["cost"] = 5000},
  [4] = {["name"] = "Vente d'organes",["x"] = -622.644104003906, ["y"] = 311.300750732422, ["z"] = 83.9290618896484, ["cost"] = 5000},
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

RegisterNetEvent("org:f_getcorp")
AddEventHandler("org:f_getcorp",function(org)
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
    SetBlipTrade(273, "~g~ Cimetière", 2, morgue[1].x, morgue[1].y, morgue[1].z)
  end

  while true do
    Citizen.Wait(0)
    if DrawMarkerShow then
      DrawMarker(1, morgue[3].x,morgue[3].y, morgue[3].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, organe[1].x, organe[1].y, organe[1].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, organe[2].x, organe[2].y, organe[2].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, organe[3].x, organe[3].y, organe[3].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, organe[4].x, organe[4].y, organe[4].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
    end
  end
end)

local plate = ""

RegisterNetEvent("org:f_plate")
AddEventHandler('org:f_plate', function(plaque)
  plate = plaque
end)

local Blip_morgue
local Blip_tombe

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local playerPos = GetEntityCoords(GetPlayerPed(-1))

    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, morgue[1].x, morgue[1].y, morgue[1].z, true)
    if not IsInVehicle() then
		if distance < 5 then
			if vehicleSorti==false then
				ShowInfo('~b~Appuyer sur ~g~E~b~ pour obtenir la destination', 0)
				if IsControlJustPressed(1,38) then
					TriggerServerEvent("poleemploi:getjobs")
					Wait(100)
					if myjob == 11 then
						TriggerEvent("vmenu:JobOutfit", 19, 108)
						Wait(100)
						local car = GetHashKey("Romero")
						RequestModel(car)
						while not HasModelLoaded(car) do
							Wait(1)
						end
						vehicle =  CreateVehicle(car, morgue[4].x,  morgue[4].y,  morgue[4].z, 0.0, true, false)
						SetVehicleOnGroundProperly(vehicle)
						Wait(200)
						TriggerServerEvent("org:plate")
						Wait(200)
						SetVehicleNumberPlateText(vehicle, plate)
						Wait(200)
						SetVehicleHasBeenOwnedByPlayer(vehicle,true)
            Wait(200)
						SetVehRadioStation(vehicle, "OFF")
						SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
						SetVehicleEngineOn(vehicle, true, false, false)
						SetEntityAsMissionEntity(vehicle, true, true)
						-- TriggerEvent("player:getQuantity", 4, function(data)
						--     weedcount = data.count
						-- end)
						Wait(100)
						Blip_morgue = AddBlipForCoord(morgue[3].x, morgue[3].y, morgue[3].z)

						SetBlipSprite(Blip_morgue, 273)
						SetBlipColour(Blip_morgue, 2)
						SetBlipRoute(Blip_morgue, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString("Allez chercher un corps")
						EndTextCommandSetBlipName(Blip)
						ShowMsgtime.msg = '~r~ Allez chercher le corp dans la morgue !'
						ShowMsgtime.time = 150
						vehicleSorti = true
						Citizen.Wait(1)
					else
						ShowMsgtime.msg = '~r~ Vous devez être fossoyeur !'
						ShowMsgtime.time = 150
					end
				end
			else
				ShowInfo('~b~Appuyer sur ~g~E~b~ pour terminer votre journée de travail', 0)
				if IsControlJustPressed(1,38) then
					TriggerServerEvent("poleemploi:getjobs")
					Wait(100)
					vehicleSorti = false
					Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
					RemoveBlip(Blip_morgue)
					RemoveBlip(Blip_tombe)
					ShowMsgtime.msg = '~r~ Vous avez terminer votre journée de travail !'
					ShowMsgtime.time = 150

					TriggerServerEvent("vmenu:lastChar")
				end
			end
      end
    end

    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, morgue[3].x, morgue[3].y, morgue[3].z, true)
    if not IsInVehicle() then
      if distance < 5 then --and blipstart == false and blipmorg == true and blipvente == false and blipdrop == false and blipDep == false and blipEmb == false and blipAna == false then
        ShowInfo('~b~Appuyer sur ~g~E~b~ pour obtenir un corps', 0)
        if IsControlJustPressed(1,38) then
          TriggerServerEvent("poleemploi:getjobs")
          Wait(100)
          if myjob == 11 then
            -- TriggerEvent("player:getQuantity", 4, function(data)
            --      weedcount = data.count
            -- end)
            Wait(100)
            TriggerEvent("player:getQuantity", 13)
            TriggerServerEvent("org:getcorp")
            Wait(100)
            if nborg >0 and org <= 30 then
              ShowMsgtime.msg = '~g~ Ramassage du corps'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~Corps '
              ShowMsgtime.time = 150
              TriggerEvent("player:receiveItem", 27, 1)
              TriggerServerEvent("org:remcorp")
              ShowMsgtime.msg = '~r~ Allez porter le corps dans la tombe !'
              ShowMsgtime.time = 150
              tombe = math.random(1, 57)

              SetBlipRoute(Blip_morgue, false)
              Blip_tombe = AddBlipForCoord(cimetiere[tombe].x, cimetiere[tombe].y, cimetiere[tombe].z)

              SetBlipSprite(Blip_tombe, 273)
              SetBlipColour(Blip_tombe, 2)
              SetBlipRoute(Blip_tombe, true)
              BeginTextCommandSetBlipName("STRING")
              AddTextComponentString("Allez porter le corps dans la tombe")
              EndTextCommandSetBlipName(Blip_tombe)
            else
              RemoveBlip(Blip_tombe)
              ShowMsgtime.msg = "~r~ Il n'y a pas de corps, allez en chercher avant de revenir"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être fossoyeur !'
            ShowMsgtime.time = 150
          end
        end
      end
    end

    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, organe[1].x, organe[1].y, organe[1].z, true)
    if not IsInVehicle() then
      if distance < 5 then
        ShowInfo('~b~ Appuyer sur ~g~E~b~ récolter le corps', 0)
        if IsControlJustPressed(1,38) then
          TriggerServerEvent("poleemploi:getjobs")
          Wait(100)
          if myjob == 11 then
            -- TriggerEvent("player:getQuantity", 5, function(data)
            --         weedcount = data.count
            -- end)
            TriggerEvent("player:getQuantity", 27)
            Wait(100)
            if org ~= 0 then
              ShowMsgtime.msg = "~g~ Récolte d'organes"
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 3 ~b~Organes'
              ShowMsgtime.time = 150
              TriggerEvent("player:looseItem", 27, 1)
              TriggerEvent("player:receiveItem",13,3)
              --SetEntityAsNoLongerNeeded(Blip.company)
              RemoveBlip(Blip_morgue)
    					RemoveBlip(Blip_tombe)
            else
              ShowMsgtime.msg = "~r~ Vous n'avez pas de corps !"
              ShowMsgtime.time = 150
              RemoveBlip(Blip_morgue)
    					RemoveBlip(Blip_tombe)
              tombe=0
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être fossoyeur !'
            ShowMsgtime.time = 150
          end
        end
      end
    end


    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, organe[2].x, organe[2].y, organe[2].z, true)
    if not IsInVehicle() then
      if distance < 5 then
        ShowInfo('~b~ Appuyer sur ~g~E~b~ emballer un organe', 0)
        if IsControlJustPressed(1,38) then
          TriggerServerEvent("poleemploi:getjobs")
          Wait(100)
          if myjob == 11 then
            TriggerEvent("player:getQuantity",13)
            -- TriggerEvent("player:getQuantity", 5, function(data)
            --         weedcount = data.count
            -- end)

            Wait(100)
            if org ~= 0 then
              ShowMsgtime.msg = "~g~ Emballage d'organe"
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 3 ~b~Organes Emballés'
              ShowMsgtime.time = 150
              TriggerEvent("player:looseItem", 13, 3)
              TriggerEvent("player:receiveItem",14 , 3)
              --SetBlipSprite(BLIP.company, 2)
              --SetBlipRoute(BLIP.company, false)
              --SetEntityAsNoLongerNeeded(Blip.company)
              blipEmb = false
              blipAna = true
            else
              ShowMsgtime.msg = "~r~ Vous n'avez pas assez d'organes !"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être fossoyeur !'
            ShowMsgtime.time = 150
          end
        end
      end
    end

    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, organe[3].x, organe[3].y, organe[3].z, true)
    if not IsInVehicle() then
      if distance < 5 then
        ShowInfo('~b~ Appuyer sur ~g~E~b~ analyser les organes', 0)
        if IsControlJustPressed(1,38) then
          TriggerServerEvent("poleemploi:getjobs")
          Wait(100)
          if myjob == 11 then
            TriggerEvent("player:getQuantity",14)
            -- TriggerEvent("player:getQuantity", 5, function(data)
            --         weedcount = data.count
            -- end)

            Wait(100)
            if org ~= 0 then
              ShowMsgtime.msg = "~g~ Analyse d'organe"
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 3 ~b~Organes analysés'
              ShowMsgtime.time = 150
              TriggerEvent("player:looseItem", 14, 3)
              TriggerEvent("player:receiveItem",15 , 3)
              --SetBlipSprite(BLIP.company, 2)
              --SetBlipRoute(BLIP.company, false)
              --SetEntityAsNoLongerNeeded(Blip.company)
              blipAna = false
              blipvente = true
            else
              ShowMsgtime.msg = "~r~ Vous n'avez pas assez d'organes !"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être fossoyeur !'
            ShowMsgtime.time = 150
          end
        end
      end
    end

    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, organe[4].x, organe[4].y, organe[4].z, true)
    if not IsInVehicle() then
      if distance < 5 then
        ShowInfo('~b~ Appuyer sur ~g~E~b~ vendre les organes', 0)
        if IsControlJustPressed(1,38) then
          TriggerServerEvent("poleemploi:getjobs")
          Wait(100)
          if myjob == 11 then
            TriggerEvent("player:getQuantity",15)
            -- TriggerEvent("player:getQuantity", 5, function(data)
            --         weedcount = data.count
            -- end)

            Wait(100)
            if org ~= 0 then
              ShowMsgtime.msg = "~g~ Vente d'organe"
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ +'.. Price ..'$'
              ShowMsgtime.time = 150
              TriggerEvent("player:sellItem", 15, Price)
              --SetEntityAsNoLongerNeeded(Blip.company)
              blipmorg = false
            else
              ShowMsgtime.msg = "~r~ Vous n'avez pas assez d'organes !"
              ShowMsgtime.time = 150

            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être fossoyeur !'
            ShowMsgtime.time = 150
          end
        end
      end
    end

    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, cimetiere[tombe].x, cimetiere[tombe].y, cimetiere[tombe].z, true)
    if not IsInVehicle() then
      if distance < 5 then
        ShowInfo('~b~ Appuyer sur ~g~E~b~ enterrer le corps', 0)
        if IsControlJustPressed(1,38) then
          TriggerServerEvent("poleemploi:getjobs")
          Wait(100)
          if myjob == 11 then
            TriggerEvent("player:getQuantity",27)
            -- TriggerEvent("player:getQuantity", 5, function(data)
            --         weedcount = data.count
            -- end)

            Wait(100)
            if org ~= 0 then
              ShowMsgtime.msg = '~g~ Enterrement en cours...'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ +'.. Price ..'$'
              ShowMsgtime.time = 150
              TriggerEvent("inventory:sell",0, 1, 27, Price, "")
              tombe = 0
              --SetEntityAsNoLongerNeeded(Blip.company)
              blipmorg = false
              RemoveBlip(Blip_morgue)
    					RemoveBlip(Blip_tombe)
            else
              ShowMsgtime.msg = "~r~ Vous n'avez pas de corps !"
              ShowMsgtime.time = 150
              RemoveBlip(Blip_morgue)
    		      RemoveBlip(Blip_tombe)
              tombe = 0

            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être fossoyeur !'
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
