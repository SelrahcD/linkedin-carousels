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


# Le builder pattern dans les tests

Une structure de test reconnaissable au premier coup d’œil

---


## Arrange-Act-Assert ?

AAA rend les tests plus faciles à comprendre et à maintenir en divisant chaque test en trois phases distinctes. Cette séparation permet de voir rapidement ce qui est mis en place, exécuté et vérifié.

- **Arrange** - Préparer le contexte du test.
- **Act** - Exécuter l’action que vous testez.
- **Assert** - Vérifier le résultat.

---

## Arrange

Dans cette phase, vous définissez les conditions initiales. Pensez-y comme le « début » de l’histoire.

```php
$burrito = new Burrito(['thon', 'salade', 'oignon', 'avocat']);
```

---

## Act

Ensuite, déclenchez le comportement que vous souhaitez tester.

```php
$burrito->rendreVégétarien();
```

---

## Assert

Vérifiez que le résultat correspond à vos attentes.

```php
$this->assertTrue($burrito->estVégétarien());
$this->assertEquals(
    ['oeuf', 'salade', 'oignon', 'avocat'],
    $burrito->ingrédients()
);
```

---

## Variation : Fusionner Act & Assert

Quand l’action est simple, vous pouvez combiner Act et Assert en une seule ligne pour un test plus concis.

```php
$burrito = new Burrito(['thon']);
$this->assertFalse($burrito->estVégétarien());
```

---

## Utilisez des commentaires pour séparer les phases

Commenter chaque phase aide à bâtir cette habitude et clarifie votre intention pour les futurs lecteurs.

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

---

## Prêt à essayer ?
<!--
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
-->
Mettre en place AAA dans vos tests les rend plus lisibles et aide les nouveaux développeurs à comprendre rapidement la structure.