FiveMenu v1.4

 Ce guide a été fait par GeeknessFr au tout début du menu.
 Le menu a largement évolué depuis que je l'ai en ma possession (Draziak)
 Évolution en bien, comme en moins bien avec l'ajout de plusieurs trucs souvent trop complexes pour rien.
 Donc ce guide n'est peut-être plus à jour. Peut-être.


	Touche par défaut pour afficher/masquer le menu : F1
	Navigation :
		- Clavier :
		- Haut, Bas, Gauche, Droite
		- Entrée pour valider
		- BackSpace (Retour arrière) pour revenir au menu précédent.

		- Manette (XBox) :
		- D-Pad : Haut, Bas, Gauche, Droite
		- A pour valider
		- B pour revenir au menu précédent.

		Pas de touche manette pour ouvrir le menu. (Pas encore, peut-être plus tard...)




Configuration dans le Fichier "fivemenu_client.lua"
---------------------------------------------------

Zones du fichier :

CONFIGURATION : (En Haut)

	Permet de changer quelques options de position, largeur, nombre de lignes...

	--> Possibilité de changer les touches, mais à vos risques et périls !
	J'ai ajouté des "Filtres" spécifiques à ces touches là pour ne pas déclencher le menu par erreur avec la manette
	et en même temps pouvoir naviguer dedans avec la manette sans faire d'actions en jeu.

	voiceTarget : Active/Désactive le ciblage à la voix.
		- Si activé, VMenu.target contiendra le PlayerID de la dernière personne parlant à l'ouverture du menu.
		- Détection dans un rayon de 3m

	checkUser : Active/Désactive la récupération des infos du joueur via Essential Mod.
		- Voir plus bas "TABLE 'User'"


CREATION DU MENU (Presque tout en bas du fichier) :

	Construction des Menus / Sous-Menus avec chaque type d'actions :

	menu = ID_MENU  --<-- Permet de ne pas avoir à recopier l'ID du Menu qu'on est en train d'éditer.
	VMenu.AddMenu(menu, "Nom du Menu", "fond_header") (--> Voir plus bas pour le Header <--)

	-- Vers un Sous-Menu
	VMenu.AddSub(menu, "Nom", ID_MENU, "Description")
	-- ex:
		-- VMenu.AddSub(menu, "Actions", 2, "Lancer une Action")


	-- Execute une fonction via un Trigger Local
	VMenu.AddFunc(menu, "Nom", "event_trigger", {"Option 1", "Option 2", ...}, "Description")
	-- ex:
		-- VMenu.AddFunc(menu, "Spawn Adder", "vmenu:spawnVeh", {"adder"}, "Spawn d'une Adder")
		-- Effectue un TriggerEvent("event_trigger", Target, [param1, param2, ...])
		-- 	Target = Dernière personne à avoir parlé avant ouverture du menu.


	-- Affiche un nombre en bout de ligne (non modifiable) et va vers un Sous-Menu
	VMenu.AddValSub(menu, "Nom", "Identifiant_Option", VALEUR_DEFAUT, ID_MENU, "Description")
	-- ex:
		-- VMenu.AddValSub(menu, "Bouteilles d'eau", "WaterBottles", 0, 4, nil)  -- Ici Description à nil = Aucune description


	-- Option Toggle - Booleen, Vrai / Faux avec Case à cocher en bout de ligne
	VMenu.AddBool(menu, "Nom", "Identifiant_Option", VALEUR_DEFAUT, "Description") -- Valeur : True ou False
	-- ex:
		-- VMenu.AddBool(menu, "Moteur", "Engine", false, "Marche/Arrêt Moteur")


	-- Option Nombre, Affiche un nombre modifiable en fin de ligne
	VMenu.AddNum(menu, "Nom", "Identifiant_Option", VALEUR_MIN, VALEUR_MAX, "Description")
	-- ex:
		-- VMenu.AddNum(menu, "Couleur Principale", "VehColor", 0, 160, "Change la couleur principale du véhicule")



BOUCLE : (Tout en bas)

	- une partie pour mettre à jour les valeurs du menu pendant qu'il est ouvert
	- Une seconde partie pour lancer les actions au moment de changement d'état.
		- Par exemple pour les AddBool et AddNum

	Fonction utilisables :

	- getOpt("Identifiant_Option") -- Récupère la valeur actuelle d'une optrion.
	- setOpt("Identifiant_Option", VALEUR) -- Enregistre une valeur sur une option.



Autre :

Les EVENTS Possibles :

	Events Client :

	- vmenu:toggleMenu
		- Ouvre ou Ferme le menu selon l'état.

	- vmenu:openMenu, [ID_MENU]
		- Ouvre le menu
		- ID_MENU : Permet d'ouvrir une page en particulier, 0 par défaut

	- vmenu:closeMenu
		- ferme le menu

	- vmenu:serverOpenMenu ---- Réservé au fonctionnement du menu.
		- Event réservé à l'ouverture du menu APRES mise à jour serveur uniquement.
		- toggleMenu ou openMenu envoient un Event Server "vmenu:getUpdates" qui à son tour renvoie au client "vmenu:serverOpenMenu" pour mettre à jour les valeurs du menu avant ouverture.
		- Voir le fichier "fivemenu_server.lua" pour mettre à jour les valeurs renvoyées.


	Event Serveur :
	- vmenu:getUpdates (Dans le fichier fivemenu_server.lua)
		- Met à jour les valeurs pour le menu avant ouverture.




TABLE 'User' :
	- Au chargement du Menu, les infos de l'utilisateur sont récupérées de la base de donnée (via EssentialMod)

	- User.identifier : SteamID
	- User.group : Groupe utilisateur
	- User.permission_level : Niveau de permission




TEXTURES HEADERS :

	Fichier dictionnaire : stream/fivemenu.ytd

	A éditer avec OpenIV

	Les fond actuels :

	"default" : Fond avec nom du menu en texte sur fond bleu.
	"header_bgd" : Fond Générique
	"carmod" : Fond Los Santos Customs

	nil : Aucun Header


	Vous pouvez ajouter / renommer / supprimer des textures de header dans le fichier YTD, ensuite il suffit d'utiliser le nom de la texture dans VMenu:AddMenu(...)

	--> Attention à ne pas supprimer les autres textures. Mais vous pouvez toujours les remplacer si vous voulez.
