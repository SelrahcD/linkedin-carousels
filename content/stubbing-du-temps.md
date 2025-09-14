<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Stubbing du temps : Prendre le contrôle du système
_header: ''
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
footer: <a href="https://www.linkedin.com/in/charles-desneuf/">Charles Desneuf</a>
-->

# Stubbing du temps : Prendre le contrôle du système
Maîtriser le temps dans les tests permet d'éviter de les voir échouer aléatoirement en fonction de la date et de l'heure.

---

## Le problème avec le temps qui passe

Le temps est une dépendance incontrôlable. Il évolue, et ce changement peut faire échouer des tests ou réduire leur pertinence.

```php
final class PannaCottaTest extends TestCase {
    /**
     * @test
     */
    public function est_consommable_2_jours_après_fabrication(): void {
        $pannaCotta = unePannaCotta()
            ->fabriquéeLe(DateFabrication::le(3, 12, 2024))
            ->build();
        $this->assertTrue($pannaCotta->estConsommable());
    }
}
```

Si l'implémentation est correcte, ce test va se mettre à échouer à partir du 5 décembre 2024. Pas cool !

---

## Fausse bonne idée : les dates relatives

On pourrait vouloir utiliser des dates relatives pour régler ce problème

```php
final class PannaCottaTest extends TestCase {
    /**
     * @test
     */
    public function est_consommable_2_jours_après_fabrication(): void {
        $ilYa2jours = (new DateTimeImmutable('now'))->modify('-2 days');

        $pannaCotta = unePannaCotta()
            ->fabriquéeLe(DateFabrication::depuisDateTime($ilYa2Jours))
            ->build();
        $this->assertTrue($pannaCotta->estConsommable());
    }
}
```

---
## Fausse bonne idée : les dates relatives

Plusieurs problèmes :
- Cela rajoute de la complexité dans le test.
- Le test peut toujours échouer sous certaines conditions. Ici, si l'on exécute le test pile au moment d'un changement de date. La probabilité de rencontrer ce problème est faible pour un changement de jour, mais si on commence à s'intéresser à des intervals de temps plus petits, elle augmente.

---

## Solution 1 : Transformer le problème

On peut transformer le problème. Plutôt que de s'intéresser à ce qui doit se passer maintenant, on peut s'intéresser à ce qui doit se passer à une date particulière et injecter cette date.

```php
$pannaCotta = unePannaCotta()
    ->fabriquéeLe(DateFabrication::le(3, 12, 2024))
    ->build();

$this->assertTrue($pannaCotta->estConsommableLe(new DateTimeImmutable('04/12/2024')));
```
---
## Solution 1 : Transformer le problème

Après tout, ça a du sens de vouloir demander si une Panna Cotta sera encore consommable dans plusieurs jours.

Ce test est aussi plus explicite. Il n'y a plus besoin de connaitre la date du jour pour le comprendre.

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

## Sauf que...
Parfois, on ne veut pas permettre au code appelant de spécifier une date, parce qu'il pourrait fournir une date qui serait erronée.

Par exemple, on ne veut pas qu'il soit possible de tricher pour l'édition d'un ticket de caisse pour éviter les fraudes.

Et pour cela...

---

## Solution 2: Créer une horloge

Il est possible d'introduire le concept d'Horloge de manière explicite, et de créer une implémentation qui soit configurable pour les tests :

```php
interface Horloge {
    public function maintenant(): DateTimeImmutable;
}

final class HorlogeDeTest implements Horloge {

    public function __construct(
        private readonly DateTimeImmutable $maintenant
    ){}
    
    public function maintenant(): DateTimeImmutable {
      return $this->maintenant;
    }
 }
```

---

## Solution 2: Injecter l'horloge

On peut alors injecter l'horloge de test au système sous test pour pouvoir controller la date à laquelle il pense que l'action s'exécute.

```php
/**
 * @test
 */
public function editer_un_ticket(): void {
    $commande = $this->uneCommande();
    $horloge = new HorlogeDeTest(new DateTimeImmutable('03/08/2014 10:02'));
    $caisse = new Caisse($horloge);
    
    $ticketAttendu = <<<TICKET
                        Burrito Factory
                       03/08/2014 10:02
                     ─────────────────────
                             ... 
                    TICKET;
    
    $this->assertEquals($ticketAttendu, $caisse->editeTicketPour($commande));
}
```

---

## Récap

Les tests avec des dates sont pénibles et ont tendance à être flaky s'ils sont mal conçus.

2 solutions :

- Utiliser une horloge que l'on peut controller
- Changer le problème pour pouvoir fournir une date
