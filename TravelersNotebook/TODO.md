# todo — Traveler's Notebook

## Identité du projet
- [x] Mettre à jour les fichiers .toc avec les informations de la Team Panda
- [x] Harmoniser les descriptions des addons
- [x] Ajouter les crédits dans la fenêtre "À propos"

## Architecture
- [ ] Déplacer les fonctions utilitaires dans un fichier externe
- [ ] Séparer la logique des notes de l'interface
- [ ] Organiser les fichiers Lua par fonctionnalité : fonctions, boutons, ....etc.
- [ ] Mettre les fonctions dans un fichier externe

## Prochaines fonctionnalités
- [x] Ajouter le système de modes (LISTE / EDITION)
- [ ] Notes épinglées
- [x] Ajouter la position du joueur dans une note
- [ ] Améliorer la liste des notes

## Améliorations
- [ ] Revoir l'apparence des boutons
- [ ] Ajouter des tooltips
- [ ] Améliorer la gestion des erreurs

## Idées
- [ ] Recherche dans les notes
- [ ] Catégories
- [ ] Export / import

**1. idée: pas tous les boutons à la fois** 

```lua
if tb.mode == "EDITION" then
    -- boutons de note : sauvegarder, position, épingler, hide, a propos, supprimer
elseif tb.mode == "LISTE" then
    -- boutons principaux : créer une note, a propos, hide
end

tb.modes = {
    LISTE = {
        tb.newButton,
        tb.aboutButton,
        tb.hideButton
    },

    EDITION = {
        tb.saveButton,
        tb.positionButton,
        tb.pinButton,
        tb.deleteButton,
        tb.aboutButton,
        tb.hideButton
    }
}
```

**4. épingler une note en haut de la liste**

ajout d'un champ pinned = true (point doré sur GUI) 
ou
pinned = false (point gris sur GUI)

**5. Sauvegarde automatique de la note en cours**

**6. boutons carrés**

💾 Save
🗑 Delete
📌 Pin
📍 Position
❓ About
× Hide




