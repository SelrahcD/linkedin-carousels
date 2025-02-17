<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Les différents types de doublures de test
_header: ''
_footer: <img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf
footer: Charles Desneuf
-->

# Les différents types de doublures de test

Mais si tu sais, les mocks là...

---

## Différents types de doublures

Les doublures servent à remplacer des dépendances réelles dans nos tests pour permetter de mieux les controller.

Dans _xUnit Test Patterns: Refactoring Test Code_, Gerard Meszaros en répertorie 5 types.

Les mocks ne sont en fait qu'un type particulier. On utilise ce mot à la place de doublure (_test double_) par abus de langage.


---

## D'ailleurs, pourquoi doublure ?

Au cinéma, plutôt que de laisser les acteurs faire des choses qu'ils ne savent pas faire, ou trop dangeureuses pour eux, on fait appels à d'autres acteurs spécialisés qui leur ressemblent.

On parle de doublure. Pour les tests, c'est la même idée.

<span class="small">(Sauf Tom Cruise, bien sûr.)</span>


---

## 5 types de doublures

Voici la liste des 5 types de doublures :

- Dummy
- Stub
- Spy
- Mock
- Fake

Regardons chacune d'elles ➡️

---

## Le Dummy

- Le plus simple des types de doublure
- Utilisé uniquement pour satisfaire des dépendances qui ne servent pas dans le test
- Ne contient aucun comportement, sert juste pour l'instanciation

```php
// Dans le test, le serveur a besoin d'une caisse enregistreuse pour être instancié,
// mais n'en a pas besoin pour le comportement testé.
new Serveur(new DummyCaisseEnregistreuse());

class DummyCaisseEnregistreuse implements CaisseEnregistreuse {
    public function estConnectéeALaBanque(): bool { }

    public function acceptePaiement($commandeId, $montant, $carte): void {
        throw new Exception('Ne devrait pas être appelé');
    }
}
```

---

## Le Stub

- Fournit des réponses préprogrammées aux appels
- Permet de contrôler les entrées indirectes du système sous test
- Ne vérifie pas avoir été appelé

```php
class CaisseEnregistreuseStub implements CaisseEnregistreuse {
    public function __construct(private bool $estConnectée) {}

    public function estConnecteeALaBanque(): bool {
        return $this->estConnectée;
    }
}

// Dans le test
$caisse = new CaisseEnregistreuseStub(true);
$serveur = new Serveur($caisse);
```

---

## Le Spy

- Enregistre les appels qu'il reçoit
- Permet de vérifier après coup ce qui a été fait
- Le test doit déclencher explicitement les vérifications

```php
class CaisseEnregistreuseSpy implements CaisseEnregistreuse {
    public int $paiementsEffectués = 0;

    public function acceptePaiement($commandeId, $montant, $carte): void {
        $this->paiementsEffectués++;
    }
}

// Dans le test
$caisse = new CaisseEnregistreuseSpy(true);
$serveur = new Serveur($caisse);

//...

Assert::assertEquals(1, $caisse->paiementsEffectués);


```

---

## Le Mock

- Contient ses propres vérifications
- Échoue immédiatement si utilisé différemment de ce qui était attendu
- Le test n'a plus besoin de faire les vérifications

```php
class CaisseEnregistreuseMock implements CaisseEnregistreuse {
    public function acceptePaiement($commandeId, $montant, $carte): void {
        Assert::assertEquals(15.90, $montant);
        Assert::assertEquals('CB123', $carte->numero());
    }
}
```

---

## Le Fake

- Une véritable implémentation alternative
- Plus simple que l'implémentation de production
- Utilisé quand l'implémentation réelle serait trop difficile à utiliser dans un test

```php
class FakeCaisseEnregistreuse implements CaisseEnregistreuse {
    private array $transactions = [];

    public function acceptePaiement($commandeId, $montant, $carte): void {
        $this->transactions[] = [
            'commande' => $commandeId,
            'montant' => $montant
        ];
    }
    
    public function listeLesPaiementsEncaisses(): array {
        return $this->transactions;
    }
}
```

---

## Tout n'est pas mock

<div class="container middle">
    <img src="./say-mock-again.png" alt="Pulp Fiction Meme: Say Mock again" width="60%"/>
</div>

<span class="small">C'est bien de connaitre la différence. Acceptez quand même que vos collègues disent mocks de temps en temps pour ne pas être le relou de service.</span>

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