# todo — Traveler's Notebook

## Identité du projet
- [x] Mettre à jour les fichiers .toc avec les informations de la Team Panda
- [x] Harmoniser les descriptions des addons
- [ ] Ajouter les crédits dans la fenêtre "À propos"

## Architecture
- [ ] Déplacer les fonctions utilitaires dans un fichier externe
- [ ] Séparer la logique des notes de l'interface
- [ ] Organiser les fichiers Lua par fonctionnalité : fonctions, boutons, ....etc.

## En cours
- [ ] Mettre les fonctions dans un fichier externe
- [ ] Ajouter le système de modes (LISTE / EDITION)

## Prochaines fonctionnalités
- [ ] Notes épinglées
- [ ] Ajouter la position du joueur dans une note
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

**2. capture de position (nom zone)**

```lua
local zone = C_Map.GetMapInfo(mapID)
print(zone.name)
```

**3. Capture de position (coordonées)**

```lua
local mapID = C_Map.GetBestMapForUnit("player")
local position = C_Map.GetPlayerMapPosition(mapID, "player")

if position then
    local x, y = position:GetXY()
    print(x, y)
end
```

Ou, si on veut le mettre dans la zone d'édition

```lua
local mapID = C_Map.GetBestMapForUnit("player")
local zone = C_Map.GetMapInfo(mapID)

if zone then
    local position = C_Map.GetPlayerMapPosition(mapID, "player")

    if position then
        local x, y = position:GetXY()

        local texte = string.format(
            "\n📍 %s\nPosition : %.1f, %.1f\n",
            zone.name,
            x * 100,
            y * 100
        )

        tb.editBox:Insert(texte)
    end
end
```lua

x et y sont entre 0 et 1, il faut faire x 100

```lua
local xPercent = x * 100
local yPercent = y * 100
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




