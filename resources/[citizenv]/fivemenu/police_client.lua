function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

nameTarget = ""

RegisterNetEvent("menupolice:f_getTargetN")
AddEventHandler('menupolice:f_getTargetN', function(info)
	nameTarget = info[1].. " " ..info[2]
end)

AddEventHandler("menupolice:PoliceOG", function(target, rangPolice) -- 0 rien, 1 Cadet, 2 Brigadier, 3 Sergent, 4 Lieutenant, 5 Capitaine, 6 Commandant
		if target ~= -1 then
				nameTarget = "Vous cilblez un civil"
		else
				nameTarget = "Aucune target"
		end
		VMenu.police = true
		VMenu.ResetMenu(98, "", "default")
		Wait(100)
		VMenu.AddFunc(98, "Retour", "vmenu:MainMenuOG", {}, "Retour")
		VMenu.AddSep(98, tostring(nameTarget))
		if rangPolice == 6 then
				VMenu.AddSep(98, "Commandant")
		elseif rangPolice == 5 then
				VMenu.AddSep(98, "Capitaine")
		elseif rangPolice == 4 then
				VMenu.AddSep(98, "Lieutenant")
		elseif rangPolice == 3 then
				VMenu.AddSep(98, "Sergent")
		elseif rangPolice == 2 then
				VMenu.AddSep(98, "Brigadier")
		elseif rangPolice == 1 then
				VMenu.AddSep(98, "Cadet")
		end
	 	VMenu.AddFunc(98, "Verifier papier", "menupolice:verifp", {}, "Accéder")
	 	VMenu.AddNum1000(98, "Montant contravention", "Amcon", 0, 60000, "Montant de la contravention")
		VMenu.AddFunc(98, "Donner contravention", "menupolice:givecon", {getOpt("Amcon")}, "Accéder")
		VMenu.AddFunc(98, "Fouiller le véhicule le plus près", "menupolice:searchveh", {}, "Accéder")
		VMenu.AddFunc(98, "Fouiller le civil le plus près", "menupolice:searchciv", {}, "Accéder")
		VMenu.AddFunc(98, "Saisir l'argent sale", "menupolice:seizecash", {}, "Accéder")
		VMenu.AddFunc(98, "Saisir les objets illégaux", "menupolice:seizedrug", {}, "Accéder")
		VMenu.AddBool(98, "Escorter un civil menotté", "EscortM", false, "Toggle")
		VMenu.AddBool(98, "Menotter/Démenotter", "Menotter", false, "Toggle")
		VMenu.AddFunc(98, "Forcer l'entrée d'un civil dans un véhicule", "menupolice:civtocar", {}, "Accéder")
		VMenu.AddFunc(98, "Forcer la sortie des civils du véhicule", "menupolice:civuncar", {}, "Accéder")
		VMenu.AddFunc(98, "Enfermer le civil en prison", "menupolice:jail", {}, "Accéder")
		VMenu.AddFunc(98, "Crocheter la serrure du véhicule", "menupolice:unlock", {}, "Accéder")
		VMenu.AddFunc(98, "Consulter la liste des suspects recherchés ", "menupolice:consultwanted", {}, "Accéder")

		-- Ajouter/Retirer dans le commissariat
end)

PhandCuffed = false
PEscorthandCuffed = false
PhandCuffedName = ""

handCuffed = false
EscorthandCuffed = false

EscortGuy = 0

RegisterNetEvent("menupolice:f_cuff")
AddEventHandler('menupolice:f_cuff', function(civitem)
	handCuffed = true
end)

AddEventHandler('menupolice:cuff', function(target)
	PhandCuffed = true
end)

RegisterNetEvent("menupolice:f_escortcuff")
AddEventHandler('menupolice:f_escortcuff', function(civitem, pname, lebool)
	EscortGuy = civitem
	if lebool == true then
		PhandCuffedName  = pname
		EscorthandCuffed = not EscorthandCuffed
		handCuffed = not handCuffed
	else

	end
end)

RegisterNetEvent("menupolice:f_uncuff")
AddEventHandler('menupolice:f_uncuff', function()
	handCuffed = false
end)

AddEventHandler('menupolice:uncuff', function(target)
	if PhandCuffed then
		PhandCuffed = false
	else
		DrawNotif("Aucun civil à proximité n'est menotté")
	end
end)

AddEventHandler('menupolice:consultwanted', function()
	TriggerServerEvent("wanted:getWanted")
end)
