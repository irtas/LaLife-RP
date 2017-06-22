RegisterServerEvent('job:success')
AddEventHandler('job:success', function(amount)
  -- Get the players money amount
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      total = math.random(100, 500);
      -- update player money amount
      user:addMoney((total + tonumber(math.floor(amount)) + 0.0))
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent('job:removeMoney')
AddEventHandler('job:removeMoney', function(amount)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local rounded = round(math.abs(tonumber(amount)), 0)
      user:removeMoney(rounded)
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent('job:addMoney')
AddEventHandler('job:addMoney', function(amount)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local rounded = round(math.abs(tonumber(amount)), 0)
      user:addMoney(rounded)
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent("job:getCash_s")
AddEventHandler("job:getCash_s", function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local argent = user:getMoney()
      TriggerClientEvent("job:f_getCash", source, argent)
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent('job:GetIdentifier')
AddEventHandler('job:GetIdentifier', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local player = user.identifier
      local L = #player - 4
      local L1 = #player - 3
      local L2 = #player - 2
      local L3 = #player - 1
      local plate = "JOBS" .. player[L] .. player[L1] .. player[L2] .. player[L3]
      plate = string.upper(plate)
      user:setJobVehicle(plate)
      TriggerClientEvent("job:f_GetIdentifier", source, plate)
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.abs(math.floor(num * mult + 0.5) / mult)
end
