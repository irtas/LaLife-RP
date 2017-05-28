Citizen.CreateThread(function()
	while true do
		Wait( 1 )

		-- show blips
		for id = 0, 32 do
			if NetworkIsPlayerActive( id ) then -- and GetPlayerPed( id ) ~= GetPlayerPed( -1 )

				ped = GetPlayerPed( id )
				--blip = GetBlipFromEntity( ped )

				-- HEAD DISPLAY STUFF --

				-- Create head display (this is safe to be spammed)
				if GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
						headDisplayId = N_0xbfefe3321a3f5015(ped, ".", false, false, "", false )
				else
					headDisplayId = N_0xbfefe3321a3f5015(ped, "", false, false, "", false )
				end

				if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(GetPlayerPed(id))) < 30.0001) and HasEntityClearLosToEntity(GetPlayerPed(-1),  GetPlayerPed(id),  17) then
					N_0x63bb75abedc1f6a0(headDisplayId, 0, true)
					N_0xd48fe545cd46f857(headDisplayId, 0, 255)
				else
					N_0x63bb75abedc1f6a0(headDisplayId, 0, false)
				end

				if NetworkIsPlayerTalking(id) then
					N_0x63bb75abedc1f6a0(headDisplayId, 4, true) -- Speaker
					N_0xd48fe545cd46f857(headDisplayId, 4, 128) -- Alpha
				else
					N_0x63bb75abedc1f6a0(headDisplayId, 4, false) -- Speaker Off
				end
			end
		end
	end
end)

--[[
Markers List
http://www.dev-c.com/nativedb/func/info/63bb75abedc1f6a0#fntrg-63bb75abedc1f6a0

]]
