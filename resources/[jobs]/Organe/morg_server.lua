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

RegisterServerEvent("org:plate")
AddEventHandler("org:plate", function()
  local gui = GetPlayerIdentifiers(source);
  local Identifiers = gui[1]
  local lenght = string.len(Identifiers)
  local plate = 'JOBS'..Identifiers[lenght-4]..Identifiers[lenght-3]..Identifiers[lenght-2]..Identifiers[lenght-1]
  local plateUpper = string.upper(plate)
  print(plateUpper)
  TriggerClientEvent("org:f_plate",source, tostring(plateUpper))
end)
