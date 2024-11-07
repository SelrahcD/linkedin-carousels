---
marp: true
---

# Arrange-Act-Assert: Une structure de test reconnaissable au premier coup d’œil

---

<!--
theme:  your-theme
size: linkedin
paginate: true
-->


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

## Prêt à essayer ?

Mettre en place AAA dans vos tests les rend plus lisibles et aide les nouveaux développeurs à comprendre rapidement la structure.