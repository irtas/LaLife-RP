-- PART OF THE CODE IS IN LOGIN.LUA. BECAUSE TELIST ARRAY IS IN THERE.
-- RegisterServerEvent("tel:sendingMsg")
-- SIMPLIER TO PUT THE CODE THERE.
-- PLEASE DON'T BE MAD ABOUT PROGRAMMING CONCEPT. AT LEAST THERE IS A COMMENT HERE.

RegisterServerEvent("tel:addingTel")
AddEventHandler("tel:addingTel", function(addTel)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE telephone = '@telnum'", {['@telnum'] = addTel})
		local result = MySQL:getResults(executed_query, {'nom', 'prenom'}, "identifier")

		if(result[1] ~= nil) then
			identifier = user.identifier
			MySQL:executeQuery("INSERT INTO phonebook (`pidentifier`, `phonenumber`) VALUES ('@username', '@telnum')",
			{['@username'] = identifier, ['@telnum'] = addTel})
			TriggerEvent("es:getPhonebook", source)
			TriggerClientEvent("es_freeroam:notif", source, "~g~ Contact ajouté" .. " " .. result[1].prenom .. " " .. result[1].nom)
		else
			TriggerClientEvent("es_freeroam:notif", source, "~r~ Aucun joueur ne possède ce numéro")
		end
	end)
end)
