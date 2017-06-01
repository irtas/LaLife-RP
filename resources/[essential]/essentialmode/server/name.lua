require "resources/mysql-async/lib/MySQL"

RegisterServerEvent('es:updateName')
AddEventHandler('es:updateName', function(prenom, nom)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		user:setNom(nom)
		user:setPrenom(prenom)
    local player = user.identifier
		MySQL.Async.execute("UPDATE users SET `nom`=@value WHERE identifier = @identifier", {['@value'] = nom, ['@identifier'] = player})
		MySQL.Async.execute("UPDATE users SET `prenom`=@value WHERE identifier = @identifier", {['@value'] = prenom, ['@identifier'] = player})
  end)
end)

RegisterServerEvent('es:getName')
AddEventHandler('es:getName', function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local fullname = user:getPrenom() .. " " .. user:getNom()
    TriggerClientEvent("es:f_getName", source, fullname)
  end)
end)
