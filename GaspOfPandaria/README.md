# Gasp Of Pandaria

Un mini‑jeu de réflexion pour World of Warcraft, inspiré du jeu Gasp : cliquez sur une gemme pour retourner les huit voisines… mais pas celle que vous avez cliquée.  
Le but : obtenir une grille uniforme en un minimum de coups.

---

## 🎮 Fonctionnement

- La grille est composée de 16 gemmes (4×4).  
- Chaque gemme est soit **bleue**, soit **verte**.  
- Cliquer sur une gemme **ne change pas sa couleur**, mais retourne les 8 voisines autour d’elle.  
- Le compteur de coups augmente à chaque action.  
- Une vérification automatique détecte la victoire lorsque toutes les gemmes sont identiques.

---

## 🧩 Commande en jeu

Ouvrir la fenêtre du jeu :

/gaspofpandaria

---

## 📦 Installation

1. Télécharger le dossier `GaspOfPandaria`.  
2. Le placer dans le dossier addons de votre version de WoW
3. Lancer WoW (ou `/reload`).  
4. Activer l’addon dans le menu AddOns.

## 📝 Licence

TODO
Crédits : Alexis AMAND — Saint‑Saulve, France.




































```lua
--[[
    Addon: Craft Usage Tooltip
    Author: Alexis + Copilot
    Description:
        Displays the professions associated with a tradeskill ingredient.
        Uses WoW's item class/subclass to determine the profession.
        Profession names are retrieved via GetSpellInfo() for full localization.
        Extremely lightweight: single Lua file, no database, no scanning.

    Features:
        - Automatic detection of tradeskill ingredients
        - Profession icons in item tooltips
        - Multilingual (all WoW client languages supported)
        - Zero configuration required
        - Compatible with Classic / SoD / HC / MoP Classic / Retail
--]]
```

## Overview
Craft Usage Tooltip enhances item tooltips by showing which professions use the selected ingredient.  
The addon relies entirely on the official WoW API and does not include any external data tables.

## How It Works
```lua
local classID, subClassID = select(12, GetItemInfo(itemID))
if classID == 7 then
    -- Tradeskill ingredient detected
    -- Lookup profession(s) based on subclass
end
```

Profession names are retrieved using:
```lua
GetSpellInfo(spellID)
```
This ensures automatic localization for all languages supported by World of Warcraft.

## Supported Professions
```lua
Tailoring, First Aid
Leatherworking
Blacksmithing
Alchemy, Inscription
Enchanting
Cooking
```

## Installation
Place the folder `CraftUsageTooltip` into:
```
World of Warcraft/_classic_/Interface/AddOns/
```
(or the equivalent folder for your WoW version)

## Compatibility
- Compatible with WoW Classic MoP (5.4.0)

## Credits
```lua
Author = "Alexis"
Assistant = "Copilot"
```

## License
MIT License
