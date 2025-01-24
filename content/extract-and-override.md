<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Extract and Override : Reprendre le contrôle sur du code legacy
_header: ''
_footer: <img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf
footer: Charles Desneuf
-->

# Extract and Override : Reprendre le contrôle sur du code legacy
Une technique pour rendre testable du code qui ne l'était pas initialement, en extrayant les dépendances difficiles à contrôler.

---

## Le problème avec le code legacy

Souvent dans du code legacy, les dépendances sont créées directement dans le code :

```php
class PanierMoyen {
    public function pour(array $commandes) {
        $date = new DateTime(); // Dépendance créée dans le code
        // ...
    }
}
```

Ce code est difficile à tester car nous ne contrôlons pas la date.

---

## La solution : Extract and Override

Tout d'abord, on va extraire la création de la dépendance dans une méthode protected.

```php
class PanierMoyen {
    protected function date() {
        return new DateTime();
    }
    
    public function pour(array $commandes) {
        $date = $this->date();
        // ...
    }
}
```

<span class="small">En utilisant des refactoring automatiques, bien sûr 😉</span>

---

## Créer une classe pour le test

Créer une classe de test qui hérite de la classe originale :

```php
class PanierMoyenTestable extends PanierMoyen {
    public $date;

    protected function date() {
        return $this->date;
    }
}
```

On a maintenant un point d'entrée pour choisir la date via une propriété publique.

---

## Utiliser la class de test dans les tests

Dane le test, on remplace la classe d'origine par la classe testable et on peut choisir la date via la propriété publique. 

```diff
public function test_quelque_chose_a_propos_du_panier_moyen() {
+    $panierMoyen = new PanierMoyenTestable()
-    $panierMoyen = new PanierMoyen()
+    $panierMoyen->date = new DateTime('2025-02-17');

    // suite du test...
}
```

---

## Avantages de Extract and Override

- Ne nécessite pas de changer l'interface publique
- Permet de tester du code legacy sans le réécrire
- Pas besoin de toucher au constructeur pour injecter la dépendance que l'on veut contrôler.
- Facile à mettre en place

---

## Points d'attention

Même s'il y a plein d'avantage il y a quelques trucs à garder en tête:

- C'est une solution temporaire
- Préférer l'injection de dépendances sur le long terme
- Ne pas abuser des méthodes protected
- Garder en tête que le code devra évoluer

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