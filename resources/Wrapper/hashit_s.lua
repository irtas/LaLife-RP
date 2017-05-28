RegisterServerEvent("hashit:draziak_s")
AddEventHandler('hashit:draziak_s', function()
  TriggerClientEvent('hashit:draziak', source, 5)
end)
