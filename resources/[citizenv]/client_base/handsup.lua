Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlPressed(1, 323) and IsPedOnFoot(PlayerPedId()) then -- Touche X
			TaskHandsUp(GetPlayerPed(-1), 1000, 0, -1, true)
		end
	end
end)
