-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY, IF SOMETHING IS WRONG CONTACT KANERSPS! --

-- Constructor
Player = {}
Player.__index = Player

-- Meta table for users
setmetatable(Player, {
	__call = function(self, source, permission_level, money, identifier, group, dirtymoney, job, police, nom, prenom, telephone, pos)
		local pl = {}

		pl.source = source
		pl.permission_level = permission_level
		pl.money = money
		pl.dirtymoney = dirtymoney
		pl.identifier = identifier
		pl.group = group
		pl.coords = {x = pos.x, y = pos.y, z = pos.z}
		pl.session = {}
		pl.job = job
		pl.police = police
		pl.enService = 0
		pl.nom = nom
		pl.prenom = prenom
		pl.telephone = telephone
		pl.vehicle = 0

		return setmetatable(pl, Player)
	end
})

-- Source
function Player:getSource()
	return self.source
end

-- Getting permissions
function Player:getPermissions()
	return self.permission_level
end

-- Setting them
function Player:setPermissions(p)
	TriggerEvent("es:setPlayerData", self.source, "permission_level", p, function(response, success)
		self.permission_level = p
	end)
end

-- No need to ever call this (No, it doesn't teleport the player)
function Player:setCoords(x, y, z)
	self.coords.x, self.coords.y, self.coords.z = x, y, z
end

function Player:getCoords()
	return { x = self.coords.x, y = self.coords.y, z = self.coords.z }
end

-- Kicks a player with specified reason
function Player:kick(reason)
	DropPlayer(self.source, reason)
end

function Player:getMoney()
	return self.money
end

-- Sets the player money (required to call this from now)
function Player:setMoney(m)
	local prevMoney = self.money
	local newMoney : double = m

	self.money = m

	if((prevMoney - newMoney) < 0)then
		TriggerClientEvent("es:addedMoney", self.source, math.abs(prevMoney - newMoney))
	else
		TriggerClientEvent("es:removedMoney", self.source, math.abs(prevMoney - newMoney))
	end

	TriggerClientEvent('es:activateMoney', self.source , self.money)
end

-- Adds to player money (required to call this from now)
function Player:addMoney(m)
	local newMoney : double = self.money + m

	self.money = newMoney

	TriggerClientEvent("es:addedMoney", self.source, m)
	TriggerClientEvent('es:activateMoney', self.source , self.money)
end

-- Removes from player money (required to call this from now)
function Player:removeMoney(m)
	local newMoney : double = self.money - m

	self.money = newMoney

	TriggerClientEvent("es:removedMoney", self.source, m)
	TriggerClientEvent('es:activateMoney', self.source , self.money)
end

----------- DIRTY MONEY
function Player:getDMoney()
	return self.dirtymoney
end

function Player:setDMoney(m)
	local prevMoney = self.dirtymoney
	local newMoney : double = m

	self.dirtymoney = m

	if((prevMoney - newMoney) < 0)then
		TriggerClientEvent("banking:adddBalance", self.source, math.abs(prevMoney - newMoney))
	else
		TriggerClientEvent("banking:removedBalance", self.source, math.abs(prevMoney - newMoney))
	end

	TriggerClientEvent('banking:updatedBalance', self.source , self.dirtymoney)
end

function Player:addDMoney(m)
	local newMoney : double = self.dirtymoney + m

	self.dirtymoney = newMoney

	TriggerClientEvent("banking:adddBalance", self.source, m)
	TriggerClientEvent('banking:updatedBalance', self.source , self.dirtymoney)
end

function Player:removeDMoney(m)
	local newMoney : double = self.dirtymoney - m

	self.dirtymoney = newMoney

	TriggerClientEvent("banking:removedBalance", self.source, m)
	TriggerClientEvent('banking:updatedBalance', self.source , self.dirtymoney)
end


-- Player session variables
function Player:setSessionVar(key, value)
	self.session[key] = value
end

function Player:getSessionVar(key)
	return self.session[key]
end

-- POLICE VARS
function Player:setenService(param)
	self.enService = param
end

function Player:getenService()
	return self.enService
end

function Player:setPolice(param)
	self.police = param
end

function Player:getPolice()
	return self.police
end

function Player:setNom(param)
	self.nom = param
end

function Player:getNom()
	return self.nom
end

function Player:setPrenom(param)
	self.prenom = param
end

function Player:getPrenom()
	return self.prenom
end

function Player:setVehicle(param)
	self.vehicle = param
end

function Player:getVehicle()
	return self.vehicle
end

function Player:getTel()
	return self.telephone
end

function Player:getJob()
	return self.job
end

function Player:setJob(param)
	self.job = param
end
