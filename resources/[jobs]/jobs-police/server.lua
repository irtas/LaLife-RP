require "resources/[essential]/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "Police911")


function idPolice(user)
	return user:getPolice()
  -- local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@identifier'", {['@identifier'] = player})
  -- local result = MySQL:getResults(executed_query, {'police'}, "police")
  -- return result[1].police
end

function namePolice(player, user)
  local idPolice = idPolice(user)
  local executed_query = MySQL:executeQuery("SELECT * FROM police WHERE police_id = '@respolice'", {['@respolice'] = idPolice})
  local result = MySQL:getResults(executed_query, {'police_name'}, "police_name")
  return result[1].police_name
end

function isService(user)
  return user:getenService()
	-- local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@identifier'", {['@identifier'] = player})
	-- local result = MySQL:getResults(executed_query, {'enService'}, "enService")
	-- return result[1].enService
end

-- function updatejob(player, id)
--   local police = id
--   MySQL:executeQuery("UPDATE users SET `enService`='@value' WHERE identifier = '@identifier'", {['@value'] = police, ['@identifier'] = player})
-- end

RegisterServerEvent('jobspolice:updateService')
AddEventHandler('jobspolice:updateService', function(id)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    user:setenService(id)
		TriggerServerEvent('vmenu:updateUser', 5)
  end)
end)

RegisterServerEvent('jobspolice:jobs')
AddEventHandler('jobspolice:jobs', function(id, civil)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
		local namePolice = namePolice(player, user) --SELECT
		local id_police = idPolice(user) --Donne le ID de la police du joueur pour lui donne les armes et le skin aproprier
		if namePolice == "Rien" then
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_ANDREAS", 1, "Commissariat", false, "Vous devez être policier")
		else
			--updatejob(player, id) --UPDATE
			user:setenService(id)
			local isService = isService(user)
			if isService == 1 then
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_ANDREAS", 1, "Commissariat", false, "Vous êtes en service en tant que : ".. namePolice)
				if not civil then
					ArmeSelonGrade(id_police)
				end
			else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_ANDREAS", 1, "Commissariat", false, "Vous êtes maintenant hors service")
        TriggerEvent("vmenu:fromSlastChar", source)
			end
			TriggerEvent('vmenu:updateUser', 5)
		end
  end)
end)

function ArmeSelonGrade(id_police) --Donne certaine Arme en fonction du grade de la police PAS ENCORE TERMINER
	if id_police == 1 then
		TriggerClientEvent("jobspolice:giveWeapon", source, "WEAPON_STUNGUN", nil)
		TriggerClientEvent("jobspolice:cadet", source , nil)
	elseif id_police == 2 then
		TriggerClientEvent("jobspolice:giveWeapon", source, "WEAPON_STUNGUN", nil)
		TriggerClientEvent("jobspolice:brigadier", source, nil)
	elseif id_police == 3 then
		TriggerClientEvent("jobspolice:giveWeapon", source, "WEAPON_STUNGUN", nil)
		TriggerClientEvent("jobspolice:sergent", source , nil)
	elseif id_police == 4 then
		TriggerClientEvent("jobspolice:giveWeapon", source, "WEAPON_STUNGUN", nil)
		--TriggerClientEvent("jobspolice:changeSkin", source, "S_M_Y_Cop_01", nil)
    		TriggerClientEvent("jobspolice:lieutenant", source , nil)
	elseif id_police == 5 then
		TriggerClientEvent("jobspolice:giveWeapon", source, "WEAPON_STUNGUN", nil)
		TriggerClientEvent("jobspolice:capitaine", source , nil)
	elseif id_police >= 6 then
		TriggerClientEvent("jobspolice:giveWeapon", source, "WEAPON_STUNGUN", nil)
		--TriggerClientEvent("jobspolice:changeSkin", source, "mp_m_freemode_01", nil)
    		TriggerClientEvent("jobspolice:commandant", source , nil)
	end
end

function RetirerArme() --Retire toutes les arme du joueur PAS ENCORE TERMINER
end

RegisterServerEvent('jobspolice:wepArmory')
AddEventHandler('jobspolice:wepArmory', function(id)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
		local namePolice = namePolice(player, user) --SELECT
		if namePolice == "Rien" then
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_ANDREAS", 1, "Commissariat", false, "Vous devez être policier")
		else
			local isService = isService(user)
			if isService == 1 then
				TriggerClientEvent("jobspolice:notif", source, "~g~Voici votre arme")
				TriggerClientEvent("jobspolice:giveArmory", source, id, nil)
			else
				TriggerClientEvent("jobspolice:notif", source, "~r~Vous n'êtes pas en service")
			end
		end
  end)
end)

RegisterServerEvent('jobspolice:vehtoGarage')
AddEventHandler('jobspolice:vehtoGarage', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
		local L = #player - 4
		local L1 = #player - 3
		local L2 = #player - 2
		local L3 = #player - 1
		local plateveh = "LSPD" .. player[L] .. player[L1] .. player[L2] .. player[L3]
		plateveh = string.upper(plateveh)
    user:setVehicle(0)
	  TriggerClientEvent("jobspolice:DespawnVehicle", source, plateveh)
		TriggerEvent('vmenu:updateUser', 98)
	end)
end)

RegisterServerEvent('jobspolice:vehGarage')
AddEventHandler('jobspolice:vehGarage', function(vehicule)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
		local L = #player - 4
		local L1 = #player - 3
		local L2 = #player - 2
		local L3 = #player - 1
		local plateveh = "LSPD" .. player[L] .. player[L1] .. player[L2] .. player[L3]
		plateveh = string.upper(plateveh)
    user:setVehicle(plateveh)
		local name_police = namePolice(player, user)
		if name_police ~= "Rien" then
			   local isService = isService(user)
			   if isService == 1 then
  		    --  local executed_query = MySQL:executeQuery("INSERT INTO user_vehicle (`identifier`, `vehicle_model`, `vehicle_plate`, `vehicle_state`) VALUES ('@username', '@vehicle', '@plate', '@state')",
  		    --  {['@username'] = player, ['@vehicle'] = vehicule, ['@plate'] = plate, ['@state'] = state})
  				 TriggerClientEvent("jobspolice:SpawnVehicle", source, vehicule, plateveh)
			   else
					 TriggerClientEvent("jobspolice:notif", source, "~r~Vous n'êtes pas en service")
				 end
		else
				TriggerClientEvent("es_freeroam:notify", source, "CHAR_ANDREAS", 1, "Commissariat", false, "Vous devez être policier")
  	end
		TriggerEvent('vmenu:updateUser', 98)
	end)
end)

local ParkingPolice = {
	[1] = false,
	[2] = false,
	[3] = false,
	[4] = false
 }

RegisterServerEvent('jobspolice:CheckParking')
AddEventHandler('jobspolice:CheckParking', function()
	TriggerClientEvent("jobspolice:f_CheckParking", source, ParkingPolice)
end)

RegisterServerEvent('jobspolice:SetParking')
AddEventHandler('jobspolice:SetParking', function(param, bool)
	if param == 1 then
		ParkingPolice[1] = bool
	elseif param == 2 then
		ParkingPolice[2] = bool
	elseif param == 3 then
		ParkingPolice[3] = bool
	elseif param == 4 then
		ParkingPolice[4] = bool
	end
end)

-- function stringsplit(self, delimiter)
--   local a = self:Split(delimiter)
--   local t = {}
--
--   for i = 0, #a - 1 do
--      table.insert(t, a[i])
--   end
--
--   return t
-- end
