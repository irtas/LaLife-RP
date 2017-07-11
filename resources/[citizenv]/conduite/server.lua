require "resources/mysql-async/lib/MySQL"



function GivePermisAuto(identifier)
	return MySQL.Sync.fetchScalar("INSERT into user_permis (id_permis , identifier) values (1, @identifier) ",{['@identifier'] = identifier})
end
function RetirerPermisAuto(identifier)
	return MySQL.Sync.fetchScalar("DELETE FROM user_permis WHERE identifier = @identifier and id_permis = 1 ",{['@identifier'] = identifier})
end



RegisterServerEvent('conduite:verifpermis')
AddEventHandler('conduite:verifpermis',function()
TriggerEvent('es:getPlayerFromId', source, function(user)
	 local player = user.identifier
	 MySQL.Async.fetchAll("SELECT * FROM user_permis WHERE id_permis = 1 and identifier =@identifier ", {['@identifier'] = player}, function(result)
	 
	 if(result[1] ~= nil) then
	 	print(result[1].id_permis)

	 TriggerClientEvent("conduite:getPermisauto", source, result[1].id_permis)

	else
	

	end
	end) 

end)
end)


RegisterServerEvent('conduite:retierpermisauto')
AddEventHandler('conduite:retierpermisauto',function(netID)
TriggerEvent('es:getPlayerFromId',netID, function(user)
  local tIdentifier = GetPlayerIdentifiers(netID)
  local identifier = tIdentifier[1]
  RetirerPermisAuto(identifier)
   TriggerClientEvent("citizenv:notify", source, "CHAR_AMANDA", 1, "Mairie", false, "Le permis auto a été ~r~supprimé ~w~! ")
   TriggerClientEvent("citizenv:notify", netID, "CHAR_AMANDA", 1, "Mairie", false, "Votree permis auto a été ~r~supprimé ~w~! ")


end)
end)




RegisterServerEvent('conduite:donnerpermisauto')
AddEventHandler('conduite:donnerpermisauto',function()
TriggerEvent('es:getPlayerFromId', source, function(user)
  local player = user.identifier
  GivePermisAuto(player)
   TriggerClientEvent("citizenv:notify", source, "CHAR_AMANDA", 1, "Mairie", false, "Votre permis auto a été réceptionné ! ")

end)
end)


RegisterServerEvent("conduite:getCash_s")
AddEventHandler("conduite:getCash_s", function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local argent = user:getMoney()
      TriggerClientEvent("conduite:f_getCash", source, argent)
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

