<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: L'Example-Based Testing
_header: ''
_footer: <img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf
footer: Charles Desneuf
-->

# L'Example-Based Testing
Comment faire en sorte que vos tests concrets illustrent des règles métier

---

## Qu'est-ce que l'Example-Based Testing?

L'Example-Based Testing est une approche où vous validez le comportement d'un système en fournissant des exemples concrets d'entrées et de sorties attendues.

C'est l'approche la plus courante pour les tests automatisés et la plus intuitive pour les développeurs.

Il y a de grandes chances que ce soit ce que tu fasses.

---

## Le corps du test est un exemple concret

```php
/**
* @test
*/
public function un_burrito_sans_viande_et_sans_poisson_est_végétarien(): void {
  $burrito = new Burrito(['salade', 'fromage', 'avocat', 'oeuf']);

  $this->assertTrue($burrito->estVégétarien());
}
```

Le corps du test est un exemple spécifique qui illustre notre règle métier.

Ici, on utilise le Burrito qui contient de la salade, du fromage, de l'avocat et un œuf comme exemple de burrito végétarien.

On pourrait trouver plein d'autres exemples.

---

## Le nom du test exprime une règle métier

```php
/**
* @test
*/
public function un_burrito_sans_viande_et_sans_poisson_est_végétarien(): void {
  // ...
}
```

Le nom du test exprime une règle métier générale: "Un burrito sans viande et sans poisson est végétarien"

Ce n'est pas juste "Ce burrito avec de la salade, du fromage, de l'avocat et un œuf est végétarien"

---

## La différence est cruciale

**Règle métier (abstraite):**
- "Un burrito avec de la viande ou du poisson n'est pas végétarien"

**Exemples (concrets):**
- Un burrito avec du bœuf haché n'est pas végétarien
- Un burrito avec du thon n'est pas végétarien

La règle est générale, les exemples sont spécifiques.

---

## C'est important pour le nommage des tests

Dans la grande majorité des cas, on ne veut pas que les noms de tests fassent mention d'un exemple particulier, on veut qu'ils expriment une règle plus générale.

On ne veut pas un test qui s'appelle `a donne b`, mais plutôt `lettreSuivante retourne la prochaine lettre de l'alphabet`.

Mais c'est pas tout !

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

## C'est mieux pour la documentation

Si tu vois tes tests comme de la documentation, as-tu envie de lire un test pour chaque burrito végétarien ou non du monde et essayer de deviner pourquoi "thon, steak, riz, moules" n'est pas végétarien ?*

Probablement pas, tu veux connaitre la règle métier : si y'a de la viande ou du poisson, c'est pas végé. Bon sang mais c'est bien sûr 🤦!

<span class="small">*En plus d'être certainement dégueulasse.</span>

---

## Plusieurs exemples pour une règle

Ça permet aussi de diminuer le nombre de tests à maintenir. On peut utiliser plusieurs exemples pour illustrer une même règle grâce à la paramétrisation.

```php
final class BurritoTest extends TestCase
{
    #[TestWith(['boeuf haché', 'salade', 'fromage', 'avocat'])]
    #[TestWith(['thon', 'salade', 'fromage', 'avocat'])]
    public function un_burrito_avec_viande_ou_poisson_est_non_végétarien(array $ingrédients)
    {
        $burrito = new Burrito($ingrédients);
        $this->assertFalse($expected, $burrito->estVégétarien());
    }
}
```
---

<!-- _class: small -->

## À retenir sur l'Example-Based Testing

- Vos méthodes de test contiennent des exemples concrets
- Vos noms de test doivent exprimer des règles métier générales
- Cette différence permet de mieux structurer vos tests
- La paramétrisation est votre alliée pour tester une règle avec plusieurs exemples
- Des tests bien nommés et bien organisés servent de documentation vivante

Gardez en tête que chaque exemple dans votre code est là pour illustrer une règle métier plus large!