RegisterServerEvent("mine:addmoney")
AddEventHandler("mine:addmoney", function(iprice)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      user:addMoney(tonumber(iprice))
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent("mine:getCash_s")
AddEventHandler("mine:getCash_s", function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local argent = user:getMoney()
      TriggerClientEvent("mine:f_getCash", source, argent)
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)
