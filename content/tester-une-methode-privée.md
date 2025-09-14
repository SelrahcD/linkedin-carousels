<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Comment tester une méthode privée ?
_header: ''
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
footer: <a href="https://www.linkedin.com/in/charles-desneuf/">Charles Desneuf</a>
-->

# Comment tester une méthode privée ?
On se demande souvent comment tester une méthode privée… mais la vraie question est : doit-on le faire ?

---

## Une méthode privée : un détail d'implémentation
Quand on teste, **on ne teste pas une méthode** mais un comportement. La méthode privée n'est qu'un **détail de l'implémentation**.

---

## Tester un comportement
Ce qui nous intéresse, c'est ce que fait le logiciel, pas comment il le fait.

On teste donc les comportements via la méthode publique qui les expose, sans se soucier des méthodes privées sous-jacentes.

---

## Exercer la méthode privée
En testant un comportement, **on va exercer la méthode privée**.

On peut dire qu'on "teste" une méthode privée de cette façon, mais en réalité, c'est le comportement qu’on vérifie.

---
<!--
_footer: <img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf
_paginate: skip
-->

## Hop, une petite pause avant la suite !

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

---

## Et si la méthode privée est complexe ?
Si le code privé est trop complexe, cela peut indiquer un besoin de refactorer.

Peut-être manque-t-il un concept ou un collaborateur dans la conception ?

Je parle souvent "d'écouter les tests."

**Quand un bout de code est difficile à tester, ce n'est souvent pas le test qui est en cause, mais la conception du code**.

---

## Introduire un nouveau concept
En extrayant la méthode privée dans une nouvelle classe, nous rendons la méthode publique et simplifions les tests.

Plus besoin d'astuces, ni de réfléchir à tester du code privé.

Et au passage, on a sans doute amélioré l'expressivité de notre code en ajoutant et nommant de nouveaux concepts. 

---

## La réponse est donc : on ne la teste pas

Si cette méthode est assez simple pour être exercée au travers d'une méthode public, faisons comme ça.

Sinon, il est préférable de résoudre le problème de conception, la méthode privée n'existe plus, elle est désormais public et on peut la tester directement.