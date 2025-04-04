<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Comment les frameworks de tests nettoient après les tests
_header: ''
_footer: <img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf
footer: Charles Desneuf
-->

# Créer un framework de test - Le tearDown

Comment bien nettoyer après un test, même en cas d'échec ?

<span class="small">Je te rajoute les liens vers les épisodes précédents pas loin ⬇️</span>

---

## Rafraîchissons notre mémoire

Voici où nous en étions avec notre framework de test basique :

```js
tests = [
    test1() {
        expectedException = MySuperException
        // Code qui lance MySuperException ...
    },
    test2() {...}
];

failedTests = [];

foreach(tests as name => test) {
    expectedException = null
    try {
        test();
    } catch (exception) {
        if(exception != expectedException) {
            failedTests[name] = exception;
        }
        continue;
    }

    if(expectedException) {
        failedTests[name] = NeverReceivedExpectedException(expectedException);
    }
}

// Afficher les tests en échec
```

---

## Le problème des ressources non libérées

Imaginons un test qui utilise une connexion à une base de données :

```js
testAvecConnexion() {
    connexion = ouvrirConnexion();
    // Faire des opérations
    assertSomething();
    fermerConnexion(); // 👈 Cette ligne ne sera jamais exécutée en cas d'échec !
}
```

Si l'assertion échoue ou si une exception est lancée, le test se termine prématurément et la connexion n'est jamais fermée !

Cela peut épuiser votre pool de connexions et faire échouer d'autres tests.

---

## Le problème des ressources partagées

Un autre exemple avec deux tests qui utilisent une collection partagée :

```js
test1() {
    ajouterBurritoALaCollection('Burrito Suisse');
    // Tester quelque chose avec le burrito ...
    retirerBurritoDelaCollection('Burrito Suisse'); // 👈 Jamais exécuté si échec
}

test2() {
    ajouterBurritoALaCollection('Burrito Français');
    ajouterBurritoALaCollection('Burrito Mexicain');
    
    assertEqual(2, nombreDeBurritos()); // 👈 Échouera s'il y a déjà un burrito
    
    retirerBurritoDelaCollection('Burrito Français');
    retirerBurritoDelaCollection('Burrito Mexicain');
}
```

Si test1 échoue, le burrito reste dans la collection et test2 échouera aussi !

---

## L'indépendance des tests est compromise

Ces problèmes violent un principe fondamental des tests : **l'indépendance**.

Un test ne devrait jamais impacter l'exécution d'un autre test.

Avec le code actuel, un test qui échoue peut faire échouer d'autres tests qui n'ont rien à voir avec le problème initial.

---

## La naissance du tearDown

Pour résoudre ce problème, les frameworks de test ont introduit le concept de **tearDown** :

```diff
foreach(tests as name => test)
{
+   tearDown = null;
    expectedException = null;
    try {
        test();
    } catch (exception) {
        if (exception != expectedException) {
            failedTests[name] = exception;
        }
        continue;
+    } finally {
+        if (tearDown) {
+            tearDown();
+        }
+    }

    if(expectedException) {
        failedTests[name] = NeverReceivedExpectedException(expectedException);
    }
}
```
Une fonction qui est exécutée même en cas d'échec du test.

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

## Utiliser le tearDown dans nos tests

Voici comment nos tests précédents pourraient utiliser tearDown :

```js
testAvecConnexion() {
    tearDown = () => {
        fermerConnexion();
    }

    connexion = ouvrirConnexion();
    // Faire des opérations
    assertSomething();
}
```

Le tearDown sera exécuté que le test réussisse ou échoue, et la connexion fermée.

---

## Exemple avec les burritos

Et pour notre problème de collection de burritos :

```js
test1() {
    tearDown = () => {
        retirerBurritoDelaCollection('Burrito Suisse');
    }

    ajouterBurritoALaCollection('Burrito Suisse');
    // Tester quelque chose avec le burrito
}

test2() {
    tearDown = () => {
        retirerBurritoDelaCollection('Burrito Français');
        retirerBurritoDelaCollection('Burrito Mexicain');
    }

    ajouterBurritoALaCollection('Burrito Français');
    ajouterBurritoALaCollection('Burrito Mexicain');
    assertEqual(2, nombreDeBurritos());
}
```

---

## Ma théorie sur le setUp

Le tearDown est indispensable pour maintenir l'indépendance des tests. Mais d'où vient le setUp ?

Ma théorie : **le setUp a été créé par symétrie avec le tearDown**.

Si nous avons une méthode pour nettoyer après chaque test, pourquoi ne pas avoir une méthode pour préparer chaque test ?

---

## Le setUp est pratique, le tearDown est crucial

- **setUp** : Factorisation pratique pour éviter la répétition dans la préparation des tests
- **tearDown** : Nécessaire pour garantir l'indépendance des tests

Paradoxalement, le tearDown est souvent moins utilisé que le setUp, alors qu'il est plus important pour la stabilité de la suite de tests.

---

## En résumé

- Le tearDown garantit que le nettoyage s'effectue même en cas d'échec d'un test
- Il assure l'indépendance des tests en évitant les effets de bord
- Il est crucial pour les ressources partagées (base de données, fichiers, etc.)
- Le setUp est probablement apparu par symétrie, pour factoriser le code de préparation