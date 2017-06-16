require "resources/mysql-async/lib/MySQL"

RegisterServerEvent('CheckMoneyForVeh')
RegisterServerEvent('BuyForVeh')
RegisterServerEvent('vehshop:GetIdentifier')

AddEventHandler('CheckMoneyForVeh', function(name, vehicle, price)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local player = user.identifier
      local vehicle = vehicle
      local name = name
      local price = tonumber(price)

      MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE identifier = @username",{['@username'] = player}, function (result)
        if (result) then
          count = 0
          for _ in pairs(result) do
            count = count + 1
          end
          if count == 5 then
            TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "Garage plein!\n")
          else
            if (tonumber(user.money) >= tonumber(price)) then
              user:removeMoney((price))
              TriggerClientEvent('FinishMoneyCheckForVeh', source, name, vehicle, price)
              TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "Bonne route!\n")
            else
              TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "Fonds insuffisants!\n")
            end
          end
        else
          if (tonumber(user.money) >= tonumber(price)) then
            user:removeMoney((price))
            TriggerClientEvent('FinishMoneyCheckForVeh', source, name, vehicle, price)
            TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "Bonne route!\n")
          else
            TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "Fonds insuffisants!\n")
          end
        end
      end)
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

AddEventHandler('BuyForVeh', function(name, vehicle, price, plate, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local player = user.identifier
      local name = name
      local price = price
      local vehicle = vehicle
      user:setVehicle(plate)
      local state = "Sorti"
      local primarycolor = primarycolor
      local secondarycolor = secondarycolor
      local pearlescentcolor = pearlescentcolor
      local wheelcolor = wheelcolor
      MySQL.Async.execute("INSERT INTO user_vehicle (`identifier`, `vehicle_name`, `vehicle_model`, `vehicle_price`, `vehicle_plate`, `vehicle_state`, `vehicle_colorprimary`, `vehicle_colorsecondary`, `vehicle_pearlescentcolor`, `vehicle_wheelcolor`) VALUES (@username, @name, @vehicle, @price, @plate, @state, @primarycolor, @secondarycolor, @pearlescentcolor, @wheelcolor)",
      {['@username'] = player, ['@name'] = name, ['@vehicle'] = vehicle, ['@price'] = price, ['@plate'] = plate, ['@state'] = state, ['@primarycolor'] = primarycolor, ['@secondarycolor'] = secondarycolor, ['@pearlescentcolor'] = pearlescentcolor, ['@wheelcolor'] = wheelcolor})
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

AddEventHandler('vehshop:GetIdentifier', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local player = user.identifier
      local L = #player - 4
      local L1 = #player - 3
      local L2 = #player - 2
      local L3 = #player - 1
      local plate = "CTZN" .. player[L] .. player[L1] .. player[L2] .. player[L3]
      plate = string.upper(plate)
      TriggerClientEvent("vehshop:f_GetIdentifier", source, plate)
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)
