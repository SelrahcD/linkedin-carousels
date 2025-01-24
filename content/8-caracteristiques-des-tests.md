<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: 8 caractéristiques importantes des tests
_header: ''
_footer: <img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf
footer: Charles Desneuf
-->

# Un bon test automatisé, c'est quoi ?
Voici les 8 caractéristiques clés qui permettent d'avoir des tests automatisés fiables, maintenables et avec lequel il est agréable de travailler.

---

## Vérifiables automatiquement
Les tests doivent pouvoir indiquer eux-mêmes s’ils réussissent ou échouent, sans intervention humaine.
Pas besoin d'aller examiner le résultat, si ça casse, le test doit le faire savoir.

---

## Déterministes
Les tests doivent toujours donner le même résultat pour les mêmes données d'entrée. Sans ça, il est difficile de les vérifier automatiquement.

<br />
Des tests qui échouent de manière aléatoires font perdre du temps et réduisent la valeur que nous accordons à la suite de tests car ils diminuent la confiance qu'on lui porte.

---

## Répétables
Ils doivent pouvoir être relancés de façon automatique, sans intervention manuelle.
Pas question de faire du nettoyage à la main après les avoir lancés.

---

## Indépendants
Chaque test doit être autonome et ne pas dépendre des autres, garantissant des résultats stables et prévisibles, et permet de faciliter la compréhension en cas d'échec.

<br />
Cela permet aussi:

- de lancer les tests en parallèles pour aller plus vite
- de ne lancer qu'un seul test avec un débogueur
- de ne lancer que certains tests

---

## Rapides
Les tests doivent s'exécuter rapidement, minimisant le temps d'attente et permettant des retours plus fréquents pour pouvoir détecter les problèmes au plus tôt.

<br />

Et comme ça on est pas tenté d'aller glander sur Linkedin.

<br />
C'est une des clefs si vous voulez faire du TDD.

---

## Précis
Chaque test doit se concentrer sur un seul aspect, facilitant la localisation des erreurs et la résolution des problèmes.
Lorsqu'un test échoue on veut pouvoir comprendre le plus rapidement possible la cause du problème. 

---

## Lisibles
La lisibilité du test est essentielle pour en garantir la compréhension et la maintenance.

<br />
Rien de plus pénible que de se retrouver face à un test incompréhensible qui échoue.

<br />
En plus, des tests lisibles peuvent servir de documentation, même pour les non devs.

---

## Robustes
Les tests doivent être résistants aux changements d'implémentation, nécessitant des modifications seulement en cas de changements fonctionnels.

<br />
Qui a envie de modifier 200 tests parce qu'un paramètre a été ajouté à un constructeur ou que deux classes ne collaborent plus de la même manière ?

---
## Les 8 caractéristiques

- Vérifiables automatiquement
- Déterministes
- Répétables
- Indépendants
- Rapides
- Précis
- Lisibles
- Robustes
---

## Tu veux améliorer tes tests ?
<!--
_footer: <img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf
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
