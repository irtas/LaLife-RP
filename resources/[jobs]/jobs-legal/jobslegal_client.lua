-- Initialize global jobs legal vars
onJobLegal = 0
EndingDay = false
myjob = 0
ShowMsgtime = { msg = "", time = 0 }

RegisterNetEvent("jobslegal:getJobs")
AddEventHandler("jobslegal:getJobs", function(job)
	myjob = job
end)


job = {
	plate = 0,
}

RegisterNetEvent("job:f_GetIdentifier")
AddEventHandler("job:f_GetIdentifier", function(plate)
	job.plate = plate
end)

	TriggerServerEvent("job:GetIdentifier")

AddEventHandler("playerSpawned", function()
	TriggerServerEvent("job:GetIdentifier")
end)

ArgentJoueur = 0

RegisterNetEvent("job:f_getCash")
AddEventHandler("job:f_getCash", function(argent)
  ArgentJoueur = argent
end)

AddEventHandler("job:getJobInfos", function()
  TriggerEvent("fivemenu:f_getJobInfos", onJobLegal)
end)

AddEventHandler("job:setJobInfos", function(param)
  onJobLegal = param
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if ShowMsgtime.time ~= 0 then
      drawTxtpool(ShowMsgtime.msg, 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
      ShowMsgtime.time = ShowMsgtime.time - 1
    end
  end
end)

RegisterNetEvent("jobslegal:updateonJobLegal")
AddEventHandler("jobslegal:updateonJobLegal", function(status)
  onJobLegal = status
end)

RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(text, time)
        ClearPrints()
        SetTextEntry_2("STRING")
        AddTextComponentString(text)
        DrawSubtitleTimed(time, 1)
end)

-- When the player have left the job he was doing.
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if onJobLegal == 2 then
      clearJob()
    end
  end
end)

function clearJob()
  if ( DoesEntityExist(MISSION.truck) ) then
    SetEntityAsNoLongerNeeded(MISSION.truck)
    SetVehicleDoorsLocked(MISSION.truck, 2)
    SetVehicleUndriveable(MISSION.truck, true)

    local temptruck = MISSION.truck

    MISSION.truck = 0

    Wait(2000)
    SetEntityAsMissionEntity(temptruck, true, true)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(temptruck))
  end
  onJobLegal = 0
  Citizen.Trace("Cleared")
  TriggerServerEvent("vmenu:lastChar")
  EndingDay = false
end
