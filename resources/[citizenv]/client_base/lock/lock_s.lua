RegisterServerEvent('lock:getCar')
AddEventHandler('lock:getCar', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      TriggerClientEvent("lock:f_getCar", source, {user:getVehicle(), user:getJobVehicle()})
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)
