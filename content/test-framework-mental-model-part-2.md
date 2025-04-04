<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Comment les frameworks de tests s'assurent qu'une exception est lancée
_header: ''
_footer: <img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf
footer: Charles Desneuf
-->

# Créer un framework de test - Exception ?

Comment les frameworks de tests font-ils pour s'assurer qu'une exception est lancée ?

<span class="small">Je te rajoute le lien vers l'épisode précédent pas loin ⬇️</span>

---

## Les bases d'un framework de test

On repart d'où on est parti la dernière fois, voici notre framework de test basique :
```js
failedTests = [];

foreach(tests as name => test) {
    try {
        test();
    } catch (exception) {
        failedTests[name] = e;
    }
}

if(failedTests == []) {
    print "Tous les tests ont réussi!";
} else {
    print "Ces tests ont échoué: ";
    foreach(failedTests as failedTest) {
        print failedTest;
    }
}
```

Mais si, souviens-toi, les assertions communiquent les erreurs via des exceptions.



---

## Le problème avec les tests d'exceptions

Quand on veut tester qu'une exception est lancée :

```js

maFonction() {
    throws MonExceptionMetier
}

test4() {
  // Du code qui lance une exception
  maFonction()
}
```

Le framework va capturer cette exception et la considérer comme un échec du test, même si c'est le comportement attendu ! 🤦


---

## Le framework doit être au courant

Il faut signaler au framework qu'on s'attend à une exception **avant** qu'elle ne soit lancée:

```js
maFonction() {
    throws MonExceptionMetier
}

test4() {
  // On indique l'exception attendue d'abord
  expectedException = MonExceptionMetier 
  // Toujours le même code
  maFonction()
}
```

---
<!-- _class: small -->

## Comparer les exceptions

Le framework peut maintenant vérifier si l'exception attrapée correspond à celle attendue :

```diff
failedTests = [];

foreach(tests as name => test) {
+    expectedException = null
    try {
        test();
  } catch (exception) {
+    if(exception != expectedException) {
+      failedTests[name] = exception
+    }
  }
}
```

L'`expectedException` est réinitialisée avant chaque test. Sans ça, si un autre test jette `MonExceptionMetier` alors qu'il ne le devrait pas, il serait quand même vert. 

---

## Ok mais..

Ça fonctionne bien, mais c'est pas encore parfait. Il nous reste encore un problème à régler.


<span class="small">Et à mesure qu'on règle des minis problèmes, on comprend pourquoi se faire son propre framework est sans doute pas une si bonne idée que ça 😅</span>

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
<!-- _class: small -->

## L'exception attendue n'arrive jamais

C'est vrai ça. Pour le moment, si l'exception n'est jamais lancée, le test n'est pas marqué comme en erreur.


```diff

foreach(tests as test) {
    expectedException = null
    try {
        test()
    } catch(exception) {
        if(exception != expectedException) {
            failedTests[] = exception
        }
+       continue        
    }
	
+   if(expectedException) {
+       failedTests[] =
+           NeverReceivedExpectedException(expectedException)
+   }
}
```

Si on a géré une exception, on passe au test d'après avec un `continue`. En revanche, si on attendait une exception, et qu'on ne l'a pas eu, on rajoute une erreur.

---

## Pas de AAA

Le pattern Arrange-Act-Assert ne fonctionne pas pour les tests d'exceptions car le framework doit savoir **avant** l'action qu'une exception est attendue.


---

## Méfiez-vous des expects exceptions de fin de tests

Si vous voyez l'attente d'exception **après** l'action :

```php
$choux->mélangerAvec($carottes);

$this->expectException(OnNePeutPasMélangerDuChouxAvecDesCarottes::class); // Puis l'attente - Trop tard!
```

Ce test ne vérifiera jamais correctement le lancement de l'exception !

Heureusement, le framework de test va vous signaler le problème, puisqu'il va attraper l'exception.

---

## Récap

Puisque les frameworks de tests se basent sur les exceptions pour indiquer une erreur, cela les forces à mettre en place un `try/catch`.

Pour être capable de différencier une exception attendue d'une exception inattendue, il faut l'indiquer au framework de test avant qu'elle soit déclenchée.

C'est pour cela que suivre le pattern Arrange-Act-Assert n'est pas possible quand on veut tester qu'une exception est lancé.

<span class="small">On se retrouve la semaine prochaine pour continuer sur ce sujet 👋</span>