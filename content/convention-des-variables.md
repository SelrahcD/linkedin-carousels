<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Convention des variables
_header: ''
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
footer: <a href="https://www.linkedin.com/in/charles-desneuf/">Charles Desneuf</a>
-->

# Convention des variables
En utilisant des conventions pour nommer les variables, on peut gagner en compréhension pour nos tests.

---

## SUT : Système sous test

Pour facilement identifier le système qui est en train d'être testé, une convention commune est de nommer la variable ou la propriété qui le porte **sut** pour _system under test_.

On peut facilement repérer la partie _Act_ du test, c'est l'endroit où l'on agit sur cette variable.


---

## Expected : Ce que l'on attend

On peut également utiliser le prefix **expected** pour les variables contenant le résultat attendu.

Comme c'est un prefix, on repère très rapidement la variable.

---

## Actual : Ce que l'on obtient

À l'inverse, on peut stocker le résultat produit par le système sous test dans une variable préfixée **actual**.

Là encore, le prefix nous permet de facilement retrouver la variable en scannant le test.

---

## Ne pas faire d'erreur

Avoir une convention comme **expected** et **actual** permet d'éviter des erreurs.

Les frameworks de tests prennent généralement les paramètres pour le résultat attendu et le résultat réel dans le même ordre.
Ça nous permet de vite nous rendre compte si l'on a inversé les deux.

Avec un peu de chance, on a même une autocomplétion au taquet.

<span class="small">Et on peut faire des automatisations marrantes mais ça sera pour un autre jour.</span>

---

## Et en français ?

Si vous codez en français, vous pouvez opter pour :
- **sst**, pour le système sous test,
- le suffixe **réel** pour le résultat du système sous test
- et le suffixe **attendu** pour le résultat attendu.

Mais pour le coup, les suffixes aident moins que les préfixes pour facilement repérer les variables 😢

---

## À définir en équipe

Ces conventions sont bien sûr à définir en équipe.

De mon côté, j’utilise toujours les préfixes **actual** et **expected**.
En revanche, je préfère utiliser un nom plus parlant et faisant partie du vocabulaire métier, plutôt que sut, pour désigner le système en train d’être testé.

---

## Tu veux améliorer tes tests ?
<!--
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
-->

Si tu rencontres des problèmes de maintenance avec tes tests, s'ils ne sont pas assez lisibles, s'ils cassent pour de mauvaises raisons, je peux t'aider.

<div class="offer">
    <div class="offer-content">
    Accède à ma <a href="https://formation.charlesdesneuf.com/ameliorez-vos-tests-automatises?utm_medium=social&utm_source=linkedin&utm_campaign=carousel-8-caracteristiques-importantes-des-tests">formation vidéo</a> ou jette un coup d'oeil à mon <a href="https://formation.charlesdesneuf.com/guide-gratuit-5-idees-pour-ameliorer-la-lisibilite-de-vos-tests-automatises?utm_medium=social&utm_source=linkedin&utm_campaign=carousel-8-caracteristiques-importantes-des-tests">guide gratuit pour améliorer la lisibilité des tests</a>.
    </div>
    <div class="offer-img">
    <a href="https://formation.charlesdesneuf.com/guide-gratuit-5-idees-pour-ameliorer-la-lisibilite-de-vos-tests-automatises?utm_medium=social&utm_source=linkedin&utm_campaign=carousel-8-caracteristiques-importantes-des-tests">
    <img src="https://formation.charlesdesneuf.com/content-assets/public/eyJhbGciOiJIUzI1NiJ9.eyJvYmplY3Rfa2V5IjoiZHdvazQ1NXZvbDQwdm9rZHNmbXV0NnVxMHF1bCIsImRvbWFpbiI6ImZvcm1hdGlvbi5jaGFybGVzZGVzbmV1Zi5jb20ifQ.NS61AHjRUfdqsvHH6gqCbDNSSyCeI3U3AUlI-7U-PzE" class="free-guide-picture" /></a>
    </div>
</div>
