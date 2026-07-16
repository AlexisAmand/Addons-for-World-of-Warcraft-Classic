# Changelog — Gasp Of Pandaria

Toutes les modifications notables du projet sont documentées ici.

---

## v0.1.0 — Base fonctionnelle
- Création du projet et structure initiale de l’addon.
- Ajout de la fenêtre principale avec `BasicFrameTemplate`.
- Ajout de la commande `/gaspofpandaria` pour afficher l’interface.
- Mise en place du fond de fenêtre (texture WoW).
- Création de la grille logique 4×4 (`grille[y][x]`).
- Création des boutons de la grille (4×4), centrés dans un `gridFrame`.
- Ajout des textures de test (blanc/noir).

---

## v0.2.0 — Intégration des gemmes
- Ajout des images personnalisées (gemmes bleue et verte).
- Conversion des images en `.tga` pour compatibilité WoW.
- Mise en place des textures gemmes dans les boutons.
- Suppression des textures de test.
- Ajustements visuels pour un rendu plus propre.

---

## v0.3.0 — Mécanique du jeu
- Ajout de la fonction `Retourne(x, y)` :
  - Retourne les 8 voisins autour du pion cliqué.
  - Ne modifie pas la gemme cliquée (règle du jeu Gasp).
  - Met à jour les textures des gemmes retournées.
- Ajout du compteur de coups (`nbCoups`).
- Correction de l’erreur `attempt to perform arithmetic on global 'nbCoups'`.
- Correction de l’erreur `attempt to call a nil value` en ajoutant `VerificationGrille()`.

---

## v0.4.0 — Vérification de victoire
- Ajout de la fonction `VerificationGrille()`.
- Détection automatique lorsque toutes les gemmes sont identiques.
- Affichage d’un message de victoire.
- Ajout d’un son WoW lors de la victoire (optionnel).

---

## v0.5.0 — Nettoyage et organisation
- Réorganisation du code pour respecter l’ordre logique :
  - Variables globales
  - Fonctions utilitaires
  - Fonctions de jeu
  - Interface WoW
- Ajout du README.md.
- Ajout du CHANGELOG.md.
- Mise en ligne du projet sur GitHub.

---

## v0.6.0 — Nettoyage et organisation
- Message en cas de victoire
- Ajout d'un bouton près de la minimap
- bugfix sur le gameplay 0/1

---

## À venir
- Bouton “Reset”.
- Animation de retournement.
- Sons personnalisés.
- Timer optionnel.
- Thème graphique complet.
