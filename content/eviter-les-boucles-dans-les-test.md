<!--
theme: your-theme
size: linkedin-portrait
paginate: true
header: Éviter les boucles dans les tests
_header: ''
_footer: <img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf
footer: Charles Desneuf
-->

# Éviter les boucles dans les tests

Éviter les boucles dans les tests permet plus de clarté et réduit les risques d'erreurs.

---

## Les boucles pour générer des données

On trouve parfois des boucles dans les tests pour générer de la donnée. 
Malheureusement, cela réduit la lisibilité, rend le test plus difficile à comprendre et augmente le risque d'erreurs.
```php
public function liste_les_burritos(): void {
    $menu = new Menu();

    for ($i = 1; $i <= 6; $i++) {
        $menu->ajouterUnBurrito(
            new Burrito('Burrito ' . $i, [])
        );
    }
    // ...
}
```

---

## Solution : Réduire la quantité de données nécessaire

Deux ou trois éléments suffisent généralement pour tester un comportement impliquant une collection.

```php
public function liste_les_burritos(): void {
    $menu = new Menu();

    $menu->ajouterUnBurrito(new Burrito('Burrito 1', []));
    $menu->ajouterUnBurrito(new Burrito('Burrito 2', []));
    $menu->ajouterUnBurrito(new Burrito('Burrito 3', []));
    
    $listeDesBurritos = $menu->listerLesBurritos();
    // ...
}
```

---
## Les boucles pour tester plusieurs cas

Évitez d'utiliser des boucles foreach pour tester plusieurs cas dans un même test.


```php
$burritos = [
    [new Burrito('B1', ['salade']), true],
    [new Burrito('B2', ['boeuf']), false],
];

foreach ($burritos as [$burrito, $estVégétarien]) {
    $this->assertEquals($estVégétarien, $burrito->estVégétarien());
}
```

La lisibilité est pas top.
Si le test échoue, on a du mal à savoir quel cas pose problème. D'ailleurs, est-ce qu'il y en a un ou plusieurs ?

---

## Solution 1 : faire des tests séparés

Préférez créer un test distinct pour chaque cas.

```php
public function un_burrito_végétarien_si_ne_contient_que_des_ingrédients_végétariens(): void {
    $burrito = new Burrito('B1', ['salade']);
    $this->assertTrue($burrito->estVégétarien());
}

public function un_burrito_non_végétarien_sil_contient_un_ingrédient_non_végétarien(): void {
    $burrito = new Burrito('B2', ['boeuf']);
    $this->assertFalse($burrito->estVégétarien());
}
```

On a une bien meilleure lisibilité et les noms des tests sont super parlants.

---

## Solution 2 : faire des tests paramétrés

Utiliser des tests paramétrés, guidés par la donnée.

```php
#[TestWith([['salade'], true])]
#[TestWith([['boeuf'], false])]
public function un_burrito_végétarien_sil_ne_contient_que_des_ingrédients_végétariens(
    array $ingrédients,
    bool $estVégétarien
): void {
    $burrito = new Burrito('B1', $ingrédients);
    $this->assertEquals($estVégétarien, $burrito->estVégétarien());
}
```

La boucle est maintenant gérée par le framework de test.
Et en cas d'erreur on sait beaucoup plus facilement quel cas échoue.

---

## Les avantages de laisser les boucles en dehors des tests

- Tests plus lisibles
- Messages d'erreur plus clairs
- Maintenance simplifiée
- Meilleure compréhension des cas testés
- Moins de chance de se planter
- Meilleure documentation

Bref, c'est mieux de ne pas mettre de boucle.

---

<!--
_footer: <img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf
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