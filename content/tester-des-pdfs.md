<!--
theme:  your-theme
size: linkedin-portrait
paginate: true
header: Tester des PDFs visuellement
_header: ''
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
footer: <a href="https://www.linkedin.com/in/charles-desneuf/">Charles Desneuf</a>
-->

# Tester des PDFs visuellement
Sans passer 2 heures à les scruter, c'est possible !

Merci l'_Approval Testing_ !

---


## Le problème

Tu bosses sur une application qui génère des PDFS, avec plein de pages, et tu veux t'assurer du rendu, surtout que tu pousses des data que tu calcules dedans. 

Et tu es une personne normale et tu ne veux pas passer 2H heures à scruter les PDFs à chaque modif pour voir si tout est ok.

<span class="small">Et laisser les utilisateurs le faire pour toi n'est pas une option.</span>

---

## Approval Testing 101

L'idée de l'Approval Testing est de garder une copie du résultat attendu du système de côté et de comparer cette copie avec le nouveau résultat à chaque fois que le test est lancé.

Si c'est pareil, c'est ok ✅
Sinon, c'est pas ok ❌

Dingue ?

---

## Approval Testing ❤️ PDF

On peut utiliser cette idée avec des PDFs. On génère le PDF, on le scrute une fois, si on en est content on l'approuve (d'où le nom) et on le garde de côté.

Ensuite, à chaque fois que l'on lance les tests on fait en sorte de comparer le PDF approuvé avec le PDF généré.

---

## Tests visuels

Mais comment comparer des PDFs ? Surtout si l'on s'intéresse particulièrement à son rendu ?

On peut utiliser un programme externe, comme `diff-pdf`, qui va faire une comparaison visuelle et nous dire si tout est bon.

Même mieux, `diff-pdf` est capable de produire un diff visuel s'il y a des différences.

<div class="container">
<img src="./diff-pdf.png" />
</div>

---

## Une assertion sur mesure

Il y a peu de chance que ton framework de test fournisse une assertion qui fasse ça, mais tu peux la construire toi même.

---

## Tu veux améliorer tes tests ?
<!--
_footer: <a href="https://www.linkedin.com/in/charles-desneuf/"><img src="./charles-desneuf-square.png" class="profile-picture">Charles Desneuf</a>
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

