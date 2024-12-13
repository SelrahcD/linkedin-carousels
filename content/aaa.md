---
marp: true
---
<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Arrange-Act-Assert
_header: ''
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
footer: <a href="https://www.linkedin.com/in/charles-desneuf/">Charles Desneuf</a>
-->

# Arrange<br />Act<br />Assert

Une structure de test reconnaissable au premier coup d’œil

---


## AAA, WTF ?

AAA est une manière de structure les tests en trois phases distinctes. Cette séparation permet de voir rapidement ce qui est mis en place, exécuté et vérifié, et donc de mieux comprendre ce à quoi s'intéresse un test.

- **Arrange** - Préparer le contexte du test.
- **Act** - Exécuter l’action que vous testez.
- **Assert** - Vérifier le résultat.

---

## Arrange

Dans cette phase, vous définissez les conditions initiales. Pensez-y comme le « début de l’histoire », la mise en place du « petit monde » dans lequel le test va s'exécuter.

```php
$burrito = new Burrito(['thon', 'salade', 'oignon', 'avocat']);
```

---

## Act

Ensuite, déclenchez le comportement auquel vous vous intéressez.

C'est le moment de donner une pichenette dans la bille qui va lancer l'histoire.

```php
$burrito->rendreVégétarien();
```

---

## Assert

Vérifiez que le résultat correspond à vos attentes.
Est-ce que tout s'est bien passé comme prévu ?

```php
$this->assertTrue($burrito->estVégétarien());
$this->assertEquals(
    ['oeuf', 'salade', 'oignon', 'avocat'],
    $burrito->ingrédients()
);
```

---

## Les 3 As

On a ainsi une structure que l'on retrouve dans chaque test et qui est interprétable facilement.

```php
$burrito = new Burrito(['thon', 'salade', 'oignon', 'avocat']);

$burrito->rendreVégétarien();

$this->assertTrue($burrito->estVégétarien());
$this->assertEquals(
    ['oeuf', 'salade', 'oignon', 'avocat'],
    $burrito->ingrédients()
);
```

---

## Tips: Utilisez des commentaires pour séparer les phases

Commenter chaque phase aide à bâtir cette habitude.

```php
// Arrange
$burrito = new Burrito(['thon', 'salade', 'oignon', 'avocat', 'riz']);

// Act
$burrito->rendreVégétarien();

// Assert
$this->assertTrue($burrito->estVégétarien());
$this->assertEquals(
    ['oeuf', 'salade', 'oignon', 'avocat', 'riz'],
    $burrito->ingrédients()
);
```

C'est utile au début, mais je vous conseille de vous en passer quand vous êtes prêts.

---

## Variation : Fusionner Act & Assert

Quand l’action est simple, vous pouvez combiner Act et Assert en une seule ligne pour un test plus concis.

```php
$burrito = new Burrito(['thon', 'salade', 'oignon', 'avocat', 'riz']);

$this->assertFalse($burrito->estVégétarien());
```

---

## GWT ??
 
Vous avez peut-être déjà entendu parler de Given / When / Then, du côté du BDD. On peut faire un parallèle très fort avec AAA.

<div class="container big accent-color">
    <table class="simple">
    <tr>
        <td>Given</td><td>Arrange</td>
    </tr>
    <tr>
        <td>When</td><td>Act</td>
    </tr>
    <tr>
        <td>Then</td><td>Assert</td>
    </tr>
    </table>
</div>

---

<!--
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
-->
## Tu veux améliorer tes tests ?

Si tu rencontres des problèmes de maintenance avec tes tests, s'ils ne sont pas assez lisibles, s'ils cassent pour de mauvaises raisons, je peux t'aider.


<div class="offer">
    <div class="offer-content">
    Accède à ma <a href="https://formation.charlesdesneuf.com/ameliorez-vos-tests-automatises?utm_medium=social&utm_source=linkedin&utm_campaign=carousel-arrange-act-assert">ma formation vidéo</a> ou jette un coup d'oeil à mon <a href="https://formation.charlesdesneuf.com/guide-gratuit-5-idees-pour-ameliorer-la-lisibilite-de-vos-tests-automatises?utm_medium=social&utm_source=linkedin&utm_campaign=carousel-arrange-act-assert">guide gratuit pour améliorer la lisibilité des tests</a>.
    </div>
    <div class="offer-img">
    <a href="https://formation.charlesdesneuf.com/guide-gratuit-5-idees-pour-ameliorer-la-lisibilite-de-vos-tests-automatises?utm_medium=social&utm_source=linkedin&utm_campaign=carousel-arrange-act-assert">
    <img src="https://formation.charlesdesneuf.com/content-assets/public/eyJhbGciOiJIUzI1NiJ9.eyJvYmplY3Rfa2V5IjoiZHdvazQ1NXZvbDQwdm9rZHNmbXV0NnVxMHF1bCIsImRvbWFpbiI6ImZvcm1hdGlvbi5jaGFybGVzZGVzbmV1Zi5jb20ifQ.NS61AHjRUfdqsvHH6gqCbDNSSyCeI3U3AUlI-7U-PzE" class="free-guide-picture" /></a>
    </div>
</div>
