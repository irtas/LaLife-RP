fuelCost = 5

RegisterServerEvent('frfuel:fuelAdded')-- fuel events
AddEventHandler('frfuel:fuelAdded', function(amount) --fuelAmount
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (user) then
			local cost = round(amount * fuelCost)
			user:removeMoney(cost)
		else
			TriggerEvent("es:desyncMsg")
		end
	end)
end)

function round(num, numDecimalPlaces)
	local mult = 5^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end
