# Micro-tutos pour La Life RP 
(pour une utilisation plus optimale)

[Discord](https://discord.gg/aiekillu)
Pour le support sur le scripting de FiveM en général.

[Twitter](https://twitter.com/Lalife_rp)

##  Changer le "Propulsé by La Life"

Tout d'abord il vous faudra forcément un logiciel nommé IDE.

Dans le cas présent nous partirons du principe que vous utilisez Windows, de ce fait, allez télécharger [Visual Studio Community](https://www.visualstudio.com/fr/?rr=https%3A%2F%2Fsearch.lilo.org%2Fsearchweb.php%3Fq%3Dvisual%2Bstudio%2B)

Vous aurez bien entendu besoin de l'installer, cela peut prendre ± de temps.

Une fois que tout est bon, vous pouvez ouvrir CitizenVWrapper.sln.

C'est là que ça peut sembler compliqué, une nouvelle interface à paramétrer et du code partout, quand on est pas habitués, ça fait peur. (quand on sait pas coder, encore plus)

Pour modifier ledit texte regardez sur votre droite et vous verrez un menu avec quelques fichiers, double cliquez sur Freeroam.cs pour l'ouvrir.

Plus qu'à chercher dedans où est le texte en question (j'allais pas tout vous donner quand même !)

Viens ensuite le besoin de générer le code, de créer CitizenVWrapper.net.dll qui contiendra plusieurs fonctionnalités pour votre serveur mais surtout c'est ce document qui va modifier le texte du menu Pause.

Voici ma solution pour ces sources : Cliquez sur le menu Projet en haut du logiciel, et cliquez ensuite sur Gérer les packages NuGet... **(D'AUTRES SOLUTIONS SONT POSSIBLES)**
Une nouvelle fenêtre va s'ouvrir, sélectionnez "Parcourir" et dans la barre de recherche, tapez CitizenFX.Core. Une fois qu'il est trouvé, cliquez dessus et installez le.

Une fois que tout est bon, vous n'avez plus qu'à cliquer sur "Générer" et "Générer la solution". **IL EST POSSIBLE QU'A LA FIN DE LA GENERATION UNE ERREUR S'AFFICHE N'EN TENEZ PAS COMPTE**

Si la génération est complète, vous devriez voir en bas du logiciel :

**========== Génération : 1 a réussi, 0 a échoué, 0 mis à jour, 0 a été ignoré ==========**

**OU**

**========== Génération : 0 a réussi, 0 a échoué, 1 mis à jour, 0 a été ignoré ==========**

Si vous ne voyez ni l'un, ni l'autre de ces messages mais au contraire que quelque chose a échoué, relisez bien ce micro-tuto, vous avez fait une erreur.

Vous irez ensuite chercher le .dll dans le dossier Freeroam > bin > release **OU** debug > CitizenVWrapper.net.dll

Copiez le et collez le dans le dossier resources > Wrapper de votre dossier La_LifeRP.

## Cacher les cercles bleus (pour les lieux illégaux par exemple)

C'est sur qu'avoir un cercle bleu qui dit "ATTENTION IL Y A UN POINT POUR DE LA DROGUE ICI" c'est pas pratique et pas discret.

Pour les cacher c'est ultra simple du coup, on va prendre l'exemple de la Coke, parce que la coke c'est bien, mangez.. Non en fait non.

Pour cela, rien de plus simple : Rendez vous dans resources > [jobs] > tradeIlegal > coke.lua (dans notre cas)

Ouvrez le fichier avec votre éditeur de texte favori et en haut de votre fichier, vous trouverez :

"local DrawMarkerShow = true"

Passez le a "false" pour désactiver tout les cercles bleu. 
Pour désactiver un cercle en particulier, vous devrez commenter le code contenu dans "if DrawMarkerShow then" suivant le/les point(s) que ne voulez pas afficher.

Si la couleur ne vous plait pas, il semblerait que cela fonctionne en RGB (Red|Green|Blue) et le bleu est de base à 255 et le vert à 75 **(attention je présume, quand j'aurai la preuve de ce que j'avance cette partie sera modifiée)** donc si vous changez cette valeur, la nuance de bleu va évoluer (forcément)

## FIN
