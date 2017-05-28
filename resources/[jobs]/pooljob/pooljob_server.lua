RegisterServerEvent('job:success')
AddEventHandler('job:success', function(amount)
	-- Get the players money amount
TriggerEvent('es:getPlayerFromId', source, function(user)
  total = math.random(100, 500);
  -- update player money amount
  user:addMoney((total + tonumber(math.floor(amount)) + 0.0))
 end)
end)

RegisterServerEvent('job:GetIdentifier')
AddEventHandler('job:GetIdentifier', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local L = #player - 4
    local L1 = #player - 3
    local L2 = #player - 2
    local L3 = #player - 1
    local plate = "CTZN" .. player[L] .. player[L1] .. player[L2] .. player[L3]
    plate = string.upper(plate)
    user:setVehicle(plate)
    TriggerClientEvent("job:f_GetIdentifier", source, plate)
  end)
end)
