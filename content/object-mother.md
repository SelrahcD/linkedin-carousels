<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Object mother - Créer facilement des objets courants
_header: ''
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
footer: <a href="https://www.linkedin.com/in/charles-desneuf/">Charles Desneuf</a>
-->

# Object Mother

Créer facilement des objets courants, éviter que les tests cassent pour de mauvaises raisons, et améliorer la lisibilité.

Une belle promesse !

---

## Le problème

Imagine que tu instancies plein de Burritos dans tes tests, genre dans tous tes tests, ou presque.

```php
new Burrito(['riz', 'salade', 'thon']);
```

et que demain tu doives rajouter un paramètre au constructeur de la classe Burrito.

Le prix par exemple.

---

## Le problème

Il va falloir passer sur chaque instanciation de Burrito pour rajouter le paramètre.

```diff
- new Burrito(['riz', 'salade', 'thon']); x 100
+ new Burrito(['riz', 'salade', 'thon'], 7.50); x 100
```

Ça va être un mauvais moment à passer 😭

---

## La solution

Créer une factory pour créer les Burritos et l'utiliser dans les tests.

```php
final class BurritoFabrique
{
    public static function unBurrito(): Burrito {
        return new Burrito(['riz', 'salade', 'thon'], 7.50);
    }
}
```

Et l'utiliser dans les tests :

```diff
+ BurritoFabrique::unBurrito()
- new Burrito(['riz', 'salade', 'thon'], 7.50);
```

---

## Avantage 1 : Une seule édition

Maintenant, s'il faut modifier les paramètres du constructeur de Burrito, on peut le faire à un seul endroit.

Gros gain de temps et de facilitation des tests.

```diff
final class BurritoFabrique
{
    public static function unBurrito(): Burrito {
-         return new Burrito(['riz', 'salade', 'thon'], 7.50);
+         return new Burrito(['riz', 'salade', 'thon'], 7.50, 'Super Tuna');
    }
}
```

---

## Avantage 2 : Moins de bruit

Certains tests ne vont s'intéresser ni aux ingrédients, ni au prix, ni au nom du burrito. Ils ont simplement besoin d'un burrito.

Avant, il fallait toujours ajouter ces paramètres, ce qui rajoutait du bruit. On veut un burrito, n'importe que lequel.

---

## Avantage 2 : Moins de bruit

Maintenant, grâce à l'Object Mother, on peut obtenir "un burrito", et on ne sait rien de plus sur lui.

Ça améliore la lisibilité et la compréhension des tests. Plus besoin de se demander si le prix a un intérêt pour le comportement auquel on s'intéresse.

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

## Inconvénient

Le pattern Object Mother ne permet de paramétrer l'objet qui est créé. 

Si on veut un burrito avec certains ingrédients, ou un certain prix, on est bloqué.

Comment faire ?

---
## Inconvénient

Il y a plusieurs solutions :
- Dans les tests qui demandent de la précision, on peut utiliser le constructeur directement
- Ou une méthode privée qui a besoin de moins de paramètres
- Ou, appeler des méthodes sur l'object créé pour le modifier après-coup

<span class="small">Ou utiliser un autre pattern, mais ça sera pour une autre fois 😉</span>

---

## Tips : Utiliser une fonction

Une astuce pour améliorer davantage la lisibilité des tests est d'utiliser une fonction pour encapsuler l'Object Mother
```php
function unBurrito() {
    return BurritoFabrique::unBurrito();
}
```

Dans les tests, on peut désormais écrire

```php
$unBurrito = unBurrito();
```

Sympa, non ?


---

## Quand l'utiliser ?

Comme on vient de le voir, ce pattern a des avantages, mais aussi un gros défaut puisqu'il ne permet pas de paramétrer la création des objets.

Il est utile quand on veut pouvoir facilement créer des choses courantes dans un système :
- un type d'utilisateur (un admin, une cuisinier, un client végétarien)
- un object fréquent (un burrito, une voiture)
- une personne en particulier (Michel de la compta)
