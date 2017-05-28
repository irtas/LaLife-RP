require "resources/[essential]/essentialmode/lib/MySQL"
MySQL:open(database.host, database.name, database.username, database.password)

-- local VMenu = {
-- 	[1] = {
-- 	-- ["keys"] = {172, 173, 174, 175, 18, 177},
-- 	["mopenKey"] = 168,
--  	["openKey"] = 167,
-- 	["top"] = 0.01,
-- 	["left"] = 0.01,
-- 	["width"] = 0.25,
-- 	["itemsOnScreen"] = 9,
-- 	["HeaderDict"] = "fivemenu",
-- 	["rootMenu"] = 98,
-- 	["voiceTarget"] = true,
-- 	["checkUser"] = false,
-- 	["updatedChar"] = true,
-- 	["mainMenu"] = false,
-- 	["store"] = false,
-- 	["barbershop"] = false,
-- 	["hospital"] = false,
-- 	["outfitshop"] = false,
-- 	["garagepolice"] = false,
-- 	["lockerpolice"] = false,
-- 	["Tanker_company"] = false,
-- 	["Container_company"] = false,
-- 	["Frigorifique_company"] = false,
-- 	["Log_company"] = false,
-- 	["police"] = false,
-- 	["jobs"] = false,
-- 	-- ["Cuffedkeys"] = {167, 168},
-- 	["visible"] = false,
-- 	["curMenu"] = 0,
-- 	["prevMenu"] = 0,
-- 	["curItem"] = 1,
-- 	["scroll"] = 0,
-- 	["closedTime"] = 0,
-- 	["offsetY"] = 0.03,
-- 	["HdHeight"] = 0,
-- 	["BgHeight"] = 0.314,
-- 	-- ["menus"] = {},
-- 	-- ["items"] = {},
-- 	-- ["disableKeys"] = { 19, 20, 43, 48, 187, 233, 309, 311, 85, 74, 21, 73, 121, 45, 80, 140, 170, 177, 194, 202, 225, 263},
-- 	["target"] = -1,
-- 	["debugKeys"] = false,
-- 	["ctop"] = 0}
-- }

--asd
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
				TriggerEvent('es:getPlayerFromIdentifier', user.identifier, function(user)
					MenuOpts.user = user
				end)
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

	TriggerEvent('es:getPlayerFromId', source, function(user)
		if user ~= nil then
			TriggerEvent('es:getPlayerFromIdentifier', user.identifier, function(user)
				userInfos = user
			end)
			userInfos["vehicle"] = user:getVehicle()
			userInfos["telephone"] = user:getTel()
			userInfos["enService"] = user:getenService()
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
-- RegisterServerEvent('vmenu:updateCar')
-- AddEventHandler('vmenu:updateCar', function(openMenu)
-- 	--print("-[FiveMenu]- Updating User...")
-- 	local userInfos = {}
-- 	TriggerEvent('es:getPlayerFromId', source, function(user)
-- 		if user ~= nil then
-- 			--TriggerEvent('es:getPlayerFromIdentifier', user.identifier, function(user)
-- 				userInfos = user:getVehicle()
-- 			--end)
-- 		end
-- 	end)
-- 	-- Envoie des données et Ouverture du Menu...
-- 	TriggerClientEvent("vmenu:setCarUser", source, userInfos)
-- end)
