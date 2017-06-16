require "resources/mysql-async/lib/MySQL"

local max_number_weapons = 6 --maximum number of weapons that the player can buy. Weapons given at spawn doesn't count.
local cost_ratio = 100 --Ratio for withdrawing the weapons. This is price/cost_ratio = cost.

RegisterServerEvent('CheckMoneyForWea')
AddEventHandler('CheckMoneyForWea', function(weapon,price)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (user) then
			if (tonumber(user.money) >= tonumber(price)) then
				local player = user.identifier
				local nb_weapon = 0
				MySQL.Async.fetchAll("SELECT * FROM user_weapons WHERE identifier = @username",{['@username'] = player}, function (result)
					if result then
						for k,v in ipairs(result) do
							nb_weapon = nb_weapon + 1
						end
					end
					if (tonumber(max_number_weapons) > tonumber(nb_weapon)) then
						-- Pay the shop (price)
						user:removeMoney((price))
						MySQL.Async.execute("INSERT INTO user_weapons (identifier,weapon_model,withdraw_cost) VALUES (@username,@weapon,@cost)",
						{['@username'] = player, ['@weapon'] = weapon, ['@cost'] = (price)/cost_ratio})
						-- Trigger some client stuff
						TriggerClientEvent('FinishMoneyCheckForWea',source)
						TriggerClientEvent("citizenv:notify", source, "CHAR_AMMUNATION", 1, "AMMUNATION", false, "Amuse toi bien avec ces joujous!\n")
					else
						TriggerClientEvent('ToManyWeapons',source)
						TriggerClientEvent("citizenv:notify", source, "CHAR_AMMUNATION", 1, "AMMUNATION", false, "Tu as atteint la limite d armes ! (max: "..max_number_weapons..")\n")
					end
				end)
			else
				-- Inform the player that he needs more money
				TriggerClientEvent("citizenv:notify", source, "CHAR_AMMUNATION", 1, "AMMUNATION", false, "Reviens quand tu auras plus d'argent !\n")
			end
		else
			TriggerEvent("es:desyncMsg")
		end
	end)
end)

RegisterServerEvent("weaponshop:playerSpawned")
AddEventHandler("weaponshop:playerSpawned", function(spawn)
	TriggerEvent('weaponshop:GiveWeaponsToPlayer', source)
end)

-- NOTE: Ajouter une fonction pour remove l arme à la mort du joueur in game et in db

RegisterServerEvent("weaponshop:GiveWeaponsToPlayer")
AddEventHandler("weaponshop:GiveWeaponsToPlayer", function(player)
	TriggerEvent('es:getPlayerFromId', player, function(user)
		if (user) then
			local playerID = user.identifier
			local delay = nil

			MySQL.Async.fetchAll("SELECT * FROM user_weapons WHERE identifier = @username",{['@username'] = playerID}, function (result)
				delay = 2000
				if(result)then
					for k,v in ipairs(result) do
						TriggerClientEvent("giveWeapon", player, v.weapon_model, delay)
					end
				end
			end)
		else
			TriggerEvent("es:desyncMsg")
		end
	end)
end)
