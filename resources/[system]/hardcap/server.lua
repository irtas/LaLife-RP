local playerCount = 0
local list = {}

RegisterServerEvent('hardcap:playerActivated')

AddEventHandler('hardcap:playerActivated', function()
  if not list[source] then
    playerCount = playerCount + 1
    list[source] = true
  end
end)

AddEventHandler('playerDropped', function()
  if list[source] then
    playerCount = playerCount - 1
    list[source] = nil
  end
end)

AddEventHandler('playerConnecting', function(name, setReason)
    print('Connecting: ' .. name.." "..getPlayerID(source))
    local isVIP = fisVIP(getPlayerID(source))

    if isVIP then

    elseif playerCount >= 0 then
      setReason('Le serveur est complet!')
      CancelEvent()
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

function fisVIP(id)
  for k,v in pairs(VIP) do
    if id == v then
      return true
    end
  end
  return false
end

								-- Nabil
VIP = {"steam:1100001067e5e10", "steam:1100001050bea3e", "steam:110000104114ff1", "steam:110000119ab11cf","steam:1100001068125dd", "steam:110000106ec999e", "steam:110000102dfc8af", "steam:110000101f39291", "steam:110000104cb2ae5", "steam:11000010a766e38"}
