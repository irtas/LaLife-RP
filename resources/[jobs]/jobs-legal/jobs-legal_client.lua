myjob = 0
ShowMsgtime = { msg = "", time = 0 }

RegisterNetEvent("jobs-legal:getJobs")
AddEventHandler("jobs-legal:getJobs", function(job)
	myjob = job
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
