<!--

header: Arrange - Act - Assert
_header: ''
footer: <a href="https://www.linkedin.com/in/charles-desneuf/">Charles Desneuf</a>
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="https://media.licdn.com/dms/image/v2/D4E35AQEvMvIj--FWvA/profile-framedphoto-shrink_200_200/profile-framedphoto-shrink_200_200/0/1673718383658?e=1731524400&v=beta&t=jFmZoW0toAoh9YsOBjwTbbRtE5hDS99IC16XPZZLtdw" class="profile-picture">Charles Desneuf</a>
paginate: true
_paginate: skip
style: |


  .profile-picture {
    margin: 0;
    height: 150px;
    width: 150px;
    border-radius: 80px;
  }

  section[id="1"] > footer {
    height:200px;
  }

  footer img {
    vertical-align:middle;
    padding-right: 20px;
  }

  footer a {
    text-decoration: none;
  }

  section[id="8"] > footer {
    height:200px;
  }

  h1 {
    width: 50%;
    padding-left: 15%;
  }

-->

# Arrange-Act-Assert: Une structure de test reconnaissable au premier coup d’œil

---

## 📜 Pourquoi AAA est important

AAA rend les tests plus faciles à comprendre et à maintenir en divisant chaque test en trois phases distinctes. Cette séparation permet de voir rapidement ce qui est mis en place, exécuté et vérifié.

- **Arrange** - Préparer le contexte du test.
- **Act** - Exécuter l’action que vous testez.
- **Assert** - Vérifier le résultat.

---

## 1️⃣ Arrange

Dans cette phase, vous définissez les conditions initiales. Pensez-y comme le « début » de l’histoire.

```php
$burrito = new Burrito(['thon', 'salade', 'oignon', 'avocat', 'riz']);
```

---

## 2️⃣ Act

Ensuite, déclenchez le comportement que vous souhaitez tester.

```php
$burrito->rendreVégétarien();
```

---

## 3️⃣ Assert

Vérifiez que le résultat correspond à vos attentes.

```php
$this->assertTrue($burrito->estVégétarien());
$this->assertEquals(['oeuf', 'salade', 'oignon', 'avocat', 'riz'], $burrito->ingrédients());
```

---

## 💡 Variation : Fusionner Act & Assert

Quand l’action est simple, vous pouvez combiner Act et Assert en une seule ligne pour un test plus concis.

```php
$burrito = new Burrito(['thon']);
$this->assertFalse($burrito->estVégétarien());
```

---

## 🛠️ Utilisez des commentaires pour séparer les phases

Commenter chaque phase aide à bâtir cette habitude et clarifie votre intention pour les futurs lecteurs.

---

<!--
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="https://media.licdn.com/dms/image/v2/D4E35AQEvMvIj--FWvA/profile-framedphoto-shrink_200_200/profile-framedphoto-shrink_200_200/0/1673718383658?e=1731524400&v=beta&t=jFmZoW0toAoh9YsOBjwTbbRtE5hDS99IC16XPZZLtdw" class="profile-picture">Charles Desneuf</a>
_paginate: false
-->

## Prêt à essayer ?

Mettre en place AAA dans vos tests les rend plus lisibles et aide les nouveaux développeurs à comprendre rapidement la structure.
