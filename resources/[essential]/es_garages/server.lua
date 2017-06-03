require "resources/mysql-async/lib/MySQL"


--[[Register]]--

RegisterServerEvent('garages:CheckForSpawnVeh')
RegisterServerEvent('garages:CheckForVeh')
RegisterServerEvent('garages:SetVehOut')
RegisterServerEvent('garages:SetVehIn')
RegisterServerEvent('garages:PutVehInGarages')
RegisterServerEvent('garages:CheckGarageForVeh')
RegisterServerEvent('garages:CheckForSelVeh')
RegisterServerEvent('garages:SelVeh')



--[[Local/Global]]--

local vehicles = {}



--[[Events]]--

AddEventHandler('es:playerLoaded', function(source, user)
  TriggerEvent("garages:CheckGarageForVehFirst", user)
end)


AddEventHandler('garages:CheckForSpawnVeh', function(veh_id)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local veh_id = veh_id
    local player = user.identifier
    MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE identifier = @username AND ID = @ID",{['@username'] = player, ['@ID'] = veh_id}, function (result)
      if(result)then
        for k,v in ipairs(result)do
          vehicle = v.vehicle_model
          plate = v.vehicle_plate
          state = v.vehicle_state
          primarycolor = v.vehicle_colorprimary
          secondarycolor = v.vehicle_colorsecondary
          pearlescentcolor = v.vehicle_pearlescentcolor
          wheelcolor = v.vehicle_wheelcolor

          local vehicle = vehicle
          local plate = plate
          local state = state
          local primarycolor = primarycolor
          local secondarycolor = secondarycolor
          local pearlescentcolor = pearlescentcolor
          local wheelcolor = wheelcolor
        end
      end
      TriggerClientEvent('garages:SpawnVehicle', source, vehicle, plate, state, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
    end)
  end)
end)

AddEventHandler('garages:CheckForVeh', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local state = "Sorti"
    local player = user.identifier
    MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE identifier = @username AND vehicle_state =@state",{['@username'] = player, ['@vehicle'] = vehicle, ['@state'] = state}, function(result)
      if(result)then
        for k,v in ipairs(result)do
          vehicle = v.vehicle_model
          plate = v.vehicle_plate
          local vehicle = vehicle
          local plate = plate
        end
      end
      TriggerClientEvent('garages:StoreVehicle', source, vehicle, plate)
    end)
  end)
end)

AddEventHandler('garages:SetVehOut', function(vehicle, plate, car)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local vehicle = vehicle
    local state = "Sorti"
    local plate = plate
    user:setVehicle(plate)
    MySQL.Async.execute("UPDATE user_vehicle SET vehicle_state=@state WHERE identifier = @username AND vehicle_plate = @plate AND vehicle_model = @vehicle",
      {['@username'] = player, ['@vehicle'] = vehicle, ['@state'] = state, ['@plate'] = plate})
  end)
end)

AddEventHandler('garages:SetVehIn', function(plate)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local plate = plate
    local state = "Rentré"
    MySQL.Async.execute("UPDATE user_vehicle SET vehicle_state=@state WHERE identifier = @username AND vehicle_plate = @plate",
      {['@username'] = player, ['@plate'] = plate, ['@state'] = state})
  end)
end)

AddEventHandler('garages:PutVehInGarages', function(vehicle)
  TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = user.identifier
    local state ="Rentré"

    MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE identifier = @username",{['@username'] = player}, function (result)
      if(result)then
        for k,v in ipairs(result)do
          joueur = v.identifier
          local joueur = joueur
        end
      end

      if joueur ~= nil then
        MySQL.Async.execute("UPDATE user_vehicle SET `vehicle_state`=@state WHERE identifier = @username",
          {['@username'] = player, ['@state'] = state})
      end
    end)
  end)
end)

AddEventHandler('garages:CheckGarageForVehFirst', function(user)
  vehicles = {}
    local player = user.identifier
    print(player)
    MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE identifier = @username",{['@username'] = player}, function (result)
      if (result) then
        local i = 0
        for _, v in ipairs(result) do
          i = i + 1
          -- print(v.vehicle_model)
          -- print(v.vehicle_plate)
          -- print(v.vehicle_state)
          -- print(v.ID)
          t = { ["id"] = v.ID, ["vehicle_model"] = v.vehicle_model, ["vehicle_name"] = v.vehicle_name, ["vehicle_state"] = v.vehicle_state}
          table.insert(vehicles, tonumber(i), t)
        end
      end
      print(#vehicles)
      TriggerClientEvent('garages:getVehicles', source, vehicles)
  end)
    print(#vehicles)
    --print(vehicles[1].id)
    --print(vehicles[2].vehicle_model)
end)

AddEventHandler('garages:CheckGarageForVeh', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
  vehicles = {}
    local player = user.identifier
    print(player)
    MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE identifier = @username",{['@username'] = player}, function (result)
      if (result) then
        local i = 0
        for _, v in ipairs(result) do
          i = i + 1
          -- print(v.vehicle_model)
          -- print(v.vehicle_plate)
          -- print(v.vehicle_state)
          -- print(v.ID)
          t = { ["id"] = v.ID, ["vehicle_model"] = v.vehicle_model, ["vehicle_name"] = v.vehicle_name, ["vehicle_state"] = v.vehicle_state}
          table.insert(vehicles, tonumber(i), t)
        end
      end
      print(#vehicles)
      TriggerClientEvent('garages:getVehicles', source, vehicles)
  end)
    print(#vehicles)
    --print(vehicles[1].id)
    --print(vehicles[2].vehicle_model)
  end)
end)

AddEventHandler('garages:CheckForSelVeh', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local state = "Sorti"
    local player = user.identifier
    MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE identifier = @username AND vehicle_state =@state",{['@username'] = player, ['@vehicle'] = vehicle, ['@state'] = state}, function (result)
      if(result)then
        for k,v in ipairs(result)do
          vehicle = v.vehicle_model
          plate = v.vehicle_plate
          local vehicle = vehicle
          local plate = plate
        end
      end
      TriggerClientEvent('garages:SelVehicle', source, vehicle, plate)
    end)
  end)
end)


AddEventHandler('garages:SelVeh', function(plate, vehicle)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local plate = plate
    local vehicle = vehicle
    MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE identifier = @username AND vehicle_plate =@plate AND vehicle_model=@vehicle",{['@username'] = player, ['@vehicle'] = vehicle, ['@plate'] = plate}, function (result)
      if(result)then
        for k,v in ipairs(result)do
          price = v.vehicle_price
          local price = price / 2
          user:addMoney((price))
        end
      end
      MySQL.Async.execute("DELETE from user_vehicle WHERE identifier = @username AND vehicle_plate = @plate AND vehicle_model=@vehicle",
        {['@username'] = player, ['@plate'] = plate, ['@vehicle'] = vehicle})
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "Véhicule vendu!\n")
    end)
  end)
end)
