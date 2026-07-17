# Changelog — Gasp of Pandaria

All notable changes to the project are documented here.

---

## v0.1.0 — July 16, 2026
- Initial project creation and addon structure.
- Added main window using `BasicFrameTemplate`.
- Added `/gaspofpandaria` command to open the interface.
- Implemented background texture for the main frame.
- Created the logical 4×4 grid (`grid[y][x]`).
- Added 4×4 button grid centered inside a `gridFrame`.
- Added temporary test textures (white/black).

---

## v0.2.0 — July 16, 2026
- Added custom gem textures (blue and green).
- Converted images to `.tga` for WoW compatibility.
- Integrated gem textures into grid buttons.
- Removed temporary test textures.
- Visual adjustments for a cleaner look.

---

## v0.3.0 — July 16, 2026
- Added `Flip(x, y)` function:
  - Flips the 8 neighbors around the clicked gem.
  - Does not flip the clicked gem (Gasp rule).
  - Updates textures of flipped gems.
- Added move counter (`nbCoups`).
- Fixed error: `attempt to perform arithmetic on global 'nbCoups'`.
- Fixed error: `attempt to call a nil value` by adding `CheckGrid()`.

---

## v0.4.0 — July 16, 2026
- Added `CheckGrid()` function.
- Automatic detection when all gems match.
- Victory message added.
- Optional WoW victory sound added.

---

## v0.5.0 — July 16, 2026
- Reorganized code into logical sections:
  - Global variables
  - Utility functions
  - Game functions
  - WoW interface
- Added README.md.
- Added CHANGELOG.md.
- Project published on GitHub.

---

## v0.6.0 — July 16, 2026
- Added improved victory message.
- Added minimap button.
- Gameplay 0/1 bugfix.
- Updated reset button.
- Updated rules button.

---

## v0.6.3 — July 16, 2026
- Code cleanup.
- All addon text is now in English.
- Major code optimization.

---

## v0.7 — July 16, 2026
- GUI improvements.
- Added subtle gem‑flip animation.
- Added RP‑style text for the rules.
- Fixed issue where the game did not reset automatically after victory.

---

## v0.8 — July 17, 2026
- Code cleanup.
- Best score is now saved during the session.

---

## v0.9 — July 17, 2026
- Best score is now saved across sessions.

---

## v0.9.1 — July 17, 2026
- Fixed issue where the addon started automatically.

---

## v0.9.2 — July 17, 2026
- Fixed rules message alignment (properly centered).

---

## v0.9.3 — July 17, 2026
- Code optimization.

---

## v0.9.4 — July 17, 2026
- GUI improvements.


---

## À venir
- fenêtre qu'on peut bouger ?
- Sons personnalisés.
- Timer optionnel.

