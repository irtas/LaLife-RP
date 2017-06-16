RegisterServerEvent('truckerJob:addMoney')
AddEventHandler('truckerJob:addMoney', function(amount)
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
