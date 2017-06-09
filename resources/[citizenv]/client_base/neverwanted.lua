Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if GetPlayerWantedLevel(PlayerId()) ~= 0 then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
            SetPoliceIgnorePlayer(PlayerId(), true)
            SetDispatchCopsForPlayer(PlayerId(), false)
            SetDitchPoliceModels()
        end

        local playerPed = GetPlayerPed(-1)
        local playerLocalisation = GetEntityCoords(playerPed)
        ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
    end
end)


-- Anti car jack
-- 
-- Citizen.CreateThread(function()
--     while true do
--         if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
--             local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
--             local lock = GetVehicleDoorLockStatus(veh)
--
--             if lock == 7 then
--                 SetVehicleDoorsLocked(veh, 2)
--             end
--
--             local pedd = GetPedInVehicleSeat(veh, -1)
--
--             if pedd then
--                 SetPedCanBeDraggedOut(pedd, false)
--             end
--         end
--         Citizen.Wait(0)
--     end
-- end)
