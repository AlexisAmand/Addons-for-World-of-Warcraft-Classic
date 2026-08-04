## 0.0.1

* Initial release of Craft Usage Tooltip
* Displays professions associated with tradeskill ingredients directly in item tooltips
* Lightweight, single-file addon with no configuration required

## 0.0.2

* Added support for Gems
* Added support for Reagents / Catalysts
* Added support for Miscellaneous items

## 0.0.3

* Added support for Monster Parts (glands, venom sacs, fangs, claws, organs)
* Added support for Elemental reagents
* Added support for generic reagents

## 0.0.14 — July 15, 2026

* Added itemFamily detection (Fish / Meat → Cooking only)
* Added exception table for misclassified items (scales, venoms, engineering components)
* Improved reagent classification (classID = 5)
* Fixed tooltip duplication issue
* Cleaned code and removed redundant checks

## 0.1 - August 3, 2026

Version 0.1 introduces a complete rewrite of CraftUsageTooltip's internal system. The previous version was still experimental and could sometimes produce incomplete or incorrect results. The system used to identify professions and ingredients has therefore been completely redesigned to make the addon more reliable.

## 0.2 - August 4, 2026

* Updated profession icons.
* Fixed an issue where some professions were missing from item tooltips.
* code review
