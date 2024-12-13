<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Utilisation des tags dans les runners de tests
_header: ''
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
footer: <a href="https://www.linkedin.com/in/charles-desneuf/">Charles Desneuf</a>
-->

# Les tags dans les tests
Les tags sont un outil puissant pour classifier et filtrer les tests selon leur type, dépendances, ou autres critères spécifiques. Voici des cas pratiques pour tirer parti de cette fonctionnalité.

---

## Classer les types de tests
Utilisez les tags pour indiquer le type de test, par exemple :
- `@unit` pour les tests unitaires
- `@integration` pour les tests d’intégration
- `@end2end` pour les tests de bout-en-bout

Cela permet de lancer uniquement les tests nécessaires.

---

## Huh ?

Mais on a déjà une structure de fichier pour ça !

<br />

Oui, mais vous avez aussi des débats pour savoir comment classifier les tests.

<br />

Peut-être qu'il est plus intéressant de s'intéresser aux caractéristiques d'un test plutôt qu'à sa classification, non ?

<br />

Ou plutôt de savoir lesquels sont trop lents pour éviter de les lancer tout le temps.

Et pour ça...


---

## Indiquer les dépendances
Les tags peuvent aussi préciser les dépendances des tests, comme :
- `@database` pour les tests qui accèdent à une base de données
- `@network` pour ceux qui nécessitent des appels réseau
- `@external-call` pour ceux qui vont appeler un service externe
- `@filesystem` pour ceux qui lisent et écrivent sur le système de fichier

Cela aide à exclure les tests longs ou dépendants d’un environnement spécifique.

---

<div class="container">
<img src="./camping.svg" alt="Des gens en camping" width="75%"/>
</div>

Maintenant quand tu es en camping tu peux exclure tous les tests qui ont besoin d'un accès à internet.

---

## Faciliter la documentation
Les tags permettent de générer des documentations spécifiques par fonctionnalité ou domaine, par exemple :
- `@feat-payment` pour les fonctionnalités de paiement
- `@tool-bo` pour le backoffice
- `@security` pour tout ce qui est lié à la sécurité
- `@market-es` pour les règles spécifiques au marché espagnol

Cela simplifie l’accès aux informations pour chaque sujet d’intérêt.

---

Tu peux maintenant générer une documentation à partir des tests à direction d'un certain type de lecteur.
<br />

Cool, hein ?

---

## Lien avec les tickets de bug ou d’utilisateur
Associez les tests aux tickets pour garder une trace des évolutions :
- `@bug-3457` pour les tests de non-régression
- `@US-89` pour les user stories

Les équipes peuvent facilement retrouver des tests spécifiques liés à un ticket.

---

## Tips: Choisir une nomenclature adaptée
Une nomenclature claire des tags facilite leur utilisation :
- Préfixez les tags, comme `feat-` ou `domain-`, pour les identifier rapidement
- Faites un nettoyage régulier des tags obsolètes pour garder la base propre

---

## Des tags pour plus de flexibilité !
En utilisant les tags, on gagne en flexibilité dans le choix et l'exécution des tests. C'est un atout pour optimiser les processus et maintenir une suite de tests organisée.

<br />

J'ai écrit un article sur le sujet si tu veux aller plus loin, c'est <a href="https://blog.charlesdesneuf.com/articles/tags-fonctionnalite-oubliee-des-lanceurs-de-tests/?utm_medium=social&utm_source=linkedin&utm_campaign=carousel-utilisation-tags-tests">par ici.</a>

---

## Tu veux améliorer tes tests ?
<!--
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
-->

Si tu rencontres des problèmes de maintenance avec tes tests, s'ils ne sont pas assez lisibles, s'ils cassent pour de mauvaises raisons, je peux t'aider.

<div class="offer">
    <div class="offer-content">
    Accède à ma <a href="https://formation.charlesdesneuf.com/ameliorez-vos-tests-automatises?utm_medium=social&utm_source=linkedin&utm_campaign=carousel-utilisation-tags-tests">formation vidéo</a> ou jette un coup d'oeil à mon <a href="https://formation.charlesdesneuf.com/guide-gratuit-5-idees-pour-ameliorer-la-lisibilite-de-vos-tests-automatises?utm_medium=social&utm_source=linkedin&utm_campaign=carousel-utilisation-tags-tests">guide gratuit pour améliorer la lisibilité des tests</a>.
    </div>
    <div class="offer-img">
    <a href="https://formation.charlesdesneuf.com/guide-gratuit-5-idees-pour-ameliorer-la-lisibilite-de-vos-tests-automatises?utm_medium=social&utm_source=linkedin&utm_campaign=carousel-utilisation-tags-tests">
    <img src="https://formation.charlesdesneuf.com/content-assets/public/eyJhbGciOiJIUzI1NiJ9.eyJvYmplY3Rfa2V5IjoiZHdvazQ1NXZvbDQwdm9rZHNmbXV0NnVxMHF1bCIsImRvbWFpbiI6ImZvcm1hdGlvbi5jaGFybGVzZGVzbmV1Zi5jb20ifQ.NS61AHjRUfdqsvHH6gqCbDNSSyCeI3U3AUlI-7U-PzE" class="free-guide-picture" /></a>
    </div>
</div>
