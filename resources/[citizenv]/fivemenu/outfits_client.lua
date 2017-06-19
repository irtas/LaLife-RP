
function ChangeComponent(args)-- 1:componentID; 2: page; 3: drawbleID; 4: textureID
  SetPedComponentVariation(GetPlayerPed(-1), args[1], args[3], args[4], 2)
end

RegisterNetEvent("vmenu:updateChar")
AddEventHandler("vmenu:updateChar", function(args)
  model = GetHashKey(args[19])
  RequestModel(model)
  while not HasModelLoaded(model) do -- Wait for model to load
    RequestModel(model)
    Citizen.Wait(0)
  end
  SetPlayerModel(PlayerId(), model)
  SetModelAsNoLongerNeeded(model)

	SetPedHeadBlendData(GetPlayerPed(-1), args[1], args[1], args[1], args[1], args[1], args[1], 1.0, 1.0, 1.0, true)
  ChangeComponent({0,0,args[1],args[2]})-- 1:componentID; 2: page; 3: drawbleID; 4: textureID
  ChangeComponent({2,0,args[3],args[4]})
  SetPedHairColor(GetPlayerPed(-1), args[17], args[18])
  ChangeComponent({3,0,args[13],args[14]})
  ChangeComponent({4,0,args[5],args[6]})
  ChangeComponent({6,0,args[7],args[8]})
  ChangeComponent({7,0,args[15],args[16]})
  ChangeComponent({11,0,args[9],args[10]})
  ChangeComponent({8,0,args[11],args[12]})

  VMenu.updatedChar = true
end)

RegisterNetEvent("vmenu:changeGender")
AddEventHandler("vmenu:changeGender", function(gender)
  model = GetHashKey("mp_m_freemode_01")
  if tonumber(gender) == 0 then
    model = GetHashKey("mp_m_freemode_01")
  else
    model = GetHashKey("mp_f_freemode_01")
  end
  RequestModel(model)
  while not HasModelLoaded(model) do -- Wait for model to load
    RequestModel(model)
    Citizen.Wait(0)
  end
  SetPlayerModel(PlayerId(), model)
  SetModelAsNoLongerNeeded(model)
  SetPedComponentVariation(GetPlayerPed(-1), 2, 0, 0, 2)
end)

RegisterNetEvent("vmenu:supdateChar")
AddEventHandler("vmenu:supdateChar", function(o, t, th, f, fi, s, se, e, n, te, el, tw, thi, fo, fif, si, y, u, sev)
  model = GetHashKey(sev)
  RequestModel(model)
  while not HasModelLoaded(model) do -- Wait for model to load
    RequestModel(model)
    Citizen.Wait(0)
  end
  SetPlayerModel(PlayerId(), model)
  SetModelAsNoLongerNeeded(model)

  SetPedHeadBlendData(GetPlayerPed(-1), o, o, o, o, o, o, 1.0, 1.0, 1.0, true)
  ChangeComponent({0,0,o,t})-- 1:componentID; 2: page; 3: drawbleID; 4: textureID
  ChangeComponent({2,0,th,f})
  SetPedHairColor(GetPlayerPed(-1), y, u)
  ChangeComponent({3,0,thi,fo})
  ChangeComponent({4,0,fi,s})
  ChangeComponent({6,0,se,e})
  ChangeComponent({7,0,fif,si})
  ChangeComponent({11,0,n,te})
  ChangeComponent({8,0,el,tw})

  VMenu.updatedChar = true
end)

RegisterNetEvent("vmenu:updateCharInShop")
AddEventHandler("vmenu:updateCharInShop", function(args)
  -- model = args[17]
  --
  -- RequestModel(model)
  -- while not HasModelLoaded(model) do -- Wait for model to load
  --     RequestModel(model)
  --     Citizen.Wait(0)
  -- end
  -- SetPlayerModel(PlayerId(), model)
  -- SetModelAsNoLongerNeeded(model)

  --ChangeComponent({0,0,args[1],args[2]})-- 1:componentID; 2: page; 3: drawbleID; 4: textureID
  --ChangeComponent({2,0,args[3],args[4]})
  ChangeComponent({3,0,args[13],args[14]})
  ChangeComponent({4,0,args[5],args[6]})
  ChangeComponent({6,0,args[7],args[8]})
  ChangeComponent({7,0,args[15],args[16]})
  ChangeComponent({11,0,args[9],args[10]})
  ChangeComponent({8,0,args[11],args[12]})

end)

AddEventHandler("vmenu:OutfitsOG", function(target)
  VMenu.ResetMenu(8, "Tenues", "cloth")
  VMenu.AddMenu(8, "Tenues", "cloth") -- default = Header "Texte" sur fond bleu
  VMenu.AddNum(8, "Catégorie", "Tenues", 0, 65, "Change de catégorie")
  VMenu.AddSep(8, OutfitsCat[1])
  VMenu.AddFunc(8, "Validez catégories tenues", "vmenu:OutfitsValidate", {getOpt("Tenues")}, "Valider")
end)

function menuOutfits(id, no, cat)
  VMenu.ResetMenu(8, "Tenues", "cloth")
  VMenu.AddMenu(8, "Tenues", "cloth") -- default = Header "Texte" sur fond bleu
  VMenu.AddFunc(8, "Retour", "vmenu:OutfitsOG", {}, "Retour")
  VMenu.AddSep(8, cat)
  local i = 0
  for _, item in pairs(outfits) do
    if item.id == id then
      local outfits = {}
      outfits = item
      i = i + 1
    end
  end
  VMenu.AddNum(8, "Tenues", no, 0, i, "Outfits")
  VMenu.AddFunc(8, "Validez votre tenue", "vmenu:OutfitsVal", {getOpt(no), id}, "Valider")
end

AddEventHandler("vmenu:OutfitsValidate", function(target, e)
  if (e == 0) then
    menuOutfits(108, "OutfitsNo1", OutfitsCat[1])
  elseif (e == 1) then
    menuOutfits(109, "OutfitsNo2", OutfitsCat[2])
  elseif (e == 2) then
    menuOutfits(110, "OutfitsNo3", OutfitsCat[3])
  elseif (e == 3) then
    menuOutfits(111, "OutfitsNo4", OutfitsCat[4])
  elseif (e == 4) then
    menuOutfits(112, "OutfitsNo5", OutfitsCat[5])
  elseif (e == 5) then
    menuOutfits(113, "OutfitsNo6", OutfitsCat[6])
  elseif (e == 6) then
    menuOutfits(114, "OutfitsNo7", OutfitsCat[7])
  elseif (e == 7) then
    menuOutfits(115, "OutfitsNo8", OutfitsCat[8])
  elseif (e == 8) then
    menuOutfits(116, "OutfitsNo9", OutfitsCat[9])
  elseif (e == 9) then
    menuOutfits(117, "OutfitsNo10", OutfitsCat[10])
  elseif (e == 10) then
    menuOutfits(118, "OutfitsNo11", OutfitsCat[11])
  elseif (e == 11) then
    menuOutfits(119, "OutfitsNo12", OutfitsCat[12])
  elseif (e == 12) then
    menuOutfits(120, "OutfitsNo13", OutfitsCat[13])
  elseif (e == 13) then
    menuOutfits(121, "OutfitsNo14", OutfitsCat[14])
  elseif (e == 14) then
    menuOutfits(122, "OutfitsNo15", OutfitsCat[15])
  elseif (e == 15) then
    menuOutfits(123, "OutfitsNo16", OutfitsCat[16])
  elseif (e == 16) then
    menuOutfits(124, "OutfitsNo17", OutfitsCat[17])
  elseif (e == 17) then
    menuOutfits(125, "OutfitsNo18", OutfitsCat[18])
  elseif (e == 18) then
    menuOutfits(126, "OutfitsNo19", OutfitsCat[19])
  elseif (e == 19) then
    menuOutfits(127, "OutfitsNo20", OutfitsCat[20])
  elseif (e == 20) then
    menuOutfits(128, "OutfitsNo21", OutfitsCat[21])
  elseif (e == 21) then
    menuOutfits(129, "OutfitsNo22", OutfitsCat[22])
  elseif (e == 22) then
    menuOutfits(130, "OutfitsNo23", OutfitsCat[23])
  elseif (e == 23) then
    menuOutfits(131, "OutfitsNo24", OutfitsCat[24])
  elseif (e == 24) then
    menuOutfits(132, "OutfitsNo25", OutfitsCat[25])
  elseif (e == 25) then
    menuOutfits(133, "OutfitsNo26", OutfitsCat[26])
  elseif (e == 26) then
    menuOutfits(134, "OutfitsNo27", OutfitsCat[27])
  elseif (e == 27) then
    menuOutfits(135, "OutfitsNo28", OutfitsCat[28])
  elseif (e == 28) then
    menuOutfits(136, "OutfitsNo29", OutfitsCat[29])
  elseif (e == 29) then
    menuOutfits(137, "OutfitsNo30", OutfitsCat[30])
  elseif (e == 30) then
    menuOutfits(138, "OutfitsNo31", OutfitsCat[31])
  elseif (e == 31) then
    menuOutfits(139, "OutfitsNo32", OutfitsCat[32])
  elseif (e == 32) then
    menuOutfits(140, "OutfitsNo33", OutfitsCat[33])
  elseif (e == 33) then
    menuOutfits(141, "OutfitsNo34", OutfitsCat[34])
  elseif (e == 34) then
    menuOutfits(142, "OutfitsNo35", OutfitsCat[35])
  elseif (e == 35) then
    menuOutfits(143, "OutfitsNo36", OutfitsCat[36])
  elseif (e == 36) then
    menuOutfits(144, "OutfitsNo37", OutfitsCat[37])
  elseif (e == 37) then
    menuOutfits(145, "OutfitsNo38", OutfitsCat[38])
  elseif (e == 38) then
    menuOutfits(146, "OutfitsNo39", OutfitsCat[39])
  elseif (e == 39) then
    menuOutfits(147, "OutfitsNo40", OutfitsCat[40])
  elseif (e == 40) then
    menuOutfits(148, "OutfitsNo41", OutfitsCat[41])
  elseif (e == 41) then
    menuOutfits(149, "OutfitsNo42", OutfitsCat[42])
  elseif (e == 42) then
    menuOutfits(150, "OutfitsNo43", OutfitsCat[43])
  elseif (e == 43) then
    menuOutfits(151, "OutfitsNo44", OutfitsCat[44])
  elseif (e == 44) then
    menuOutfits(152, "OutfitsNo45", OutfitsCat[45])
  elseif (e == 45) then
    menuOutfits(153, "OutfitsNo46", OutfitsCat[46])
  elseif (e == 46) then
    menuOutfits(154, "OutfitsNo47", OutfitsCat[47])
  elseif (e == 47) then
    menuOutfits(155, "OutfitsNo48", OutfitsCat[48])
  elseif (e == 48) then
    menuOutfits(156, "OutfitsNo49", OutfitsCat[49])
  elseif (e == 49) then
    menuOutfits(157, "OutfitsNo50", OutfitsCat[50])
  elseif (e == 50) then
    menuOutfits(158, "OutfitsNo51", OutfitsCat[51])
  elseif (e == 51) then
    menuOutfits(159, "OutfitsNo52", OutfitsCat[52])
  elseif (e == 52) then
    menuOutfits(160, "OutfitsNo53", OutfitsCat[53])
  elseif (e == 53) then
    menuOutfits(161, "OutfitsNo54", OutfitsCat[54])
  elseif (e == 54) then
    menuOutfits(162, "OutfitsNo55", OutfitsCat[55])
  elseif (e == 55) then
    menuOutfits(163, "OutfitsNo56", OutfitsCat[56])
  elseif (e == 56) then
    menuOutfits(164, "OutfitsNo57", OutfitsCat[57])
  elseif (e == 57) then
    menuOutfits(165, "OutfitsNo58", OutfitsCat[58])
  elseif (e == 58) then
    menuOutfits(166, "OutfitsNo59", OutfitsCat[59])
  elseif (e == 59) then
    menuOutfits(167, "OutfitsNo60", OutfitsCat[60])
  elseif (e == 60) then
    menuOutfits(168, "OutfitsNo61", OutfitsCat[61])
  elseif (e == 61) then
    menuOutfits(169, "OutfitsNo62", OutfitsCat[62])
  elseif (e == 62) then
    menuOutfits(170, "OutfitsNo63", OutfitsCat[63])
  elseif (e == 63) then
    menuOutfits(171, "OutfitsNo64", OutfitsCat[64])
  elseif (e == 64) then
    menuOutfits(172, "OutfitsNo65", OutfitsCat[65])
  elseif (e == 65) then
    menuOutfits(173, "OutfitsNo66", OutfitsCat[66])
  end
end)

AddEventHandler("vmenu:OutfitsVal", function(target, o, h)
  local k = tonumber(o)
  local t = tonumber(h)
  local i = 0
  for _, item in pairs(outfits) do
    if item.id == t then
      i = i + 1
      if i == k then
        args = { item.three[1],item.three[2],item.four[1],item.four[2],item.six[1],item.six[2],item.seven[1],item.seven[2],item.eight[1],item.eight[2],item.eleven[1],item.eleven[2] }
        TriggerServerEvent("vmenu:getOutfit", args)
        break
      end
    end
  end
end)

AddEventHandler("vmenu:JobOutfit", function(o, h)
  local k = tonumber(o)
  local t = tonumber(h)
  local i = 0
  for _, item in pairs(outfits) do
    if item.id == t then
      i = i + 1
      if i == k then
        ChangeComponent({3,0,item.three[1],item.three[2]})
        ChangeComponent({4,0,item.four[1],item.four[2]})
        ChangeComponent({6,0,item.six[1],item.six[2]})
        ChangeComponent({7,0,item.seven[1],item.seven[2]})
        ChangeComponent({11,0,item.eleven[1],item.eleven[2]})
        ChangeComponent({8,0,item.eight[1],item.eight[2]})
        break
      end
    end
  end
end)
