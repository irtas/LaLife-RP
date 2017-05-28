-- WIP WIP WIP! PO FINI EN FRANCÉ

local wanted = {}

RegisterServerEvent("wanted:getWanted")
AddEventHandler("wanted:getWanted",function()
  for i,b in ipairs(wanted)
    TriggerEvent("wanted:addmenu",b.raison)
  end
end)

RegisterServerEvent("wanted:addWanted")
AddEventHandler("wanted:addWanted",function(text)
  table.insert(wanted,{raison = tostring(text)})
end)
