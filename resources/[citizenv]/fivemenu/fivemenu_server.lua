RegisterServerEvent('vmenu:getUpdates')
AddEventHandler('vmenu:getUpdates', function(openMenu)
	--print("-[FiveMenu]- Updating Menu...")
	-- Requêtes SQL ou autre ici...
	MenuOpts = {
		BottlesNumber = 42,
	}
	if openMenu then
		MenuOpts.openMenu = true
	else
		TriggerEvent('es:getPlayerFromId', source, function(user)
			if user ~= nil then
				-- TriggerEvent('es:getPlayerFromIdentifier', user.identifier, function(user)
				-- 	MenuOpts.user = user
				-- end)
			end
		end)
	end
	--------------------------------

	MenuOpts.firstLoad = true
	-- Envoie des données et Ouverture du Menu...
	TriggerClientEvent("vmenu:serverOpenMenu", source, MenuOpts)

end)

RegisterServerEvent('vmenu:updateUser')
AddEventHandler('vmenu:updateUser', function(openMenu)
	--print("-[FiveMenu]- Updating User...")

	local userInfos = {}

	-- Spawned = false,
	-- Loaded = false,
	-- group = "0",
	-- permission_level = 0,
	-- money = 0,
	-- dirtymoney = 0,
	-- job = 0,
	-- police = 0,
	-- enService = 0,
	-- nom = "",
	-- prenom = "",
	-- vehicle = "",
	-- identifier = nil,
	-- telephone = ""
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if user ~= nil then
			userInfos["group"] = user.group.group
			userInfos["permission_level"] = user.permission_level
			userInfos["money"] = user:getMoney()
			userInfos["dirtymoney"] = user:getDMoney()
			userInfos["job"] = user:getJob()
			userInfos["police"] = user:getPolice()
			userInfos["nom"] = user:getNom()
			userInfos["prenom"] = user:getPrenom()
			userInfos["vehicle"] = user:getVehicle()
			userInfos["telephone"] = user:getTel()
			userInfos["identifier"] = user.identifier
		end
	end)
	--print(userInfos.identifier)
	--print(userInfos.group)
	--print(userInfos.police)
	userInfos.Loaded = true
	-- Envoie des données et Ouverture du Menu...
	TriggerClientEvent("vmenu:setUser", source, userInfos)
end)

RegisterServerEvent('es:getVehPlate_s')
AddEventHandler('es:getVehPlate_s', function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerClientEvent("es:f_getVehPlate", source, user:getVehicle())
	end)
end)

function round(num, numDecimalPlaces)
	local mult = 5^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

RegisterServerEvent("vmenu:cleanCash_s")
AddEventHandler("vmenu:cleanCash_s", function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local dcash = tonumber(user:getDMoney())
		local cash = tonumber(user:getMoney())
		local washedcash = dcash * 0.3
		user:setDMoney(0)
		local total = cash + round(washedcash)
		user:setMoney(total)
	end)
end)
