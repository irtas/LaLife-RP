--[[
################################################################
- Creator: Jyben
- Date: 02/05/2017
- Url: https://github.com/Jyben/emergency
- Licence: Apache 2.0
################################################################
--]]

require "resources/mysql-async/lib/MySQL"

RegisterServerEvent('es_em:sendEmergency')
AddEventHandler('es_em:sendEmergency',
function(reason, playerIDInComa, x, y, z)
  TriggerEvent("es:getPlayers", function(players)
    for i,v in pairs(players) do
      TriggerClientEvent('es_em:sendEmergencyToDocs', i, reason, playerIDInComa, x, y, z, source)
    end
  end)
end
)

RegisterServerEvent('es_em:getTheCall')
AddEventHandler('es_em:getTheCall', function(playerName, playerID, x, y, z, sourcePlayerInComa)
  local fullname = playerName
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      fullname = user:getPrenom() .. " " .. user:getNom()
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
  TriggerEvent("es:getPlayers", function(players)
    for i,v in pairs(players) do
      TriggerClientEvent('es_em:callTaken', i, fullname, playerID, x, y, z, sourcePlayerInComa)
    end
  end)
end
)

RegisterServerEvent('es_em:sv_resurectPlayer')
AddEventHandler('es_em:sv_resurectPlayer',
function(sourcePlayerInComa)
  TriggerClientEvent('es_em:cl_resurectPlayer', sourcePlayerInComa)
end
)

RegisterServerEvent('es_em:sv_getJobId')
AddEventHandler('es_em:sv_getJobId', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local jobid = user:getJob()
      TriggerClientEvent('es_em:cl_setJobId', source, jobid)
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent('es_em:sv_getDocConnected')
AddEventHandler('es_em:sv_getDocConnected',
function()
  TriggerEvent("es:getPlayers", function(players)
    local identifier
    local table = {}
    local isConnected = false

    for i,v in pairs(players) do
      identifier = GetPlayerIdentifiers(i)
      if (identifier ~= nil) then
        local isConnected = MySQL.Sync.fetchScalar("SELECT COUNT(1) FROM users LEFT JOIN jobs ON jobs.job_id = users.job WHERE users.identifier = @identifier AND job_id = 13", {['@identifier'] = identifier[1]})
        if isConnected ~= 0 then
          TriggerClientEvent('es_em:cl_getDocConnected', source, true)
        end
      end
    end
  end)
end
)

RegisterServerEvent('es_em:sv_setService')
AddEventHandler('es_em:sv_setService',
function(service)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      user:setenService(2)
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

-- Par DayField :)!
RegisterServerEvent("delete:weapon")
AddEventHandler('delete:weapon', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local player = user.identifier
      MySQL.Async.execute("DELETE from user_weapons WHERE identifier = @username", {['@username'] = player})
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent('es_em:sv_removeMoney')
AddEventHandler('es_em:sv_removeMoney', function()
  TriggerEvent("es:getPlayerFromId", source, function(user)
    if (user) then
      if user.money > 0 then
        user:setMoney(0)
      end
      if user.dirtymoney > 0 then
        user:setDMoney(0)
      end
    end
  end)
end)

RegisterServerEvent('es_em:sv_sendMessageToPlayerInComa')
AddEventHandler('es_em:sv_sendMessageToPlayerInComa', function(sourcePlayerInComa)
  TriggerClientEvent('es_em:cl_sendMessageToPlayerInComa', sourcePlayerInComa)
end)

RegisterServerEvent('es_em:getAmbulanceHelicoGarage')
AddEventHandler('es_em:getAmbulanceHelicoGarage', function(vehicule)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (user) then
			local player = user.identifier
			local L = #player - 4
			local L1 = #player - 3
			local L2 = #player - 2
			local L3 = #player - 1
			local plateveh = "JOBS" .. player[L] .. player[L1] .. player[L2] .. player[L3]
			plateveh = string.upper(plateveh)
			user:setVehicle(plateveh)
			TriggerClientEvent("es_em:SpawnHelicoAmbulance", source, vehicule, plateveh, false)
		else
			TriggerEvent("es:desyncMsg")
		end
	end)
end)

AddEventHandler('playerDropped', function()

end)

TriggerEvent('es:addCommand', 'respawn', function(source, args, user)
  TriggerClientEvent('es_em:cl_respawn', source)
end)
