-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- I TOUCHED IT KANERSPS, PLEASE DON'T RAGE AT ME FOR THIS, DRAZIAK --

-- Loading MySQL Class
require "resources/mysql-async/lib/MySQL"

telist = {}

-- tel = { name, surname, identifier, IDsource }

-- -- THIS IS CALLED AFTER THE CHARACTER CREATION.
-- -- WE NEED TO UPDATE HIS NAME BECAUSE CITIZEN CITIZEN IS NOT A DECENT NAME FOR SOMEONE!
-- -- I AM WRITING SINGLE COMMENT LINE
-- RegisterServerEvent("es:loadAfterCreation")
-- AddEventHandler("es:loadAfterCreation", function()
-- 	TriggerEvent('es:getPlayerFromId', source, function(user)
-- 		local player = user.identifier
-- 		MySQL.Async.fetchScalar("SELECT telephone FROM users WHERE identifier = @name", {['@name'] = player}, function (telephone)
-- 			telist[telephone] = { IDsource = source }
-- 		end)
--   end)
-- end)

local countItems = MySQL.Sync.fetchScalar("SELECT COUNT(1) FROM items")

RegisterServerEvent("es:deleteTelist")
AddEventHandler("es:deleteTelist", function(source)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (user) then
			tel = user:getTel()
			telist[tel].IDsource = nil
		else
			TriggerEvent("es:desyncMsg")
		end
	end)
end)

AddEventHandler('playerDropped', function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (user) then
			tel = user:getTel()
			telist[tel].IDsource = nil

			MySQL.Async.execute("UPDATE users SET `money`=@value WHERE identifier = @identifier",
			{['@value'] = user.money, ['@identifier'] = user.identifier})

			MySQL.Async.execute("UPDATE users SET `dirtymoney`=@value WHERE identifier = @identifier",
			{['@value'] = user.dirtymoney, ['@identifier'] = user.identifier})

			MySQL.Async.execute("UPDATE coordinates SET `x`=@valx,`y`=@valy,`z`=@valz WHERE identifier = @identifier",
			{['@valx'] = user.coords.x, ['@valy'] = user.coords.y, ['@valz'] = user.coords.z, ['@identifier'] = user.identifier})
		else
			TriggerEvent("es:desyncMsg")
		end
	end)
end)

RegisterServerEvent("es:getPhonebook")
AddEventHandler("es:getPhonebook", function(source)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (user) then
			LoadPhonebook(user.identifier, source)
		else
			TriggerEvent("es:desyncMsg")
		end
	end)
end)

function LoadPhonebook(identifier, source)
	local phonebook = {}
	MySQL.Async.fetchAll("SELECT * FROM phonebook JOIN users ON `phonebook`.`phonenumber` = `users`.`telephone` WHERE pidentifier = @username", { ['@username'] = identifier }, function (result)
		if (result) then
			for a, v in pairs(result) do
				t = { ["nom"] = v.nom, ["prenom"] = v.prenom, ["identifier"] = a}
				table.insert(phonebook, v.phonenumber, t)
			end
		end

		TriggerClientEvent("tel:getPhonebook", source, phonebook)
	end)
end

-- THIS IS THE WHERE WE LOAD THE INFO FROM THE DATABASE. IF YOU NEED IT IN THE MENU -> fivemenu
-- DON'T FORGET THE PLAYER CLASS! CREATE YOUR GETTER AND SETTER BOI!
function LoadUser(identifier, source, new)
	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @name", {['@name'] = identifier}, function (result)
		MySQL.Async.fetchAll("SELECT * FROM coordinates WHERE identifier = @name", {['@name'] = identifier}, function (result1)
			local group = groups[result[1].group]
			Users[source] = Player(source, result[1].permission_level, result[1].money, result[1].identifier, group, result[1].dirtymoney, result[1].job, result[1].police, result[1].nom, result[1].prenom, result[1].telephone, { x = result1[1].x, y = result1[1].y, z = result1[1].z})

			local playerCountItems = MySQL.Sync.fetchScalar("SELECT COUNT(1) FROM user_inventory WHERE user_id = @username", { ['@username'] = identifier })
			if playerCountItems ~= countItems then
				for i=playerCountItems+1,countItems do
					MySQL.Async.execute("INSERT INTO user_inventory (`user_id`, `item_id`, `quantity`) VALUES (@username, @item_id, '0')",
					{['@username'] = identifier, ['@item_id'] = i})
				end
			end

			-- THE ARRAY THAT WE WILL USE TO COMMUNICATE WITH CELLPHONE, OMAGGAD TECHNOLOGY
			telist[result[1].telephone] = { IDsource = source }

			-- LOADING THE PHONEBOOK OF THE PLAYER
			LoadPhonebook(identifier, source)

			-- LOADING STUFF AFTER LOADING PLAYER

			TriggerEvent('es:playerLoaded', source, Users[source])
			TriggerClientEvent("es:finishedLoading", source)

			if(true)then
				TriggerClientEvent('es:setPlayerDecorator', source, 'rank', Users[source]:getPermissions())
			end

			if(true)then
				TriggerEvent('es:newPlayerLoaded', source, Users[source])
			end
		end)
	end)
end

function stringsplit(self, delimiter)
	local a = self:Split(delimiter)
	local t = {}

	for i = 0, #a - 1 do
		table.insert(t, a[i])
	end

	return t
end

-- PLEASE I HOPE WE CODED THIS FOR NOTHING.
function isIdentifierBanned(id)
	local result = MySQL.Sync.fetchAll("SELECT * FROM bans WHERE banned = @name", {['@name'] = id})
	if(#result > 0)then
		return true
	end

	return false
end

AddEventHandler('es:getPlayers', function(cb)
	cb(Users)
end)

-- GET ONE
function hasAccount(identifier, callback)
	local result = MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @name", {['@name'] = identifier}, function (result)
		if(result[1] ~= nil) then
			callback(true)
		else
			callback(false)
		end
	end)
end

-- YOU MUST
function isLoggedIn(source)
	if(Users[GetPlayerName(source)] ~= nil)then
		if(Users[GetPlayerName(source)]['isLoggedIn'] == 1) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- REGISTER FOR LE DB
function registerUser(identifier, source)
	hasAccount(identifier, function (result)
		if not result then
			--Telephone number
			local telephone = tostring(generateTel(identifier))

			-- Inserting Default User Account Stats
			MySQL.Async.execute("INSERT INTO users (`identifier`, `permission_level`, `money`, `group`, `nom`, `prenom`, `telephone`) VALUES (@username, '0', @money, 'user', 'Citizen', 'Citizen', @telephone)",
			{['@username'] = identifier, ['@telephone'] = telephone, ['@money'] = settings.defaultSettings.startingCash})

			MySQL.Async.execute("INSERT INTO coordinates (`identifier`,`x`,`y`,`z`) VALUES (@identifier, @valx, @valy, @valz)",
			{['@valx'] = settings.defaultSettings.spawnx, ['@valy'] = settings.defaultSettings.spawny, ['@valz'] = settings.defaultSettings.spawnz, ['@identifier'] = identifier})

			-- SKIN PAR DÉFAUT
			-- USELESS BUT NEEDED
			MySQL.Async.execute("INSERT INTO outfits (`identifier`, `skin`, `face`, `face_text`, `hair`, `hair_text`, `pants`, `pants_text`, `shoes`, `shoes_text`, `torso`, `torso_text`, `shirt`, `shirt_text`, `three`, `three_text`, `seven`, `seven_text`) VALUES (@username, 'mp_m_freemode_01', '0', '0', '-1', '-1', '24', '5', '18', '0', '29', '5', '31', '0', '12', '0', '29', '2')",
			{['@username'] = identifier, ['@money'] = settings.defaultSettings.startingCash})

			-- INVENTAIRE VIDE
			-- BUILDING AN EMPTY INVENTORY, NEED REWORK UGLY, IM DYING
			for i=1,countItems do
				MySQL.Async.execute("INSERT INTO user_inventory (`user_id`, `item_id`, `quantity`) VALUES (@username, @item_id, '0')",
				{['@username'] = identifier, ['@item_id'] = i})
			end


			-- VOITURE PAR DÉFAUT
			-- PLATE SYSTEM WITH SOCIAL CLUB ID TASTY AF
			local L = #identifier - 4
			local L1 = #identifier - 3
			local L2 = #identifier - 2
			local L3 = #identifier - 1
			local plateveh = "CTZN" .. identifier[L] .. identifier[L1] .. identifier[L2] .. identifier[L3]
			MySQL.Async.execute("INSERT INTO user_vehicle (`identifier`, `vehicle_name`, `vehicle_model`, `vehicle_price`, `vehicle_plate`, `vehicle_state`, `vehicle_colorprimary`, `vehicle_colorsecondary`, `vehicle_pearlescentcolor`, `vehicle_wheelcolor`) VALUES (@username, 'Faggio', 'faggio2', '4000',@plate, 'Rentré', '4', '0', '111', '156')",
			{['@username'] = identifier, ['@plate'] = string.upper(plateveh)})

			TriggerClientEvent("ccreation:menu", source)

			LoadUser(identifier, source, true)
		else
			LoadUser(identifier, source)
		end
	end)
end

AddEventHandler("es:setPlayerData", function(user, k, v, cb)
	if(Users[user])then
		if(Users[user][k])then

			if(k ~= "money") then
				Users[user][k] = v

				MySQL.Async.execute("UPDATE users SET @key=@value WHERE identifier = @identifier",
				{['@key'] = k, ['@value'] = v, ['@identifier'] = Users[user]['identifier']})
			end

			if(k == "group")then
				Users[user].group = groups[v]
			end

			cb("Player data edited.", true)
		else
			cb("Column does not exist!", false)
		end
	else
		cb("User could not be found!", false)
	end
end)

AddEventHandler("es:setPlayerDataId", function(user, k, v, cb)
	MySQL.Async.execute("UPDATE users SET @key=@value WHERE identifier = @identifier",
	{['@key'] = k, ['@value'] = v, ['@identifier'] = user})

	cb("Player data edited.", true)
end)

AddEventHandler("es:getPlayerFromId", function(user, cb)
	if(Users)then
		if(Users[user])then
			cb(Users[user])
		else
			cb(nil)
		end
	else
		cb(nil)
	end
end)

AddEventHandler("es:getPlayerFromIdentifier", function(identifier, cb)
	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @name", {['@name'] = identifier}, function (result)
		if(result[1])then
			cb(result[1])
		else
			cb(nil)
		end
	end)
end)

AddEventHandler("es:getAllPlayers", function(cb)
	MySQL.Async.fetchAll("SELECT * FROM users", {}, function (result)
		if(result)then
			cb(result)
		else
			cb(nil)
		end
	end)
end)

-- GENERATING A CELLPHONE NUMBER, WITH... SOCIAL CLUB ID OMGG AGAIN
function generateTel(identifier)
	local tel = ""
	for i = #identifier, 1, -1 do
		local c = string.sub(identifier, i, i)
		-- do something with c
		if (#tel) < 8 then
			c = tonumber(c)
			if c ~= nil then
				if string.len(tel) == 3 then
					tel = tel .. "-"
				end
				c = tostring(c)
				tel = tel .. c
			end
		end
	end
	return tel
end

-- GET PLATE NUMBER
RegisterServerEvent("es:getVehPlate")
AddEventHandler("es:getVehPlate", function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (user) then
			TriggerClientEvent("es:f_getVehPlate", source, user:getVehicle())
		else
			TriggerEvent("es:desyncMsg")
		end
	end)
end)


-- GET THE PLAYER X Y Z READY TO BE SPAWNED
RegisterServerEvent("es:requestingSpawnData")
AddEventHandler("es:requestingSpawnData", function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (user) then
			TriggerClientEvent("es:sendingSpawnData", source, user:getCoords())
		else
			TriggerEvent("es:desyncMsg")
		end
	end)
end)


-- Function to update player money every 60 seconds.
local function savePlayerMoney()
	SetTimeout(600000, function()
		TriggerEvent("es:getPlayers", function(users)
			for k,v in pairs(users)do
				MySQL.Async.execute("UPDATE users SET `money`=@value WHERE identifier = @identifier",
				{['@value'] = v.money, ['@identifier'] = v.identifier})
				MySQL.Async.execute("UPDATE users SET `dirtymoney`=@value WHERE identifier = @identifier",
				{['@value'] = v.dirtymoney, ['@identifier'] = v.identifier})
			end
		end)

		savePlayerMoney()
	end)
end

savePlayerMoney()

-- THE FUKED UP CODE THAT IS NOT SUPPOSE TO BE THERE BUT IT IS.

-- TELEPHONE -> TELIST
RegisterServerEvent("tel:sendingMsg")
AddEventHandler("tel:sendingMsg", function(msg, teldest)
	local name = nil
	local surname = nil
	local origin = nil
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (user) then
			name = user:getNom()
			surname = user:getPrenom()
			origin = user:getTel()
		else
			TriggerEvent("es:desyncMsg")
		end
	end)
	if name ~= nil then
		if telist[teldest] ~= nil then
			if telist[teldest].IDsource ~= nil then
				local player = telist[teldest].IDsource
				local player2 = telist[origin].IDsource
				TriggerClientEvent("tel:receivingMsg", player, msg, name, surname)
				TriggerClientEvent("itinerance:notif", player2, "~g~ Message envoyé")
			else
				TriggerClientEvent("itinerance:notif", player2, "~r~ Le joueur n'est pas connecté")
			end
		else
			TriggerClientEvent("itinerance:notif", player2, "~r~ Le joueur n'est pas connecté")
		end
	else
		TriggerEvent("es:desyncMsg")
	end
end)

function getPlayerID(source)
	local identifiers = GetPlayerIdentifiers(source)
	local player = getIdentifiant(identifiers)
	return player
end

function getIdentifiant(id)
	for _, v in ipairs(id) do
		return v
	end
end
