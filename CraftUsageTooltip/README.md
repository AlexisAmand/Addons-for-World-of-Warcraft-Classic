# Craft Usage Tooltip

**Craft Usage Tooltip** is a lightweight World of Warcraft addon that displays the professions using an ingredient directly inside the item tooltip.

Get the stable release on CurseForge: [Craft Usage Tooltip](https://www.curseforge.com/wow/addons/craft-usage-tooltip)

## Development notice

### 🔄 Major Rewrite

Version 0.1 introduces a complete rewrite of CraftUsageTooltip's internal system.

The previous version was still experimental and could sometimes produce incomplete or incorrect results. The system used to identify professions and ingredients has therefore been completely redesigned to make the addon more reliable.

### ✨ New Features

* Automatically detects which professions use the hovered item as an ingredient.
* New inverted database linking ingredients to professions.
* Professions are now displayed directly in the item tooltip.
* Profession icons have been added to the tooltip.
* Profession names are now retrieved directly from the game, so they automatically use the player's client language.

### 🛠️ Improvements

* Complete rewrite of recipe data processing.
* Improved reliability of the information displayed.
* Removed several experimental elements from previous versions.

This release provides a much more solid foundation for future improvements to the addon.

## Dependencies

* LibProfessionDB
