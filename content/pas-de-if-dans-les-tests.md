---
marp: true
---
<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Pas de if dans les tests
_header: ''
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
footer: <a href="https://www.linkedin.com/in/charles-desneuf/">Charles Desneuf</a>
-->

# Pas de if dans les tests

Si seulement on évitait cette chose si simple...
Moins de logique, moins d'erreurs.

---


## Ah, mais si...

mais non !

Avoir des ifs dans les tests en complique la lecture et la compréhension.

Lorsque l'on introduit de la logique dans les tests, on augmente les chances qu'ils ne vérifient pas ce que l'on pense vérifier.

**Il n'y a pas de tests pour les tests, gardons les faciles à comprendre.**

---

## Un if à la place d'une assertion

Il arrive de croiser des `if` qui permettent de déclencher l'échec du test. On peut vouloir faire cela pour éviter une assertion moins précise, plus couteuse, ou simplement, car on veut s'assurer de plusieurs choses dans un test.

```php
/**
 * @test
 */
public function liste_les_burritos(): void
{
    $menu = new Menu();

    $listeDesBurritos = $menu->listerLesBurritos();
    
    if(!is_string($listeDesBurritos)) {
        $this->fail('La liste des burritos doit être une chaine de caractères');
    }
    else {
        $listeDesBurritosAttendue = "...";

        $this->assertEquals($listeDesBurritosAttendue, $listeDesBurritos);
    }
}
```

---

## Un if à la place d'une assertion

Il est préférable d'utiliser une "**guard assertion**" à la place : une assertion qui fera échouer le test si elle n'est pas valide.

```php
/**
 * @test
 */
public function liste_les_burritos(): void
{
    $menu = new Menu();

    $listeDesBurritos = $menu->listerLesBurritos();
    
    $this->assertIsString($listeDesBurritos);
    $this->assertEquals($listeDesBurritosAttendue, $listeDesBurritos);
}
```

<span class="small">(psst, à mon avis, ici, seule la dernière assertion est vraiment utile 😉)</span>


---

## Un if pour généraliser le test

Il est possible de généraliser un test en le rendant paramétrable.

On peut être tenté d'utiliser un `if` pour gérer les différents résultats possibles.
```php
/**
 * @test
 * @dataprovider exemple_de_burritos
 */
public function un_burrito_est_vege_sil_ne_contient_que_des_ingredients_vege($ingredients, $estVege)
{
    $burrito = new Burrito($ingredients);

    if($estVege) {
        $this->assertTrue($burrito->estVegetarien());
    }
    else {
        $this->assertFalse($burrito->estVegetarien());
    }
}

```

Mais on peut faire mieux...

---


## Un if pour généraliser le test

Et pour cela, on peut utiliser une assertion plus générale

```php
/**
 * @test
 * @dataprovider exemple_de_burritos
 */
public function un_burrito_est_vege_sil_ne_contient_que_des_ingredients_vege($ingredients, $estVege)
{
    $burrito = new Burrito($ingredients);

    $this->assertEquals($estVege, $burrito->estVegetarien());
}

```

Tchao le `if` et bienvenue la lisibilité.

---

## Un if en miroir du code

On trouve parfois des tests avec des `if` très étranges.

```php
/**
 * @test
 */
public function liste_les_categories_du_menu(): void {
    $menu = new Menu();

    $catégories = $menu->listeCategories();

    if (is_string($catégories)) {
        $this->assertEquals('Burritos', $catégories);
    } else {
        $this->assertEquals(['Burritos', 'Boissons', 'Desserts'], $catégories);
    }
}
```

---

## Un if en miroir du code

Ils sont peut-être le reflet d'un autre if présent dans l'implémentation.

```php
public function listeCategories() {
    if(Features::$afficheNouveauMenu) {
        return ['Burritos', 'Boissons', 'Desserts'];
    }

    return 'Burritos';
}
```

Ici, par exemple, on est en train de changer d'un menu avec une seule catégorie à un menu avec plusieurs catégories.

---

## Un if en miroir du code

Dans ce cas, il est préférable de mettre en place plusieurs tests, un pour chaque cas.

```php
/**
 * @test
 */
public function liste_les_categories_du_nouveau_menu(): void
{
    Features::$afficheNouveauMenu = true;
      
    $menu = new Menu();

    $catégories = $menu->listeCatégories();

    $this->assertEquals(['Burritos', 'Boissons', 'Desserts'], $catégories);
}
/**
 * @test
 */
public function liste_les_categories_du_menu_actuel(): void
{
    Features::$afficheNouveauMenu = false;
    
    $menu = new Menu();

    $catégories = $menu->listeCatégories();

    $this->assertEquals('Burritos', $catégories);
}
```


Reprendre la main pour contrôler le `if` peut nécessiter de refactorer le code pour le rendre davantage testable.

---

## Recap

Un `if` dans un test rend difficile la compréhension et augmente le risque d'erreur.

À la place, il est préférable :
- d'utiliser une assertion
- d'utiliser une autre assertion
- ou de faire plusieurs tests.

---

## Tu veux améliorer tes tests ?
<!--
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
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
