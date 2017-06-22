ITEMS = {}

local MoneyOk = false

function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function new(qty, id, price, name)
	TriggerServerEvent("inventory:setItem_s", qty, id, price, name)
	TriggerServerEvent("inventory:getItems_s")
end

function newf(item, quantity)
	TriggerServerEvent("inventory:setItem_sf", item, quantity)
	TriggerServerEvent("inventory:getItems_s")
end

function delete(arg)
	local itemId = tonumber(arg[1])
	local qty = arg[2]
	local item = ITEMS[itemId]
	item.quantity = item.quantity - qty
	TriggerServerEvent("inventory:updateQuantity_sf", item.quantity, itemId)
	--TriggerServerEvent("inventory:getItems_s")
end

function add(arg)
	if #arg == 4 then
		local itemId = tonumber(arg[1])
		local qty = arg[2]
		local price = arg[3]
		local name = arg[4]
		local item = ITEMS[itemId]
		item.quantity = item.quantity + qty
		TriggerServerEvent("inventory:updateQuantity_s", item.quantity, itemId, price, name)
	else
		local itemId = tonumber(arg[1])
		local qty = arg[2]
		local item = ITEMS[itemId]
		item.quantity = item.quantity + qty
		TriggerServerEvent("inventory:updateQuantity_sf", item.quantity, itemId)
	end
end

function sell(arg)
	if #arg == 3 then
		local itemId = tonumber(arg[1])
		local price = arg[2]
		local name = arg[3]
		local item = ITEMS[itemId]
		item.quantity = item.quantity - 1
		TriggerServerEvent("inventory:sell_s", itemId, item.quantity, price, name)
	else
		local itemId = tonumber(arg[1])
		local price = arg[2]
		local item = ITEMS[itemId]
		item.quantity = item.quantity - 1
		TriggerServerEvent("inventory:sell_sf", itemId, item.quantity, price)
	end
end
----------- EVENT FROM MENU TARGET TARGET!!!

AddEventHandler("inventory:buy", function(target, qty, id, price, name) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	local price = price * qty
	TriggerServerEvent("inventory:checkMoney", price)
	Wait(200)
	if MoneyOk then
		item = tonumber(id)
		if (ITEMS[item] == nil) then
			new(qty, item, price, name)
		else
			add({ item, qty, price, name })
		end
		MoneyOk = false
	end
end)

AddEventHandler("inventory:sell", function(target, qty, id, price, name) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	item = tonumber(id)
	if (ITEMS[item].quantity > 0) then
		sell({ item, price, name })
	end
end)

AddEventHandler("inventory:useItem", function(target, id) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	local useItem = {}
	local value = 0
	for _, val in ipairs(inv_array_legal) do
		if id == val.id then
			value = val.value
			useItem = val
		end
	end
	delete({ id, 1})
	if id == 1 then
		if IsInVehicle() then
			TriggerEvent("food:vdrink", value)
		else
			TriggerEvent("food:drink", useItem)
		end

	else
		if IsInVehicle() then
			TriggerEvent("food:veat", value)
		else
			TriggerEvent("food:eat", useItem)
		end
	end
end)

--------    EVENT POUR LE GATHER DES RESSOURCES ILLÉGALES SANS PRICE

AddEventHandler("player:getQuantity", function(itemId)
	local _amount = 0
	_amount = ITEMS[tonumber(itemId)].quantity
	TriggerEvent("tradeill:cbgetQuantity", _amount)
end)

AddEventHandler("player:getQuantityMine", function(itemId)
	local _amount = 0
	_amount = ITEMS[tonumber(itemId)].quantity
	return _amount
end)


function getQuantity(itemId)
	return ITEMS[tonumber(itemId)].quantity
end

AddEventHandler("player:receiveItem", function(item, quantity)
	item = tonumber(item)
	if (ITEMS[item] == nil) then
		newf(item, quantity)
	else
		add({ item, quantity})
	end
end)

RegisterNetEvent("player:looseItem")
AddEventHandler("player:looseItem", function(item, quantity)
	item = tonumber(item)
	if (ITEMS[item].quantity >= quantity) then
		delete({ item, quantity })
	end
end)

AddEventHandler("player:sellItem", function(item, price)
	item = tonumber(item)
	if (ITEMS[item].quantity > 0) then
		sell({ item, price })
	end
end)

AddEventHandler("item:reset", function()
	ITEMS = {}
	TriggerServerEvent("inventory:reset_s")
end)

--------- EVENT FROM SERVER NO TARGET

AddEventHandler("playerSpawned", function()
	Citizen.CreateThread(function()
		Wait(500)
		TriggerServerEvent('vmenu:lastChar')
		TriggerServerEvent("inventory:getItems_s")
		TriggerServerEvent('vmenu:updateUser', 98)
		TriggerServerEvent("poleemploi:getjobs")
		Wait(2500)
	end)
end)

RegisterNetEvent("inventory:getItems")
AddEventHandler("inventory:getItems", function(p_items) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	ITEMS = {}
	ITEMS = p_items
end)

RegisterNetEvent("inventory:MoneyOk")
AddEventHandler("inventory:MoneyOk", function(param) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	MoneyOk = param
end)

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end
