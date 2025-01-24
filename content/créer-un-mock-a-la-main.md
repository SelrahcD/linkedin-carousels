<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Créer un mock à la main
_header: ''
_footer: <img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf
footer: Charles Desneuf
-->

# Créer un mock à la main
Créer un mock sans framework ?
C'est possible !

---

## Qu'est-ce qu'un mock ?

Un mock est une doublure qui :
- Vérifie automatiquement les appels qui lui sont faits
- Lance une erreur si les appels ne correspondent pas à ce qui était attendu
- Effectue les vérifications dès l'appel de méthode

---

## Exemple avec un serveur et une cuisine

Nous voulons vérifier qu'un serveur transmet bien la commande à la cuisine :

```php
$serveur->prendreLaCommande(17, ['Burrito']);
```

doit déclencher l'appel suivant auprès de la cuisine :

```php
$cuisine->prepare("Table #17 : 1 x Burrito");
```

---

## Structure d'un mock

Un mock doit implémenter la même interface que l'objet qu'il remplace :

```php
final class CuisineMock implements Cuisine {
}
```


---

## Paramétrable ???
On peut vouloir rendre notre mock paramétrable pour qu'il puisse servir dans plusieurs cas.
Une solution est de spécifier les attentes via le constructeur:

```php
final class CuisineMock implements Cuisine {
    public function __construct(
        private readonly string $contenuAttendu,
    ) {
    }
}
```

On peut aussi utiliser des méthodes pour la configuration.

---

## Vérifier les appels

Pour vérifier les appels on peut utiliser directement les assertions du framework de test dans les implémentations des méthodes :

```php
final class CuisineMock implements Cuisine {
    public function prepare(string $contenu): void {
        Assert::assertEquals(
            $this->contenuAttendu, 
            $contenu
        );
    }
}
```

---

## Utilisation du mock

Le mock vérifie automatiquement que la commande est bien transmise :

```php
/**
* @test  
*/
public function transmet_une_commande_a_la_cuisine(): void {
  $cuisine = new CuisineMock("Table #17 : 1 x Burrito");
  $serveur = new Serveur($cuisine);

  $serveur->prendreLaCommande(17, ['Burrito']);
}
```

Le test échoue si le contenu ne correspond pas.

---

## Vérifier le nombre d'appels

Pour vérifier le nombre d'appels, on peut les compter et faire une vérification au moment où le mock est détruit.

```php
final class CuisineMock implements Cuisine {
    private int $nombreDappels = 0;

    public function __destruct() {
        Assert::assertEquals(
            1,
            $this->nombreDappels,
            "La méthode prepare doit être appelée une seule fois"
        );
    }
    
    public function prepare(string $contenu): void {
        $this->nombreDappels++;
        // Vérifications...
    }
}
```

<span class="small">On pourrait bien sûr rendre le nombre d'appels attendus paramétrable également.</span>

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