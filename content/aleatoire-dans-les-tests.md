<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Des tests avec des valeurs aléatoires ?
_header: ''
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
footer: <a href="https://www.linkedin.com/in/charles-desneuf/">Charles Desneuf</a>
-->

# Des tests avec des valeurs aléatoires ?
Même si ça fait peur, c'est une très bonne manière d'améliorer les tests automatisés !

---

## Intérêt n°1 : Détection des valeurs en dur

Quand on utilise une valeur fixe dans le test, il est possible de se retrouver avec la même valeur fixe dans le code de production. Avec des valeurs aléatoires, c'est tout de suite plus compliqué.

C'est un bon tips à garder en tête si on fait du TDD en mode *Fake It*.

---

## Intérêt n°2 : Détecter des cas auxquels on n'aurait pas pensé

Ce qui est chouette avec l'aléatoire, c'est qu'on peut tomber sur des choses auxquelles on ne pense pas, et découvrir des comportements qu'on avait pas imaginé.

---

<p class="container big accent-color">
    Pour moi le plus gros intérêt, c'est le suivant.
</p>


<p class="right">
    Mais d'abord, un détour
</p>

---
## Détour : S'outiller

Une bonne astuce pour améliorer la lisibilité et la maintenabilité des tests est de créer des outils pour faire la mise en place dans la partie *Arrange*. Une méthode, un object mother, un builder, une factory...

Ça permet de masquer des informations et de simplifier la lecture du test.

Il est tentant de mettre des valeurs par défaut qui sont utiles dans plein de tests.

---

## Intérêt n°3 : Définir les informations intéressantes

Sauf qu'à la fin, on est perdu...

Le test manque d'informations pour nous permettre de comprendre le comportement que l'on veut illustrer.

En utilisant des valeurs aléatoires dans nos outils, on est obligé de surcharger les valeurs par défaut avec des valeurs importantes pour le comportement.

Ça facilite la compréhension.

---

## Bonus

Maintenant qu'on a uniquement les informations importantes sous les yeux, il est beaucoup plus facile de trouver des idées à tester :
- Je vois un numéro de téléphone, est-ce que cela fonctionne avec un préfix ?
- Une commande de 10 burritos ? Quel est le comportement si j'en commande 0 ?
- ...

On a enlevé du bruit, on s'est concentré sur l'essentiel, ce qui nous laisse de l'espace pour réfléchir.

---

<div class="container middle big accent-color">
    <p>
        2 astuces pour que ça fonctionne bien.
    </p>
</div>

<div class="container middle">
<img src="./gifts.svg" alt="Deux cadeaux" width="75%"/>
</div>


---

## Astuce 1 : Utiliser une librairie

Il existe des librairies dans tous les langages pour générer des valeurs aléatoires intéressantes, comme des noms, des numéros de téléphones, des adresses, des IBANs, ...

Les noms tournent souvent autour de *Faker*.

Pas la peine de réinventer la roue.

---

## Astuce 2 : Faire en sorte de pouvoir controller l'aléatoire

Relancer un test qui échoue avec des valeurs aléatoires c'est pénible.

Fais en sorte de pouvoir controller la *seed* utilisée par le générateur d'aléatoire pour pouvoir obtenir le même tirage, avec un paramètre ou une variable d'environnement.

Du coup, il est intéressant d'afficher cette *seed* lorsque les tests tournent, pour pouvoir la connaitre en cas de problème.

---

## Tu veux améliorer tes tests ?
<!--
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
-->

Si tu rencontres des problèmes de maintenance avec tes tests, s'ils ne sont pas assez lisibles, s'ils cassent pour de mauvaises raisons, je peux t'aider.

<div class="offer">
    <div class="offer-content">
    Télécharge mon guide gratuit pour améliorer la lisibilité des tests.<br /><br />Le lien est en commentaire 👇
    </div>
    <div class="offer-img">
    <a href="https://formation.charlesdesneuf.com/guide-gratuit-5-idees-pour-ameliorer-la-lisibilite-de-vos-tests-automatises?utm_medium=social&utm_source=linkedin&utm_campaign=carousel-Stubbing%20du%20temps%20%3A%20Prendre%20le%20contr%C3%B4le%20du%20syst%C3%A8me">
    <img src="https://formation.charlesdesneuf.com/content-assets/public/eyJhbGciOiJIUzI1NiJ9.eyJvYmplY3Rfa2V5IjoiZHdvazQ1NXZvbDQwdm9rZHNmbXV0NnVxMHF1bCIsImRvbWFpbiI6ImZvcm1hdGlvbi5jaGFybGVzZGVzbmV1Zi5jb20ifQ.NS61AHjRUfdqsvHH6gqCbDNSSyCeI3U3AUlI-7U-PzE" class="free-guide-picture" /></a>
    </div>
</div>
