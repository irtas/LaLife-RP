--[[
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
]]

function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

AddEventHandler("vmenu:cleanCash", function(target)
	TriggerServerEvent("vmenu:cleanCash_s")
end)

AddEventHandler("vmenu:anim", function(dict, anim)
	Citizen.CreateThread(function()
		Wait(1000)
		RequestAnimDict(dict)

		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(0)
		end

		local myPed = PlayerPedId()
		local animation = anim
		local flags = 16 -- only play the animation on the upper body

		TaskPlayAnim(myPed, dict, animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
	end)
end)

AddEventHandler("vmenu:animChain", function(dict, anim, dict2, anim2, dict3, anim3)
	Citizen.CreateThread(function()
		--TriggerEvent("wrapper:cellphoneAnimOn")
		Wait(100)
		RequestAnimDict(dict)

		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(0)
		end

		local myPed = PlayerPedId()
		local animation = anim
		local flags = 16 -- only play the animation on the upper body

		TaskPlayAnim(myPed, dict, animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
		Wait(1100)
		while VMenu.visible do
			Wait(10)
			RequestAnimDict(dict2)

			while not HasAnimDictLoaded(dict2) do
				Citizen.Wait(0)
			end

			local myPed = PlayerPedId()
			local animation = anim2
			local flags = 1 -- only play the animation on the upper body

			TaskPlayAnim(myPed, dict2, animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
		end

		if not VMenu.visible then
			if not VMenu.animations then
				ClearPedTasksImmediately(GetPlayerPed(-1))
				RequestAnimDict(dict3)

				while not HasAnimDictLoaded(dict3) do
					Citizen.Wait(0)
				end

				local myPed = PlayerPedId()
				local animation = anim3
				local flags = 16 -- only play the animation on the upper body

				TaskPlayAnim(myPed, dict3, animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
				Wait(500)
				--TriggerEvent("wrapper:cellphoneAnimOff")
			else
				ClearPedTasksImmediately(GetPlayerPed(-1))
			end
		end
	end)
end)

AddEventHandler("vmenu:poleemploi", function(target, idJob) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	User.job = idJob
	TriggerServerEvent('poleemploi:jobs', idJob)
end)

AddEventHandler("vmenu:MainMenuOG", function(target)
	VMenu.police = false
	VMenu.telephone = false
	VMenu.animations = false
end)

AddEventHandler("vmenu:policeState", function(target, idPolice) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	TriggerServerEvent("player:serviceOn", "police")
	TriggerServerEvent('jobspolice:jobs', idPolice, false)
end)

AddEventHandler("vmenu:policeStateCivil", function(target, idPolice) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	TriggerServerEvent("vmenu:lastChar")
	TriggerServerEvent("player:serviceOn", "police")
	TriggerServerEvent('jobspolice:jobs', idPolice, true)
end)

local cashconfirmed = 0
local sendMoney = 0
local sendTarget = -1

AddEventHandler("vmenu:giveCash", function(target, money)
	if target ~= -1 then
		TriggerEvent("vmenu:closeMenu")
		DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
		cashconfirmed = 1
		sendMoney = money
		sendTarget = target
	else
		TriggerEvent("itinerance:notif", "~r~ Vous n'avez pas de cible")
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if cashconfirmed == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				cashconfirmed = 0
			elseif UpdateOnscreenKeyboard() == 1 then
				local txt = GetOnscreenKeyboardResult()
				if (string.len(txt) > 0) and (string.match(txt, '%d+')) then -- BEAU REGEX PATTERN EN LUA PARCE QUE C'EST PAUVRE
					txt = tonumber(txt)
					if sendMoney > txt then
						if txt > 0 then
							addCash = txt
							cashconfirmed = 2
						else
							TriggerEvent("itinerance:notif", "~r~ Vous devez entrer un nombre positif")
							cashconfirmed = 0
							sendMoney = 0
							sendTarget = -1
						end
					else
						TriggerEvent("itinerance:notif", "~r~ Vous n'avez pas assez d'argent")
						cashconfirmed = 0
						sendMoney = 0
						sendTarget = -1
					end
				else
					TriggerEvent("itinerance:notif", "~r~ Entrer un montant valide")
					cashconfirmed = 0
					sendMoney = 0
					sendTarget = -1
				end
			elseif UpdateOnscreenKeyboard() == 2 then
				cashconfirmed = 0
				sendMoney = 0
				sendTarget = -1
			end
		end
		if cashconfirmed == 2 then
			TriggerServerEvent('vmenu:giveCash_s', GetPlayerServerId(sendTarget), addCash)
			cashconfirmed = 0
			sendMoney = 0
			sendTarget = -1
		end
	end
end)

local dcashconfirmed = 0

AddEventHandler("vmenu:giveDCash", function(target, money)
	if target ~= -1 then
		TriggerEvent("vmenu:closeMenu")
		DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
		dcashconfirmed = 1
		sendMoney = money
		sendTarget = target
	else
		TriggerEvent("itinerance:notif", "~r~ Vous n'avez pas de cible")
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if dcashconfirmed == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				dcashconfirmed = 0
			elseif UpdateOnscreenKeyboard() == 1 then
				local txt = GetOnscreenKeyboardResult()
				if (string.len(txt) > 0) and (string.match(txt, '%d+')) then -- BEAU REGEX PATTERN EN LUA PARCE QUE C'EST PAUVRE
					txt = tonumber(txt)
					if sendMoney > txt then
						if txt > 0 then
							addCash = txt
							dcashconfirmed = 2
						else
							TriggerEvent("itinerance:notif", "~r~ Vous devez entrer un nombre positif")
							dcashconfirmed = 0
							sendMoney = 0
							sendTarget = -1
						end
					else
						TriggerEvent("itinerance:notif", "~r~ Vous n'avez pas assez d'argent")
						dcashconfirmed = 0
						sendMoney = 0
						sendTarget = -1
					end
				else
					TriggerEvent("itinerance:notif", "~r~ Entrer un montant valide")
					dcashconfirmed = 0
					sendMoney = 0
					sendTarget = -1
				end
			elseif UpdateOnscreenKeyboard() == 2 then
				dcashconfirmed = 0
				sendMoney = 0
				sendTarget = -1
			end
		end
		if dcashconfirmed == 2 then
			TriggerServerEvent('vmenu:giveDCash_s', GetPlayerServerId(sendTarget), addCash)
			dcashconfirmed = 0
			sendMoney = 0
			sendTarget = -1
		end
	end
end)

AddEventHandler("vmenu:getArmory", function(target, idGun) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	TriggerServerEvent('jobspolice:wepArmory', idGun)
end)

AddEventHandler("vmenu:getGarage", function(target, vehicule) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	TriggerServerEvent('jobspolice:vehGarage', vehicule)
end)

AddEventHandler("vmenu:getHelicoGarage", function(target, vehicule) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	TriggerServerEvent('jobspolice:vehHelicoGarage', vehicule)
end)

AddEventHandler("vmenu:getAmbulanceHelicoGarage", function(target, vehicule) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	TriggerServerEvent('es_em:getAmbulanceHelicoGarage', vehicule)
end)

AddEventHandler("vmenu:toGarage", function(target) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
		DrawNotif("Sortez du véhicule")
	else
		TriggerServerEvent('jobspolice:vehtoGarage')
	end
end)

AddEventHandler("vmenu:getSkin", function(target, sex) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	CreateThread(function()
		local model = nil
		if sex == 0 then
			model = GetHashKey("mp_m_freemode_01")
		else
			model = GetHashKey("mp_f_freemode_01")
		end

		if model ~= nil then
			RequestModel(model)
			while not HasModelLoaded(model) do -- Wait for model to load
				RequestModel(model)
				Citizen.Wait(0)
			end
			SetPlayerModel(PlayerId(), model)
			SetModelAsNoLongerNeeded(model)
		end
	end)
end)

AddEventHandler("vmenu:getclientOutfits", function(target, item) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	CreateThread(function()
		--SetPedPropIndex(GetPlayerPed(-1),  0,  12,  0,  0)
		--SetPedPropIndex(GetPlayerPed(-1),  1,  18,  2,  0)

		--SetPedComponentVariation(GetPlayerPed(-1), 0, item.zero[1], item.zero[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 1, item.one[1], item.one[2], 2)
		--SetPedComponentVariation(GetPlayerPed(-1), 2, 2, 4, 2) --CHEVEUX
		SetPedComponentVariation(GetPlayerPed(-1), 3, item.three[1], item.three[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 4, item.four[1], item.four[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 5, item.five[1], item.five[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 6, item.six[1], item.six[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 7, item.seven[1], item.seven[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 8, item.eight[1], item.eight[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 9, item.nine[1], item.nine[2], 2) --Dessus Armure / etc
		SetPedComponentVariation(GetPlayerPed(-1), 10, item.ten[1], item.ten[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 11, item.eleven[1], item.eleven[2], 2)

		--SetPedComponentVariation(GetPlayerPed(-1), 2, id, 0, 2)
		--SetPedComponentVariation(GetPlayerPed(-1), id, 50, 0, 2)
		--SetPedComponentVariation(GetPlayerPed(-1), 2, 2, 0, 2)
		local itemInfo = {item.three[1], item.three[2], item.four[1], item.four[2], item.six[1], item.six[2], item.seven[1], item.seven[2], item.eight[1], item.eight[2], item.eleven[1], item.eleven[2]}

		TriggerServerEvent("vmenu:getOutfit", itemInfo)
		Wait (10)
	end)
end)

AddEventHandler("vmenu:getclientHair", function(target, hair, hairsec, hairc, haircsec) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	TriggerServerEvent("vmenu:getHair", hair, hairsec, hairc, haircsec)
end)

AddEventHandler("vmenu:getclientFace", function(target, sex, face, face_text) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	TriggerServerEvent("vmenu:getFace", sex, face, face_text)
end)

AddEventHandler("vmenu:spawnVeh", function(target, model, bool) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	CreateThread(function()
		local carid = GetHashKey(model)
		local ped = GetPlayerPed(-1)
		RequestModel(carid)
		while not HasModelLoaded(carid) do
			Wait(0)
		end
		local p = GetEntityCoords(ped)
		p = p + vector3(0, 10, 0)
		local veh = CreateVehicle(carid, p.x, p.y, p.z, 0.0, true, false)
		TaskWarpPedIntoVehicle(ped, veh, -1)
		--MarkModelAsNoLongerNeeded(carid)
	end)
end)

RegisterNetEvent("vmenu:teleport_marker")
AddEventHandler("vmenu:teleport_marker", function(target, pos)
	CreateThread(function()
		local carid = GetHashKey(model)
		local e = GetPlayerPed(-1)
		local blip = GetFirstBlipInfoId(8)

		local success = false
		local groundFound = false
		local groundCheck = true
		local groundHeight = { 110.0, 150.0, 0.0, 90.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0 };
		local tpZ = 0.0
		if IsWaypointActive() then
			--local coords = GetBlipCoords(blip)
			--local a = {}
			local coords = {}
			if pos == nil then
				coords = Citizen.InvokeNative(0x586AFE3FF72D996E, blip, Citizen.ResultAsVector())
			else
				coords = pos
			end

			if IsPedInAnyVehicle(e, 0) then

				e = GetVehiclePedIsUsing(e)
				h = GetEntityModel(e)

				if IsThisModelABoat(h) then
					groundCheck = false
					tpZ = 0.0
				elseif (IsThisModelAPlane(h) or IsThisModelAHeli(h)) then
					groundCheck = false
					tpZ = 800.0
				end
			end
			if groundCheck then

				SetEntityCoordsNoOffset(e, coords.x, coords.y, tpZ, 0,  0,  1)

				for i = 1, #groundHeight do

					SetEntityCoordsNoOffset(e, coords.x, coords.y, groundHeight[i], 0,  0,  1)
					Wait(200)
					--local f = GetGroundZFor_3dCoord(coords.x, coords.y, groundHeight[i])
					local f = Citizen.InvokeNative(0xC906A7DAB05C8D2B,coords.x,coords.y,groundHeight[i],Citizen.PointerValueFloat(),0)
					if f then
						groundFound = true
						tpZ = f + 5.0
						break
					end

				end

				if not groundFound then
					GiveDelayedWeaponToPed(GetPlayerPed(-1),  GetHashKey("GADGET_PARACHUTE"),  100,  false)
					coords.z = tpZ
				end

			end
			SetEntityCoordsNoOffset(e, coords.x, coords.y, tpZ, 0,  0,  1)
			Wait(10)
		else
			DrawNotif("Aucun Marqueur trouvé.")
		end

	end)
end)
