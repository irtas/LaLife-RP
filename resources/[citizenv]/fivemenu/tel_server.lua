-- PART OF THE CODE IS IN LOGIN.LUA. BECAUSE TELIST ARRAY IS IN THERE.
-- RegisterServerEvent("tel:sendingMsg")
-- SIMPLIER TO PUT THE CODE THERE.
-- PLEASE DON'T BE MAD ABOUT PROGRAMMING CONCEPT. AT LEAST THERE IS A COMMENT HERE.
require "resources/mysql-async/lib/MySQL"

RegisterServerEvent("tel:addingTel")
AddEventHandler("tel:addingTel", function(addTel)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (user) then
			MySQL.Async.fetchAll("SELECT * FROM users WHERE telephone = @telnum", {['@telnum'] = addTel}, function(result)
				if(result[1] ~= nil) then
					identifier = user.identifier
					MySQL.Async.execute("INSERT INTO phonebook (`pidentifier`, `phonenumber`) VALUES (@username, @telnum)", {['@username'] = identifier, ['@telnum'] = addTel})
					TriggerEvent("es:getPhonebook", source)
					TriggerClientEvent("itinerance:notif", source, "~g~ Contact ajouté" .. " " .. result[1].prenom .. " " .. result[1].nom)
				else
					TriggerClientEvent("itinerance:notif", source, "~r~ Aucun joueur ne possède ce numéro")
				end
			end)
		else
			TriggerEvent("es:desyncMsg")
		end
	end)
end)
