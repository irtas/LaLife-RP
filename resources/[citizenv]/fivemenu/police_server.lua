require "resources/mysql-async/lib/MySQL"

RegisterServerEvent('menupolice:getTargetN_s')

AddEventHandler('menupolice:getTargetN_s', function(netID)
  TriggerEvent('es:getPlayerFromId', netID, function(user)
    if (user) then
      local name = user:getNom()
      local surname = user:getPrenom()
      TriggerClientEvent("f_getTargetN", source, {surname, name})
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent('menupolice:verifp_s')
AddEventHandler('menupolice:verifp_s', function(netID)
  local tIdentifier = GetPlayerIdentifiers(netID)
  local identifier = tIdentifier[1]

  MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @name", {['@name'] = tostring(identifier)}, function (result)
    TriggerClientEvent("menupolice:f_verifp", source, tostring(result[1].prenom.." "..result[1].nom), tostring(result[1].money), tostring(result[1].dirtymoney), tostring(result[1].job))
  end)
end)

RegisterServerEvent('menupolice:seizecash_s')
AddEventHandler('menupolice:seizecash_s', function(netID)
  TriggerEvent('es:getPlayerFromId', netID, function(user)
    if (user) then
      local curDCash = user:getDMoney()
      user:removeDMoney(curDCash)
      TriggerClientEvent("itinerance:notif", source, "Vous avez saisi ".. tostring(curDCash))
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent('menupolice:seizedrug_s')
AddEventHandler('menupolice:seizedrug_s', function(netID)
  TriggerEvent('es:getPlayerFromId', netID, function(user)
    if (user) then
      local tIdentifier = GetPlayerIdentifiers(netID)
      local identifier = tIdentifier[1]
      MySQL.Async.fetchAll("SELECT * FROM user_inventory JOIN items ON `user_inventory`.`item_id` = `items`.`id` WHERE user_id = @username", { ['@username'] = identifier }, function (result)
        if (result) then
          for _, t in pairs(inv_array_illlegal) do
            if result[t.id].quantity > 0 then
              TriggerClientEvent("player:looseItem", netID, t.id, result[t.id].quantity)
              TriggerClientEvent("itinerance:notif", netID, "Vous avez perdu ".. tostring(result[t.id].quantity) .." "..tostring(t.name))
              TriggerClientEvent("itinerance:notif", source, "Vous avez saisi ".. tostring(result[t.id].quantity) .." "..tostring(t.name))
            end
          end
        end
      end)
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent('menupolice:givecon_s')
AddEventHandler('menupolice:givecon_s', function(netID, amount)
  TriggerEvent('bank:remove', netID, amount)
  TriggerClientEvent("itinerance:notif", netID, "Vous avez reçu une contravention de ~r~".. amount.."$")
end)

RegisterServerEvent('menupolice:searchciv_s')
AddEventHandler('menupolice:searchciv_s', function(netID)
  TriggerEvent('es:getPlayerFromId', netID, function(user)
    if (user) then
      local tIdentifier = GetPlayerIdentifiers(netID)
      local identifier = tIdentifier[1]
      MySQL.Async.fetchAll("SELECT * FROM user_inventory JOIN items ON `user_inventory`.`item_id` = `items`.`id` WHERE user_id = @username", { ['@username'] = identifier }, function (result)
        local civitems = {}
        if (result) then
          for _, v in ipairs(result) do
            t = { ["quantity"] = v.quantity, ["libelle"] = v.libelle }
            table.insert(civitems, tonumber(v.item_id), t)
          end

          TriggerClientEvent("menupolice:f_searchciv", source, civitems, #civitems)
        end
      end)
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent('menupolice:searchveh_s')
AddEventHandler('menupolice:searchveh_s', function(plate)
  print(plate)
  MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE vehicle_plate = @name", {['@name'] = tostring(plate)}, function (result)
    if (#result > 0) then
      MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @name", {['@name'] = tostring(result[1].identifier)}, function (result1)
        if (#result1  > 0) then
          local vehitems = {plate=result[1].vehicle_plate, model=result[1].vehicle_model , name=tostring(result1[1].prenom.." "..result1[1].nom)}

          TriggerClientEvent("menupolice:f_searchveh", source, vehitems)
        end
      end)
    else
      TriggerClientEvent("menupolice:f_searchveh", source,{name="Véhicule volé"})
    end
  end)
end)

RegisterServerEvent('menupolice:cuff_s')
AddEventHandler('menupolice:cuff_s', function(netID)
  TriggerClientEvent("menupolice:f_cuff", netID)
  TriggerClientEvent("menupolice:wf_cuff", netID)
end)

RegisterServerEvent('menupolice:escortcuff_s')
AddEventHandler('menupolice:escortcuff_s', function(netID, pname)
  local pname = pname
  TriggerClientEvent("menupolice:wf_escortcuff", netID, source, pname, true)
end)

RegisterServerEvent('menupolice:uncuff_s')
AddEventHandler('menupolice:uncuff_s', function(netID)
  TriggerClientEvent("menupolice:f_uncuff", netID)
  TriggerClientEvent("menupolice:wf_uncuff", netID)
end)

RegisterServerEvent('menupolice:civtocar_s')
AddEventHandler('menupolice:civtocar_s', function(t, v, e)
  TriggerClientEvent('menupolice:wf_civtocar', t, v, e)
end)

RegisterServerEvent('menupolice:civuncar_s')
AddEventHandler('menupolice:civuncar_s', function(t)
  TriggerClientEvent('menupolice:f_civuncar', t)
end)

local jail1 = false
local jail2 = false
local jail3 = false

local prisoner = {
  [1] = {source = 0},
  [2] = {source = 0},
  [3] = {source = 0}
}

RegisterServerEvent('menupolice:jail_s')
AddEventHandler('menupolice:jail_s', function(t)
  -- print(jail1)
  -- print(jail2)
  -- print(jail3)
  if jail1 == false then
    TriggerClientEvent('menupolice:wf_jail', t, 1)
    prisoner[1].source = t
    jail1 = true
  elseif jail2 == false then
    TriggerClientEvent('menupolice:wf_jail', t, 2)
    prisoner[2].source = t
    jail2 = true
  elseif jail3 == false then
    TriggerClientEvent('menupolice:wf_jail', t, 3)
    prisoner[3].source = t
    jail3 = true
  else
    TriggerClientEvent("itinerance:notif", source, "Toutes les cellules sont occupées")
  end
  -- print(prisoner[1].source)
  -- print(prisoner[2].source)
  -- print(prisoner[3].source)
end)

RegisterServerEvent('menupolice:unjail_s')
AddEventHandler('menupolice:unjail_s', function(t, v)
  -- print(prisoner[1].source)
  -- print(prisoner[2].source)
  -- print(prisoner[3].source)
  if v == 1 then
    TriggerClientEvent("menupolice:wf_unjail", prisoner[1].source, v)
    prisoner[1].source = 0
    jail1 = false
  elseif v == 2 then
    TriggerClientEvent("menupolice:wf_unjail", prisoner[2].source, v)
    prisoner[1].source = 0
    jail2 = false
  elseif v == 3 then
    TriggerClientEvent("menupolice:wf_unjail", prisoner[3].source, v)
    prisoner[1].source = 0
    jail3 = false
  end
end)

RegisterServerEvent('menupolice:civunjail_s')
AddEventHandler('menupolice:civunjail_s', function(t, v)
  -- print(prisoner[1].source)
  -- print(prisoner[2].source)
  -- print(prisoner[3].source)
  if v == 1 then
    TriggerClientEvent("menupolice:wf_unjail", prisoner[1].source, v)
    TriggerEvent("menupolice:uncuff_s", prisoner[1].source)
    prisoner[1].source = 0
    jail1 = false
  elseif v == 2 then
    TriggerClientEvent("menupolice:wf_unjail", prisoner[2].source, v)
    TriggerEvent("menupolice:uncuff_s", prisoner[2].source)
    prisoner[1].source = 0
    jail2 = false
  elseif v == 3 then
    TriggerClientEvent("menupolice:wf_unjail", prisoner[3].source, v)
    TriggerEvent("menupolice:uncuff_s", prisoner[3].source)
    prisoner[1].source = 0
    jail3 = false
  end
end)

function stringsplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
    table.insert(t, a[i])
  end

  return t
end
