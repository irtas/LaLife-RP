require "resources/mysql-async/lib/MySQL"

AddEventHandler('onResourceStart', function(resource)
  if resource == "es_afterStart" then
    MySQL.Async.execute("UPDATE user_vehicle SET `vehicle_state`=@value WHERE `vehicle_state`='Sorti'",
    {['@value'] = "Rentré"})
  end
end)
