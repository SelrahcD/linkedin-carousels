<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Comment fonctionnent les frameworks de test
_header: ''
_footer: <img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf
footer: Charles Desneuf
-->

# Créer un framework de test - la base

Avoir un modèle mental du fonctionnement des frameworks de test aide à écrire de meilleurs tests automatisés.


---

L'idée de ce carousel, et des suivants (abonne-toi 😉), n'est pas de créer un vrai framework de test, mais d'avoir une compréhension basique de leur fonctionnement.

Cela aide à mieux comprendre certaines "règles" d'écriture des tests.

---

## Une boucle sur des fonctions...

La base d'un framework de test est une simple boucle qui exécute des fonctions :

```js
tests =[
    'test1': () => { /* votre code de test */ }
    'test2': () => { /* votre code de test */ }
    'test3': () => { /* votre code de test */ }
];

foreach(tests as test) {
    test();
}
```

---

## Et des assertions qui lancent des exceptions

Les assertions sont le moyen par lequel les tests valident le comportement du code.

Ce sont des fonctions qui jettent des exceptions si les valeurs passées ne correspondent pas à ce que l'on attend.

```php
assertEquals = ($attendu, $réel) => {
    if($attendu != $réel) {
        throw AssertionException(
            "$attendu et $réel ne sont pas égaux"
        )
    }
}
```

Si aucune exception n'est lancée, le test réussit.

---

On a la base de notre framework de test 💪

Mais il est loin d'être parfait...

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

## Le problème de cette approche simple

Avec seulement une boucle et des exceptions, le premier test qui échoue stoppe l'exécution :

```js
tests =[
    'test1': () => { assertEquals("Hello", "Hola") }
    'test2': () => { /* votre code de test */ }
    'test3': () => { /* votre code de test */ }
];

foreach(tests as test) {
    test();
}
```

Ici, `test2` et `test3` ne seront jamais executés car `test1` échoue.

Ce n'est pas idéal - nous voulons exécuter tous nos tests et voir tous les échecs en une seule fois.

---

## La solution: try/catch

Les frameworks de test encapsulent chaque test dans la boucle dans un bloc try/catch:

```js
failedTests = [];

foreach(tests as name => test) {
    try {
        test();
    } catch (Exception e) {
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

---

## La base

Un framework de test c'est:

- une boucle
- des exceptions
- un try/catch
- et de quoi afficher le résultat

La prochaine fois, on discutera de l'impossibilité de suivre le pattern Arrange - Act - Assert quand on s'assure qu'une exception est lancée par le système sous test.
