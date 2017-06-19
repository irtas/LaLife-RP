function drawNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end

RegisterNetEvent("itinerance:notif")
AddEventHandler('itinerance:notif', function(lestring)
  drawNotification("" .. lestring .. "")
end)
