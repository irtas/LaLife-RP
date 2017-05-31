# La Life RP

[Discord](https://discord.gg/aiekillu)
Pour le support sur le scripting de FiveM en général.

[Twitter](https://twitter.com/Lalife_rp)

## Modifications

**La_LifeRP/citmp-server.yml**

- Pour mofifier votre nom de serveur:  Hostname: VOTRE NOM DE SERVEUR
Pour les couleurs: ^1 = Rouge ^2 = Vert ^3 = Jaune^4 = Bleu ^5 = CYAN^6 = Rose ^7/^0 = Blanc^9 = Gris^0= Noir | Exemple: ^3[^5F^0R^1A^3]
- Icone du serveur: ServerIcon: hello.png mettre l'image choisi dans le folder La_Life en 800x800

**La_LifeRP/resources/[jobs]/salaire/salaire_server.lua**

local salary = 500 (Modifier par votre aide sociale)

**La_LifeRP/resources/[jobs]/salaire/salaire_client.lua**

Citizen.Wait(600000) -- Modifier cette valeur pour la fréquence des salaires (600000 = 10 minutes)

**La_LifeRP/resources/[jobs]/Ficher au choix**

Cherchez les coordonnées que vous pouvez modifier, les prix/coûts

Pour le trucker job, vers la ligne 216

[0] = {263.392, -2851.05, 5.99999, 5000}, (x,y,z,argent à la fin)
[1] = {529.998, -2285.18, 5.98135, 10000},
...

**La_LifeRP/resources/[essential]/es_weashop/weashop.lua**

Prix et armes disponibles à l'achat

**La_LifeRP/resources/[essential]/es_freeroam/stores/vehshop.lua**

Prix et véhicules disponibles à l'achat

**La_LifeRP/resources/[citizenv]/foodhud/**

config de foodhud et de frfuel disponible.
