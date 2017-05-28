RegisterServerEvent('menupolice:getTargetN_s')
AddEventHandler('menupolice:getTargetN_s', function(netID)
  TriggerEvent('es:getPlayerFromId', netID, function(user)
    local name = user:getNom()
    local surname = user:getPrenom()
    TriggerClientEvent("f_getTargetN", source, {surname, name})
  end)
end)

RegisterServerEvent('menupolice:verifp_s')
AddEventHandler('menupolice:verifp_s', function(netID)
    local tIdentifier = GetPlayerIdentifiers(netID)
    local identifier = tIdentifier[1]
    local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@name'", {['@name'] = tostring(identifier)})
    local result = MySQL:getResults(executed_query, {'identifier', 'money', 'dirtymoney', 'job', 'nom', 'prenom'}, "identifier")
    TriggerClientEvent("menupolice:f_verifp", source, tostring(result[1].prenom.." "..result[1].nom), tostring(result[1].money), tostring(result[1].dirtymoney), tostring(result[1].job))
end)

RegisterServerEvent('menupolice:seizecash_s')
AddEventHandler('menupolice:seizecash_s', function(netID)
  TriggerEvent('es:getPlayerFromId', netID, function(user)
    local curDCash = user:getDMoney()
    user:removeDMoney(curDCash)
    TriggerClientEvent("es_freeroam:notif", source, "Vous avez saisi ".. tostring(curDCash))
  end)
end)

RegisterServerEvent('menupolice:seizedrug_s')
AddEventHandler('menupolice:seizedrug_s', function(netID)
  TriggerEvent('es:getPlayerFromId', netID, function(user)
    local tIdentifier = GetPlayerIdentifiers(netID)
    local identifier = tIdentifier[1]
    local executed_query = MySQL:executeQuery("SELECT * FROM user_inventory JOIN items ON `user_inventory`.`item_id` = `items`.`id` WHERE user_id = '@username'", { ['@username'] = identifier })
    local result = MySQL:getResults(executed_query, { 'quantity', 'libelle', 'item_id' }, "item_id")
    local civitems = {}
    if (result) then
      for _, t in pairs(inv_array_illlegal) do
          if result[t.id].quantity > 0 then
            TriggerClientEvent("player:looseItem", netID, t.id, result[t.id].quantity)
            TriggerClientEvent("es_freeroam:notif", netID, "Vous avez perdu ".. tostring(result[t.id].quantity) .." "..tostring(t.name))
            TriggerClientEvent("es_freeroam:notif", source, "Vous avez saisi ".. tostring(result[t.id].quantity) .." "..tostring(t.name))
          end
      end
    end
  end)
end)

RegisterServerEvent('menupolice:givecon_s')
AddEventHandler('menupolice:givecon_s', function(netID, amount)
  TriggerEvent('es:getPlayerFromId', netID, function(user)
    user:removeMoney(amount)
  end)
end)

RegisterServerEvent('menupolice:searchciv_s')
AddEventHandler('menupolice:searchciv_s', function(netID)
  TriggerEvent('es:getPlayerFromId', netID, function(user)
    local tIdentifier = GetPlayerIdentifiers(netID)
    local identifier = tIdentifier[1]
    local executed_query = MySQL:executeQuery("SELECT * FROM user_inventory JOIN items ON `user_inventory`.`item_id` = `items`.`id` WHERE user_id = '@username'", { ['@username'] = identifier })
    local result = MySQL:getResults(executed_query, { 'quantity', 'libelle', 'item_id' }, "item_id")
    local civitems = {}
    if (result) then
      for _, v in ipairs(result) do
          t = { ["quantity"] = v.quantity, ["libelle"] = v.libelle }
          table.insert(civitems, tonumber(v.item_id), t)
      end

      TriggerClientEvent("menupolice:f_searchciv", source, civitems, #civitems)
    end
  end)
end)

RegisterServerEvent('menupolice:searchveh_s')
AddEventHandler('menupolice:searchveh_s', function(plate)
    print(plate)
    local executed_query = MySQL:executeQuery("SELECT * FROM user_vehicle WHERE vehicle_plate = '@name'", {['@name'] = tostring(plate)})
    local result = MySQL:getResults(executed_query, { 'identifier', 'vehicle_model', 'vehicle_plate' }, "identifier")
    if (#result > 0) then
      local executed_query1 = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@name'", {['@name'] = tostring(result[1].identifier)})
      local result1 = MySQL:getResults(executed_query1, {'identifier', 'nom', 'prenom'}, "identifier")
      if (#result1  > 0) then
        local vehitems = {}
        vehitems = {plate=result[1].vehicle_plate, model=result[1].vehicle_model , name=tostring(result1[1].prenom.." "..result1[1].nom)}

        TriggerClientEvent("menupolice:f_searchveh", source, vehitems)
      end
    else
      TriggerClientEvent("menupolice:f_searchveh", source,{name="Véhicule volé"})
    end
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

function stringsplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
end
