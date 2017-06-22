local corp = 0;

RegisterServerEvent("org:addcorp")
AddEventHandler("org:addcorp", function()
  corp = corp + 1
end)

RegisterServerEvent("org:remcorp")
AddEventHandler("org:remcorp", function()
    corp = corp - 1
end)

RegisterServerEvent("org:getcorp")
AddEventHandler("org:getcorp", function()
  TriggerClientEvent("org:f_getcorp",source,corp)
end)
