# Craft Usage Tooltip

A lightweight World of Warcraft addon that displays the professions using an ingredient directly inside the item tooltip.




































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
