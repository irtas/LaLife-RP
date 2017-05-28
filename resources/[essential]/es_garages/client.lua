--[[Register]]--

RegisterNetEvent("garages:getVehicles")
RegisterNetEvent('garages:SpawnVehicle')
RegisterNetEvent('garages:StoreVehicle')
RegisterNetEvent('garages:SelVehicle')



--[[Local/Global]]--

VEHICLES = {}
local currentPos
local garage_location = {215.124, -791.377, 29.736}
local garage_location2 = {-956.40515136719, -2704.7595214844, 13.831034660339}
local vente_location = {-45.228, -1083.123, 25.816}
local inrangeofgarage = false
local currentlocation = nil
local garage = {title = "garage", currentpos = nil, marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }}



--[[Functions]]--

function MenuGarage()
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("Rentrer le véhicule","RentrerVehicule",nil)
    Menu.addButton("Sortir un véhicule","ListeVehicule",nil)
    Menu.addButton("Fermer","CloseMenu",nil)
end

function RentrerVehicule()
    TriggerServerEvent('garages:CheckForVeh',source)
    CloseMenu()
end

function ListeVehicule()
    ped = GetPlayerPed(-1);
    MenuTitle = "Mes vehicules :"
    ClearMenu()
    for ind, value in pairs(VEHICLES) do
        Menu.addButton(tostring(value.vehicle_name) .. " : " .. tostring(value.vehicle_state), "OptionVehicle", value.id)
    end
    Menu.addButton("Retour","MenuGarage",nil)
end

function OptionVehicle(vehID)
    local vehID = vehID
    MenuTitle = "Options :"
    ClearMenu()
    Menu.addButton("Sortir", "SortirVehicule", vehID)
    --Menu.addButton("Supprimer", "SupprimerVehicule", vehID)
    Menu.addButton("Retour", "ListeVehicule", nil)
end

function SortirVehicule(vehID)
    local vehID = vehID
    TriggerServerEvent('garages:CheckForSpawnVeh', vehID)
    CloseMenu()
end

--[[
function SupprimerVehicule(vehID)
local vehID = vehID
TriggerServerEvent('garages:CheckForDelVeh', vehID)
Menu.addButton("Fermer","CloseMenu",nil)
end
]]--

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function CloseMenu()
    Menu.hidden = true
end

function LocalPed()
    return GetPlayerPed(-1)
end

function IsPlayerInRangeOfGarage()
    return inrangeofgarage
end

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end



--[[Citizen]]--

Citizen.CreateThread(function()
    local loc = garage_location
    pos = garage_location
    local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
    SetBlipSprite(blip,357)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Garage')
    EndTextCommandSetBlipName(blip)
    SetBlipAsShortRange(blip,true)
    SetBlipAsMissionCreatorBlip(blip,true)
    checkgarage = 0
    while true do
        Wait(0)
        DrawMarker(1,garage_location[1],garage_location[2],garage_location[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
        if GetDistanceBetweenCoords(garage_location[1],garage_location[2],garage_location[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
            drawTxt('~g~E~s~ pour ouvrir le menu',0,1,0.5,0.8,0.6,255,255,255,255)
            if IsControlJustPressed(1, 86) then
                MenuGarage()
                Menu.hidden = not Menu.hidden
                currentPos = garage_location
            end
            Menu.renderGUI()
        end
    end
end)

Citizen.CreateThread(function()
    local loc = garage_location2
    pos = garage_location2
    local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
    SetBlipSprite(blip,357)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Garage')
    EndTextCommandSetBlipName(blip)
    SetBlipAsShortRange(blip,true)
    SetBlipAsMissionCreatorBlip(blip,true)
    checkgarage = 0
    while true do
        Wait(0)
        DrawMarker(1,garage_location2[1],garage_location2[2],garage_location2[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
        if GetDistanceBetweenCoords(garage_location2[1],garage_location2[2],garage_location2[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
            drawTxt('~g~E~s~ pour ouvrir le menu',0,1,0.5,0.8,0.6,255,255,255,255)
            if IsControlJustPressed(1, 86) then
                MenuGarage()
                Menu.hidden = not Menu.hidden
                currentPos = garage_location2
            end
            Menu.renderGUI()
        end
    end
end)



Citizen.CreateThread(function()
    local loc = vente_location
    pos = vente_location
    -- local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
    -- SetBlipSprite(blip,207)
    -- SetBlipColour(blip, 3)
    -- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString('Revente')
    -- EndTextCommandSetBlipName(blip)
    -- SetBlipAsShortRange(blip,true)
    -- SetBlipAsMissionCreatorBlip(blip,true)
    checkgarage = 0
    while true do
        Wait(0)
        DrawMarker(1,vente_location[1],vente_location[2],vente_location[3],0,0,0,0,0,0,3.001,3.0001,0.5001,0,155,255,200,0,0,0,0)
        if GetDistanceBetweenCoords(vente_location[1],vente_location[2],vente_location[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
            drawTxt('~g~E~s~ pour vendre le véhicule à 50% du prix d\'achat',0,1,0.5,0.8,0.6,255,255,255,255)
            if IsControlJustPressed(1, 86) then
                TriggerServerEvent('garages:CheckForSelVeh',source)
            end
        end
    end
end)



--[[Events]]--

AddEventHandler("garages:getVehicles", function(THEVEHICLES)
    VEHICLES = {}
    VEHICLES = THEVEHICLES
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("garages:CheckGarageForVeh")
end)

AddEventHandler('garages:SpawnVehicle', function(vehicle, plate, state, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
    local car = GetHashKey(vehicle)
    local plate = plate
    local state = state
    local primarycolor = tonumber(primarycolor)
    local secondarycolor = tonumber(secondarycolor)
    local pearlescentcolor = tonumber(pearlescentcolor)
    local wheelcolor = tonumber(wheelcolor)
    Citizen.CreateThread(function()
        Citizen.Wait(3000)
        local caisseo = GetClosestVehicle(currentPos[1], currentPos[2], currentPos[3], 3.000, 0, 70)
        if DoesEntityExist(caisseo) then
            drawNotification("La zone est encombrée")
        else
            if state == "Sorti" then
                drawNotification("Ce véhicule n'est pas dans le garage")
            else
                local mods = {}
                for i = 0,24 do
                    mods[i] = GetVehicleMod(veh,i)
                end
                RequestModel(car)
                while not HasModelLoaded(car) do
                    Citizen.Wait(0)
                end
                veh = CreateVehicle(car, currentPos[1], currentPos[2], currentPos[3], 0.0, true, false)
                for i,mod in pairs(mods) do
                    SetVehicleModKit(personalvehicle,0)
                    SetVehicleMod(personalvehicle,i,mod)
                end
                SetVehicleNumberPlateText(veh, plate)
                SetVehicleOnGroundProperly(veh)
                SetVehicleHasBeenOwnedByPlayer(veh,true)
                local id = NetworkGetNetworkIdFromEntity(veh)
                SetNetworkIdCanMigrate(id, true)
                SetVehicleColours(veh, primarycolor, secondarycolor)
                SetVehicleExtraColours(veh, pearlescentcolor, wheelcolor)
                SetEntityInvincible(veh, false)
                drawNotification("Véhicule sorti")
                TriggerServerEvent('garages:SetVehOut', vehicle, plate, car)
                TriggerServerEvent("garages:CheckGarageForVeh")
            end
        end
    end)
end)

AddEventHandler('garages:StoreVehicle', function(vehicle, plate)
    local car = GetHashKey(vehicle)
    local plate = plate
    Citizen.CreateThread(function()
        Citizen.Wait(3000)
        local caissei = GetClosestVehicle(currentPos[1], currentPos[2], currentPos[3], 3.000, 0, 70)
        SetEntityAsMissionEntity(caissei, true, true)
        local platecaissei = GetVehicleNumberPlateText(caissei)
        if DoesEntityExist(caissei) then
            if plate ~= platecaissei then
                drawNotification("Ce n'est pas ton véhicule")
            else
                Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(car))
                Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(caissei))
                drawNotification("Véhicule rentré")
                TriggerServerEvent('garages:SetVehIn', plate)
                TriggerServerEvent("garages:CheckGarageForVeh")
            end
        else
            drawNotification("Aucun véhicule présent")
        end
    end)
end)

AddEventHandler('garages:SelVehicle', function(vehicle, plate)
    local car = GetHashKey(vehicle)
    local plate = plate
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        local caissei = GetClosestVehicle(-45.228, -1083.123, 25.816, 3.000, 0, 70)
        SetEntityAsMissionEntity(caissei, true, true)
        local platecaissei = GetVehicleNumberPlateText(caissei)
        if DoesEntityExist(caissei) then
            if plate ~= platecaissei then
                drawNotification("Ce n'est pas ton véhicule")
            else
                Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(caissei))
                TriggerServerEvent('garages:SelVeh', plate)
                TriggerServerEvent("garages:CheckGarageForVeh")
            end
        else
            drawNotification("Aucun véhicule présent")
        end
    end)
end)
