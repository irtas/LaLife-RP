require "resources/mysql-async/lib/MySQL"

function nameJob(id)
  return MySQL.Sync.fetchScalar("SELECT job_name FROM jobs WHERE job_id = @namejob", {['@namejob'] = id})
end

function updatejob(player, id)
  local job = id
  MySQL.Async.execute("UPDATE users SET `job`=@value WHERE identifier = @identifier", {['@value'] = job, ['@identifier'] = player})
end

RegisterServerEvent('poleemploi:jobs')
AddEventHandler('poleemploi:jobs', function(id)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local source = source
      local player = user.identifier
      local nameJob = nameJob(id)
      updatejob(player, id)
      user:setJob(id)
      TriggerEvent('poleemploi:getjobss', source)
      TriggerClientEvent("citizenv:notify", source, "CHAR_AMANDA", 1, "Mairie", false, "Votre métier est maintenant : ".. nameJob)
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent('poleemploi:getjobs')
AddEventHandler('poleemploi:getjobs', function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local source = source
      TriggerClientEvent("mine:getJobs", source, user:getJob())
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent('poleemploi:getjobss')
AddEventHandler('poleemploi:getjobss', function(source)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local source = source
      TriggerClientEvent("jobs-legal:getJobs", source, user:getJob())
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)
