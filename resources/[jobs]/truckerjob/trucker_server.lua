RegisterServerEvent('truckerJob:addMoney')
AddEventHandler('truckerJob:addMoney', function(amount)
  -- Get the players money amount
  TriggerEvent('es:getPlayerFromId', source, function(user)
    total = math.random(100, 500);
    -- update player money amount
    user:addMoney((total + tonumber(math.floor(amount)) + 0.0))
  end)
end)
