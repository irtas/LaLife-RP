local ban_list = {
	[""] = true
}

RegisterServerEvent('playerConnecting')
AddEventHandler('playerConnecting', function(name, setCallback)
	local identifiers = GetPlayerIdentifiers(source)
	for i = 1, #identifiers do
		local ip = string.sub(identifiers[i], 4)
		if ban_list[ip] ~= nil then 
			print('Player that was banned tried to join: ' .. ip)
			setCallback("You are banned from FiveReborn Freeroam.")
			CancelEvent()
			return
		end
	end
end)