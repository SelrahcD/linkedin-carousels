<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Méthodes privées dans les tests
_header: ''
_footer: <img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf
footer: Charles Desneuf
-->


# Utiliser des méthodes privées dans les tests

Le code de test est tout aussi important que le code de production. Pour rendre vos tests plus lisibles et maintenables, utilisez des méthodes privées.

---

## Pourquoi utiliser des méthodes privées dans les tests ?

- **Réduire la duplication** de code entre les tests
- **Masquer les détails non pertinents** pour se concentrer sur l'intention du test
- **Centraliser les modifications** pour faciliter la maintenance
- **Réutiliser la logique** entre différents tests

---

## Trop d'infos ! 

```php
/**
 * @test
 */
public function peut_être_combinée_avec_une_autre_commande_pour_le_même_client(): void
{
    $burrito = new Burrito(['oeuf', 'riz', 'haricots rouges', 'oignons']);
    $premièreCommande = new Commande(
        new Client(17, 'Marc'),
        [$burrito]
    );
    
    $boisson = new Boisson('Limonade bio');
    $deuxièmeCommande = new Commande(
        new Client(17, 'Marc'),
        [$boisson]
    );
    
    $commandeCombinée = $premièreCommande->combinerAvec($deuxièmeCommande);
    
    $this->assertEquals(
        [$burrito, $boisson],
        $commandeCombinée->produits()
    );
}
```

Ce test contient des informations non nécessaires pour la compréhension du comportement qui nous intéresse. Voyons comment réduire ce bruit avec des méthodes privées.


---

## Ajout des méthodes privées

```php
private function unBurrito(): Burrito
{
    return new Burrito(['oeuf', 'riz', 'haricots rouges', 'oignons']);
}

private function uneBoisson(): Boisson
{
    return new Boisson('Limonade bio');
}

private function unClient(): Client
{
    return new Client(17, 'Marc');
}
```

---
## Et utilisons les dans le test

Cela permet de masquer les détails inutiles et facilite la compréhension du comportement.

```php
/**
 * @test
 */
public function peut_être_combinée_avec_une_autre_commande_pour_le_même_client(): void
{
    $client = $this->unClient();
    $burrito = $this->unBurrito();
    $premièreCommande = new Commande(
        $client,
        [$burrito]
    );
    
    $boisson = $this->uneBoisson();
    $deuxièmeCommande = new Commande(
        $client,
        [$boisson]
    );
    
    $commandeCombinée = $premièreCommande->combinerAvec($deuxièmeCommande);
    
    $this->assertEquals(
        [$burrito, $boisson],
        $commandeCombinée->produits()
    );
}
```

---

## Avantages pour la maintenance

Quand un constructeur change, au lieu de modifier tous les tests, vous ne modifiez que la méthode privée :

```php
private function unClient(): Client
{
    // Si un jour le constructeur de Client ajoute un paramètre
    return new Client(17, 'Marc', false);
}
```

---

## Méthodes privées dans la partie Assert

Les méthodes privées peuvent également être utilisées dans la partie Assert pour regrouper des vérifications liées logiquement.

```php
/**
 * @test
 */
public function est_marquée_comme_en_cours_de_traitement_par_un_cuisinier(): void
{
    $commande = new Commande(new Client(17, 'Marc'), []);

    $commande->marquerCommeEnCoursDeTraitement('Jeanne');

    $this->assertTrue($commande->estEnCoursDeTraitement());
    $this->assertEquals('Jeanne', $commande->traitéePar());
}
```

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

## Avec une assertion personnalisée

```php
/**
 * @test
 */
public function est_marquée_comme_en_cours_de_traitement_par_un_cuisinier(): void
{
    $commande = new Commande(new Client(17, 'Marc'), []);

    $commande->marquerCommeEnCoursDeTraitement('Jeanne');

    $this->assertEstEnCoursDeTraitementPar('Jeanne', $commande);
}

private function assertEstEnCoursDeTraitementPar(string $str, Commande $commande): void
{
    $this->assertTrue($commande->estEnCoursDeTraitement());
    $this->assertEquals($str, $commande->traitéePar());
}
```

L'ajout d'une méthode privée permet de retrouver le langage métier dans les assertions. Cela permet également de regrouper une logique qui pourrait être dupliquée dans plusieurs tests.

---

## Bonnes pratiques

- Nommez les méthodes clairement pour refléter leur intention
- Utilisez du vocabulaire métier dans les noms des méthodes
- Groupez les assertions logiquement liées
- Gardez les méthodes courtes et focalisées
- Assurez-vous que les méthodes privées n'ajoutent pas de comportement au test

---

## Conclusion

L'utilisation de méthodes privées dans les tests est une technique puissante pour améliorer la lisibilité et la maintenabilité. Elle permet de masquer les détails non pertinents, de centraliser les modifications, et d'introduire du vocabulaire métier dans vos tests.

N'hésitez pas à appliquer ces principes dans vos tests pour les rendre plus clairs, plus maintenables et plus expressifs. Rappelez-vous que le code de test est tout aussi important que le code de production !