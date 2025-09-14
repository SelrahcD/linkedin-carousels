<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Gérer l'aléatoire dans les tests automatisés
_header: ''
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
footer: <a href="https://www.linkedin.com/in/charles-desneuf/">Charles Desneuf</a>
-->

# Code legacy + aléatoire : même pas peur

Découvrez comment rendre vos tests déterministes et fiables, même face à de l'aléatoire.

---

## Pourquoi est-ce un problème ?

- Les systèmes aléatoires compliquent la mise en place de tests fiables.
- Les tests doivent être déterministes : mêmes résultats pour un même contexte.
- L'objectif : éliminer les échecs liés à des facteurs imprévisibles.

---

## Bloquer le générateur d'aléatoire

### Principe
- Configurez le générateur pour produire toujours les mêmes résultats.
- Cela rend le système prévisible pendant les tests.

### Limites
- Non disponible dans tous les langages.
- Si l’ordre des appels change, les résultats ne correspondront plus aux attentes.

---

## Contrôler l'aléatoire

### Principe
- Remplacez le générateur par une abstraction que vous contrôlez.
- Injectez une dépendance manipulable dans vos tests.

### Avantages
- Compatible avec tous les langages.
- Permet des refactorisations sans casser les tests.

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

## Masquer l'aléatoire

### Principe
- Ignorez les parties aléatoires non pertinentes pour vos assertions.
- Transformez les sorties pour en retirer l’aléatoire.

### Exemple d’utilisation
- Supprimez ou remplacez des identifiants uniques comme les UUID.
- Vérifiez seulement ce qui est essentiel à votre test.

---

## Trois techniques, trois cas d'usage

- **Bloquer le générateur** : Solution rapide mais limitée.
- **Contrôler l'aléatoire** : Flexible et robuste.
- **Masquer l'aléatoire** : Parfait pour le code legacy.