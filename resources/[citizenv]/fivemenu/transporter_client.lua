local TruckerIndex = 0
local MissionTruckerIndex = 0

AddEventHandler("vmenu:TransportOG", function(target, index)
  local index = index
  VMenu.ResetMenu(13, "Livraison", "default")
  VMenu.AddMenu(13, "Livraison", "default")
  if index == 0 then
    VMenu.AddFunc(13, "Citerne", "transporter:optionMission", {0}, "Choisir")
  elseif index == 1 then
    VMenu.AddFunc(13, "Conteneur", "transporter:optionMission", {1}, "Choisir")
  elseif index == 2 then
    VMenu.AddFunc(13, "Réfrigéré", "transporter:optionMission", {2}, "Choisir")
  elseif index == 3 then
    VMenu.AddFunc(13, "Bois", "transporter:optionMission", {3}, "Choisir")
  end
end)

AddEventHandler("transporter:optionMission", function(target, index)
  local index = index
  TruckerIndex = index
  TriggerEvent("transporter:optionMisson2", TruckerIndex)
  VMenu.ResetMenu(13, "Livraison", "default")
  VMenu.AddMenu(13, "Livraison", "default")
  VMenu.AddFunc(13, "Retour", "vmenu:TransportOG", {TruckerIndex}, "Retour")
  VMenu.AddFunc(13, "Destination #1", "transporter:mission", {0}, "Choisir")
  VMenu.AddFunc(13, "Destination #2", "transporter:mission", {1}, "Choisir")
  VMenu.AddFunc(13, "Destination #3", "transporter:mission", {2}, "Choisir")
  VMenu.AddFunc(13, "Destination #4", "transporter:mission", {3}, "Choisir")
  if index == 2 then
    VMenu.AddFunc(13, "Destination #1", "transporter:mission", {4}, "Choisir")
    VMenu.AddFunc(13, "Destination #2", "transporter:mission", {5}, "Choisir")
    VMenu.AddFunc(13, "Destination #3", "transporter:mission", {6}, "Choisir")
    VMenu.AddFunc(13, "Destination #4", "transporter:mission", {7}, "Choisir")
    VMenu.AddFunc(13, "Destination #5", "transporter:mission", {8}, "Choisir")
  end
end)

AddEventHandler("transporter:mission", function(target, index)
  local index = index
  MissionTruckerIndex = index
  TriggerEvent("transporter:mission2", MissionTruckerIndex, TruckerIndex)
end)
