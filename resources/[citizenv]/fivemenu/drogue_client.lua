-- Updated
local cashycash = 0
local coke = {}
local meth = {}
local organe = {}
local weed = {}

local cokefield = false
local cokeprocess = false
local cokesell = false

local methfield = false
local methprocess = false
local methsell = false

local organefield = false
local organeprocess = false
local organesell = false

local weedfield = false
local weedprocess = false
local weedsell = false

AddEventHandler("playerSpawned", function()
  TriggerServerEvent("menudrogue:sendData_s")
end)

TriggerServerEvent("menudrogue:sendData_s")

RegisterNetEvent("menudrogue:f_sendData")
AddEventHandler("menudrogue:f_sendData", function(t1, t2, t3, t4)
  coke = t1
  meth = t2
  organe = t3
  weed = t4
end)


RegisterNetEvent("menudrogue:f_getCash")
AddEventHandler("menudrogue:f_getCash", function(cashyj)
  cashycash = cashyj
end)

AddEventHandler("menudrogue:DrogueOG", function(target)
  VMenu.ResetMenu(14, "", "default")
  VMenu.curItem = 1
  VMenu.AddFunc(14 ,"Acheter des informations", "menudrogue:info",{0},"Acheter")
end)

AddEventHandler("menudrogue:info",function()
  TriggerServerEvent("menudrogue:getCash_s")
  VMenu.ResetMenu(14, "", "default")
  VMenu.curItem = 1
  VMenu.AddFunc(14,"Acheter des informations sur la coke","menudrogue:infocoke",{0},"Acheter")
  VMenu.AddFunc(14,"Acheter des informations sur la meth","menudrogue:infometh",{0},"Acheter")
  VMenu.AddFunc(14,"Acheter des informations sur les organes","menudrogue:infoorg",{0},"Acheter")
  VMenu.AddFunc(14,"Acheter des informations sur la weed","menudrogue:infoweed",{0},"Acheter")
end)




--coke
AddEventHandler("menudrogue:infocoke",function()
  VMenu.ResetMenu(14, "", "default")
  VMenu.curItem = 1
  if cashycash >= coke[1].cost then
    VMenu.AddFunc(14,"Acheter le champs de coke","menudrogue:coke",{0},"Acheter")
  end
  if cashycash >= coke[2].cost then
    VMenu.AddFunc(14,"Acheter le traitement de coke","menudrogue:coke",{1},"Acheter")
  end
  if cashycash >= coke[3].cost then
    VMenu.AddFunc(14,"Acheter la vente de coke","menudrogue:coke",{2},"Acheter")
  end
  if cashycash < coke[1].cost and cashycash < coke[2].cost and cashycash < coke[3].cost then
    VMenu.AddSep(14, "Vous n'avez pas assez d'argent")
  end
  VMenu.AddFunc(14,"Retour","menudrogue:info",{},"Retour")
end)

AddEventHandler("menudrogue:coke", function(target, id)
  if id == 0 and not cokefield then
    notif("Le champs de coke a été ajouté à votre carte")
    SetBlipTrade(140,tostring(coke[1].name),2,coke[1].x,coke[1].y,coke[1].z)
    DrawMarker(1, coke[1].x,coke[1].y,coke[1].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    TriggerServerEvent("menudrogue:setCash", coke[1].cost)
    cashycash = cashycash - coke[1].cost
    cokefield = true
  elseif id == 1 and not cokeprocess then
    notif("Les traitements de coke ont été ajouter à votre carte")
    SetBlipTrade(50,tostring(coke[2].name),1,coke[2].x,coke[2].y,coke[2].z)
    SetBlipTrade(50,tostring(coke[3].name),1,coke[3].x,coke[3].y,coke[3].z)
    DrawMarker(1, coke[2].x,coke[2].y,coke[2].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    DrawMarker(1, coke[3].x,coke[3].y,coke[3].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    TriggerServerEvent("menudrogue:setCash", coke[2].cost)
    cashycash = cashycash - coke[2].cost
    cokeprocess = true
  elseif id == 2 and not cokesell then
    notif("Les vendeurs de coke ont été ajouté à votre carte")
    SetBlipTrade(277,tostring(coke[4].name),1,coke[4].x,coke[4].y,coke[4].z)
    SetBlipTrade(277,tostring(coke[5].name),1,coke[5].x,coke[5].y,coke[5].z)
    DrawMarker(1, meth[4].x,meth[4].y,meth[4].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    DrawMarker(1, meth[5].x,meth[5].y,meth[5].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    TriggerServerEvent("menudrogue:setCash", coke[3].cost)
    cashycash = cashycash - coke[3].cost
    cokesell = true
  else
    notif("Vous avez déjà acheté l'info")
  end
end)
--fin coke





--meth
AddEventHandler("menudrogue:infometh",function()
  VMenu.ResetMenu(14, "Informateur", "default")
  VMenu.curItem = 1
  if cashycash >= meth[1].cost then
    VMenu.AddFunc(14,"Acheter le champs de meth","menudrogue:meth",{0},"Acheter")
  end
  if cashycash >= meth[2].cost then
    VMenu.AddFunc(14,"Acheter le traitement de meth","menudrogue:meth",{1},"Acheter")
  end
  if cashycash >= meth[3].cost then
    VMenu.AddFunc(14,"Acheter la vente de meth","menudrogue:meth",{2},"Acheter")
  end
  if cashycash < meth[1].cost and cashycash < meth[2].cost and cashycash < meth[3].cost then
    VMenu.AddSep(14, "Vous n'avez pas assez d'argent")
  end
  VMenu.AddFunc(14,"Retour","menudrogue:info",{},"Retour")
end)

AddEventHandler("menudrogue:meth", function(target, id)
  if id == 0 and not methfield then
    notif("Le champs de meth a été ajouté à votre carte")
    SetBlipTrade(140,tostring(meth[1].name),2,meth[1].x,meth[1].y,meth[1].z)
    DrawMarker(1, meth[1].x,meth[1].y,meth[1].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    TriggerServerEvent("menudrogue:setCash", meth[1].cost)
    cashycash = cashycash - meth[1].cost
    methfield = true
  elseif id == 1 and not methprocess then
    notif("Les traitements de meth ont été ajouté à votre carte")
    SetBlipTrade(50,tostring(meth[2].name),1,meth[2].x,meth[2].y,meth[2].z)
    SetBlipTrade(50,tostring(meth[3].name),1,meth[3].x,meth[3].y,meth[3].z)
    SetBlipTrade(50,tostring(meth[4].name),1,meth[4].x,meth[4].y,meth[4].z)
    DrawMarker(1, meth[2].x,meth[2].y,meth[2].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    DrawMarker(1, meth[3].x,meth[3].y,meth[3].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    DrawMarker(1, meth[4].x,meth[4].y,meth[4].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    TriggerServerEvent("menudrogue:setCash", meth[2].cost)
    cashycash = cashycash - meth[2].cost
    methprocess = true
  elseif id == 2 and not methsell then
    notif("Le vendeur de meth a été ajouté à votre carte")
    SetBlipTrade(277,tostring(meth[5].name),1,meth[5].x,meth[5].y,meth[5].z)
    DrawMarker(1, meth[5].x,meth[5].y,meth[5].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    TriggerServerEvent("menudrogue:setCash", meth[3].cost)
    cashycash = cashycash - meth[3].cost
    methsell = true
  end
end)
--fin meth




--organe
AddEventHandler("menudrogue:infoorg",function()
  VMenu.ResetMenu(14, "Informateur", "default")
  VMenu.curItem = 1
  if cashycash >= organe[1].cost then
    VMenu.AddFunc(14,"Où récolter des organes","menudrogue:org",{0},"Acheter")
  end
  if cashycash >= organe[2].cost then
    VMenu.AddFunc(14,"Acheter les traitements d'organes","menudrogue:org",{1},"Acheter")
  end
  if cashycash >= organe[3].cost then
    VMenu.AddFunc(14,"Acheter la vente d'organes","menudrogue:org",{2},"Acheter")
  end
  if cashycash < organe[1].cost and cashycash < organe[2].cost and cashycash < organe[3].cost then
    VMenu.AddSep(14, "Vous n'avez pas assez d'argent")
  end
  VMenu.AddFunc(14,"Retour","menudrogue:info",{},"Retour")
end)

AddEventHandler("menudrogue:org", function(target, id)
  if id == 0  and not organefield then
    notif("L'emplacement pour récolter des organes a été ajouté à votre carte")
    SetBlipTrade(140,tostring(organe[1].name),2,organe[1].x,organe[1].y,organe[1].z)
    DrawMarker(1, organe[1].x, organe[1].y, organe[1].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    TriggerServerEvent("menudrogue:setCash", organe[1].cost)
    cashycash = cashycash - organe[1].cost
    organefield = true
  elseif id == 1 and not organeprocess then
    notif("Les traitements d'organes a ont été ajouté à votre carte")
    SetBlipTrade(50,tostring(organe[2].name),1,organe[2].x,organe[2].y,organe[2].z)
    SetBlipTrade(50,tostring(organe[3].name),1,organe[3].x,organe[3].y,organe[3].z)
    SetBlipTrade(50,tostring(organe[4].name),1,organe[4].x,organe[4].y,organe[4].z)
    DrawMarker(1, organe[2].x, organe[2].y, organe[2].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    DrawMarker(1, organe[3].x, organe[3].y, organe[3].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    DrawMarker(1, organe[4].x, organe[4].y, organe[4].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    TriggerServerEvent("menudrogue:setCash", organe[2].cost)
    cashycash = cashycash - organe[2].cost
    organeprocess = true
  elseif id == 2  and not organesell then
    notif("Le vendeur d'organes a été ajouté à votre carte")
    SetBlipTrade(277,tostring(organe[5].name),1,organe[5].x,organe[5].y,organe[5].z)
    DrawMarker(1, organe[5].x, organe[5].y, organe[5].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    TriggerServerEvent("menudrogue:setCash", organe[3].cost)
    cashycash = cashycash - organe[3].cost
    organesell = true
  end
end)
-- fin organe



--debut weed
AddEventHandler("menudrogue:infoweed",function()
  VMenu.ResetMenu(14, "Informateur", "default")
  VMenu.curItem = 1
  if cashycash >= weed[1].cost then
    VMenu.AddFunc(14,"Acheter champs de weed","menudrogue:weed",{0},"Acheter")
  end
  if cashycash >= weed[2].cost then
    VMenu.AddFunc(14,"Acheter le traitement de weed","menudrogue:weed",{1},"Acheter")
  end
  if cashycash >= weed[3].cost then
    VMenu.AddFunc(14,"Acheter la vente de weed","menudrogue:weed",{2},"Acheter")
  end
  if cashycash < weed[1].cost and cashycash < weed[2].cost and cashycash < weed[3].cost then
    VMenu.AddSep(14, "Vous n'avez pas assez d'argent")
  end
  VMenu.AddFunc(14,"Retour","menudrogue:info",{},"Retour")
end)

AddEventHandler("menudrogue:weed", function(target, id)
  if id == 0 and not weedfield then
    notif("le champs de weed a été ajouté à votre carte")
    SetBlipTrade(140,tostring(weed[1].name),2,weed[1].x,weed[1].y,weed[1].z)
    DrawMarker(1, weed[1].x,weed[1].y,weed[1].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    TriggerServerEvent("menudrogue:setCash", weed[1].cost)
    cashycash = cashycash - weed[1].cost
    weedfield = true
  elseif id == 1 and not weedprocess then
    notif("Le traitement de weed a été ajouté à votre carte")
    SetBlipTrade(50,tostring(weed[2].name),1,weed[2].x,weed[2].y,weed[2].z)
    DrawMarker(1, weed[2].x,weed[2].y,weed[2].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    TriggerServerEvent("menudrogue:setCash", weed[2].cost)
    cashycash = cashycash - weed[2].cost
    weedprocess = true
  elseif id == 2 and not weedsell then
    notif("Le vendeur de weed a été ajouté à votre carte")
    SetBlipTrade(277,tostring(weed[3].name),1,weed[3].x,weed[3].y,weed[3].z)
    DrawMarker(1, weed[3].x,weed[3].y,weed[3].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    TriggerServerEvent("menudrogue:setCash", weed[3].cost)
    cashycash = cashycash - weed[3].cost
    weedsell = true
  end
end)
--fin weed
function SetBlipTrade(id, text, color, x, y, z)
    local Blip = AddBlipForCoord(x, y, z)

    SetBlipSprite(Blip, id)
    SetBlipColour(Blip, color)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(Blip)
end

function notif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
