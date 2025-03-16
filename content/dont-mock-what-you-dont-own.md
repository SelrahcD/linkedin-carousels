<!--
theme: your-theme
size: linkedin-portrait
paginate: true
header: Don't mock what you don't own
_header: ''
_footer: <img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf
footer: Charles Desneuf
-->

# Don't mock what you don't own
Créer une doublure pour du code qui ne nous appartient pas peut nous donner un faux sentiment de sécurité.

---

## Un test qui prend trop de temps

Imaginons un test qui vérifie qu'un cuisinier peut faire des poivrons fondants :

```php
public function prépare_des_poivrons_fondants_avec_un_four(): void
{
    $poivron = new Poivron();
    $kulinarisk = new \AKEI\Kulinarisk();
    $cuisinier = new Cuisiner($kulinarisk);
    
    $platPréparé = $cuisinier->prépareUnPoivronFondant($poivron);
    
    $this->assertEquals(new PoivronFondant(), $platPréparé);
}
```

Faire des poivrons fondants, c'est long.

Ce test prend 25 minutes ! Le four Kulinarisk attend vraiment ce temps.


---

## Regardons l'implémentation

Le Kulinarisk (fourni par AKEI) fonctionne comme ça :

```php
public function laga($maträtt, int $varaktighet)
{
    $varaktighetISekunder = $varaktighet * 60;
    
    sleep($varaktighetISekunder);
    
    return $this->värme($maträtt, $varaktighetISekunder);
}
```

Il fait réellement dormir le processus pendant la durée de cuisson !

---

## On veut aller plus vite !

La solution rapide ? Mocker* le Kulinarisk :

```php
public function prépare_des_poivrons_fondants_avec_un_four(): void
{
    $poivron = new Poivron();
    $kulinarisk = $this->createMock(AKEI\Kulinarisk::class);
    $kulinarisk->method('laga')
        ->with($poivron, 25)
        ->willReturn(new PoivronFondant());
    $cuisinier = new Cuisiner($kulinarisk);
    
    $platPréparé = $cuisinier->prépareUnPoivronFondant($poivron);
    
    $this->assertEquals(new PoivronFondant(), $platPréparé);
}
```

Le test est beaucoup plus rapide... mais vous avez remarqué quelque chose d'étrange ?
<span class="small">* Oui, c'est un abus de langage.</span>

---

<!-- _class: small -->

## Le langage nous parle

Notre code est en français :
- Cuisinier
- prépareUnPoivronFondant
- PoivronFondant

Mais le Kulinarisk utilise des méthodes en suédois :
- laga
- maträtt
- varaktighet

C'est un signe que nous utilisons directement une librairie externe sans l'adapter à notre domaine.

---

## Premier problème : la mise à jour

AKEI sort une nouvelle version : ils renomment `laga` en `bake`.

Notre test avec mock échoue car il cherche à configurer une méthode `laga` qui n'existe plus.

On modifie notre mock sans trop réfléchir :

```php
$kulinarisk->method('bake')->with($poivron, 25)
->willReturn(new PoivronFondant());
```

Et hop, le test repasse. Tout va bien ?

---

## Deuxième problème : la prod est cassée

En prod, plus rien ne fonctionne !

La nouvelle version de `bake` ne fonctionne pas comme `laga` :

```php
public function bake($dish, int $duration)
{
    $durationInSeconds = $duration * 60;
    sleep($durationInSeconds);
    return $dish; // Retourne le plat sans le transformer !
}
```
AKEI a introduit un bug dans la nouvelle version du Kulinarisk 🤦

Notre mock nous a caché ce changement de comportement !

---

## Comment faire mieux ?

Laissons nous guider par le langage. On l'a vu, on a du vocabulaire étranger à notre domaine dans notre code.

Corrigeons cela avec une interface `Four` :

```php
interface Four
{
    public function cuire($plat, $duréeEnMinute);
}
```

Cette interface définit le langage de notre domaine.

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

## Une implémentation

Une interface c'est bien, mais il nous faut quand même un véritable four.

Notre four de la cuisine est un Kulinarisk

```php
class FourDeLaCuisine implements Four
{
    public function __construct(
       private readonly AKEI\Kulinarisk $kulinarisk
    ) 
    {}
    
    public function cuire($plat, $duréeEnMinute) 
    {
        return $this->kulinarisk->bake($plat, $duréeEnMinute);
    }
}
```

Le four de la cuisine délègue le travail au Kulinarisk et fait la traduction.

---

## Des tests qui parlent le langage du domaine

On peut maintenant utiliser l'interface `Four` dans notre test :

```php
public function prépare_des_poivrons_fondants_avec_un_four(): void
{
    $poivron = new Poivron();
    $four = $this->createMock(Four::class);

    $four->method('cuire')
        ->with($poivron, 25)
        ->willReturn(new PoivronFondant());
        
    $cuisinier = new Cuisiner($four);
    $platPréparé = $cuisinier->prépareUnPoivronFondant($poivron);
    
    $this->assertEquals(new PoivronFondant(), $platPréparé);
}
```

Le test ne sait même pas qu'un Kulinarisk existe et est exprimé dans le langage du domaine !

---

## Ok, mais si le Kulinarisk tombe en panne ?

Il n'y a pas de mystère, il faut un test du `FourDeLaCuisine` avec un vrai `Kulinarisk`.
Pour gagner du temps, on peut tester sur une cuisson plus rapide que les poivrons, comme du pain.

```php
public function intégration_le_four_fonctionne(): void
{
    $four = new FourDeLaCuisine(new AKEI\Kulinarisk());
    $this->assertEquals(
        new PainGrillé(),
        $four->cuire(new Pain(), 2)
    );
}
```

<span class="small">Un peu d'alerting aide aussi un peu ici 😉</span>

---

## La révélation

Lors de la mise à jour du Kulinarisk :

- Le test avec la doublure passe (il ne vérifie que le nom de la méthode)
- Le test d'intégration échoue ! Il détecte que le four ne transforme plus le pain en pain grillé.

Sans ce test d'intégration, nous n'aurions découvert le problème qu'en production.

---

## Les leçons à retenir

1. Ne créez pas de doublure des librairies externes
2. Laissez vous guider par votre langage métier
3. Testez l'intégration avec de vrais composants
4. Ne doublez uniquement que ce que vous possédez

Ainsi vous êtes mieux protégés des changements externes.
