------------------------------ SCRIPT PARAMETERS CAN BE CHANGED BETWEEN ------------------------------

local distanceParam = 5 -- Change this value to change the distance needed to lock / unlock a vehicle
local key = 303 -- Change this value to change the key (List of values below)
local chatMessage = true -- Set to false for disable chatMessage
local playSound = true -- Set to false for disable sound when Lock/Unlock (To change the sounds, follow the instructions here : https://forum.fivem.net/t/release-locksystem/17750/5)

------------------------------ SCRIPT PARAMETERS CAN BE CHANGED BETWEEN ------------------------------

            ------------------------------ KEY LIST HERE ------------------------------

--[[    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
        ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
        ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
        ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
        ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
        ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
        ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
        ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
        ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118    ]]

            ------------------------------ KEY LIST HERE -----------------------------

---------------------------------------------------------------------------------------------------------------
------------------------------ Don't touch after that if you are not a developer ------------------------------
---------------------------------------------------------------------------------------------------------------
function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

local Lock =
{ car = nil,
  posCar = 0
}

function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end

RegisterNetEvent("lock:f_getCar")
AddEventHandler('lock:f_getCar', function(vehicle)
    Lock.car = vehicle[1]
end)

Citizen.CreateThread(function()
    while true do
        Wait(10)

        if IsControlJustPressed(1, key) then
            TriggerServerEvent("lock:getCar")
            Wait(300)
            local player = GetPlayerPed(-1)

            local playerPos = GetEntityCoords( GetPlayerPed(-1), 1 )
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( GetPlayerPed(-1), 0.0, 10.000, 0.0 )
            local v = GetVehicleInDirection( playerPos, inFrontOfPlayer )

            local platev = GetVehicleNumberPlateText(v)
            if DoesEntityExist(v) then
              platev = GetVehicleNumberPlateText(v)
            else
              v = GetVehiclePedIsIn(GetPlayerPed(-1), true)
              if DoesEntityExist(v) then
                platev = GetVehicleNumberPlateText(v)
              end
            end
            local platec = Lock.car
            Wait(100)
            if platec == platev then
                posCar = GetEntityCoords(v, false)
                carX, carY, carZ = posCar.x, posCar.y, posCar.z

                posPlayer = GetEntityCoords(player, false)
                playerX, playerY, playerZ = posPlayer.x, posPlayer.y, posPlayer.z
            end
            Wait(100)
            if platec == nil then

                if chatMessage then
                    DrawNotif("Tu n'as pas de véhicule.")
                end

            elseif platec == platev then

                distanceBetweenVehPlayer = GetDistanceBetweenCoords(carX, carY, carZ, playerX, playerY, playerZ, false)
                --IsPedGettingIntoAVehicle(player)
                --Citizen.Trace("Vous essayez d'entrer dans le véhicule")

                if distanceBetweenVehPlayer <= distanceParam then
                    lockStatus = GetVehicleDoorLockStatus(v)

                    if lockStatus == 1 or lockStatus == 0 then

                        engineValue = IsPedInAnyVehicle(player)
                        lockStatus = SetVehicleDoorsLocked(v, 2)

                        SetVehicleDoorsLockedForPlayer(v, PlayerId(), false)

                        if chatMessage then
                            DrawNotif("Vehicule ~r~verrouillé~s~.")
                        end

                        if playSound then
                            TriggerEvent('InteractSound_CL:PlayOnOne', 'lock', 1.0)
                        end

                        if not engineValue then
                            SetVehicleEngineOn(v, false, false, true)
                        end

                    else

                        lockStatus = SetVehicleDoorsLocked(v, 1)

                        if chatMessage then
                            DrawNotif("Vehicule ~g~déverrouillé~s~.")
                        end

                        if playSound then
                            TriggerEvent('InteractSound_CL:PlayOnOne', 'unlock', 1.0)
                        end

                    end

                else

                    if chatMessage then
                        DrawNotif("Vous êtes trop loin de votre véhicule.")
                    end

                end
            end
        end
    end
end)
