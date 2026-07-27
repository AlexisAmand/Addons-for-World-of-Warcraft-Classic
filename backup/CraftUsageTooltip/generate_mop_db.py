import os
import time
import requests
from bs4 import BeautifulSoup

OUTPUT_DIR = "output_mop"
BASE_URL = "https://www.wowdb.com/spells/professions/{slug}"

PROFESSIONS = {
    "Alchemy": {
        "slug": "alchemy",
        "lua_table": "REAGENT_TO_PROF_ALCH",
        "file": "ReagentDB_Alchemy.lua",
    },
    "Blacksmithing": {
        "slug": "blacksmithing",
        "lua_table": "REAGENT_TO_PROF_BS",
        "file": "ReagentDB_Blacksmithing.lua",
    },
    "Tailoring": {
        "slug": "tailoring",
        "lua_table": "REAGENT_TO_PROF_TAIL",
        "file": "ReagentDB_Tailoring.lua",
    },
    "Leatherworking": {
        "slug": "leatherworking",
        "lua_table": "REAGENT_TO_PROF_LW",
        "file": "ReagentDB_Leatherworking.lua",
    },
    "Engineering": {
        "slug": "engineering",
        "lua_table": "REAGENT_TO_PROF_ENG",
        "file": "ReagentDB_Engineering.lua",
    },
    "Inscription": {
        "slug": "inscription",
        "lua_table": "REAGENT_TO_PROF_INS",
        "file": "ReagentDB_Inscription.lua",
    },
    "Jewelcrafting": {
        "slug": "jewelcrafting",
        "lua_table": "REAGENT_TO_PROF_JC",
        "file": "ReagentDB_Jewelcrafting.lua",
    },
    "Enchanting": {
        "slug": "enchanting",
        "lua_table": "REAGENT_TO_PROF_ENCH",
        "file": "ReagentDB_Enchanting.lua",
    },
    "Cooking": {
        "slug": "cooking",
        "lua_table": "REAGENT_TO_PROF_COOK",
        "file": "ReagentDB_Cooking.lua",
    },
}

HEADERS = {"User-Agent": "Mozilla/5.0"}

def fetch_spell_ids_for_profession(slug):
    url = BASE_URL.format(slug=slug)
    print(f"[INFO] Fetching spell list: {url}")

    resp = requests.get(url, headers=HEADERS)
    resp.raise_for_status()

    soup = BeautifulSoup(resp.text, "html.parser")

    spell_ids = []

    # WoWDB lists spells in a table with rows containing data-id attributes
    rows = soup.select("tr[data-id]")
    for row in rows:
        spell_id = row.get("data-id")
        if not spell_id:
            continue

        # Filter by MoP patch (5.x)
        patch_cell = row.find("td", {"class": "col-patch"})
        if patch_cell and patch_cell.text.strip().startswith("5."):
            spell_ids.append(int(spell_id))

    print(f"[INFO] Found {len(spell_ids)} MoP spells for {slug}")
    return spell_ids


def fetch_reagents_for_spell(spell_id):
    url = f"https://www.wowdb.com/spells/{spell_id}/tooltip"
    time.sleep(0.2)  # avoid hammering WoWDB

    resp = requests.get(url, headers=HEADERS)
    if resp.status_code != 200:
        print(f"[WARN] Spell {spell_id} → HTTP {resp.status_code}")
        return {}

    try:
        data = resp.json()
    except Exception:
        print(f"[WARN] Spell {spell_id} → invalid JSON")
        return {}

    reagents = {}

    try:
        for reagent in data.get("reagents", []):
            item_id = reagent.get("id")
            item_name = reagent.get("name", "Unknown")
            if item_id:
                reagents[item_id] = item_name
    except Exception:
        pass

    return reagents


def write_lua_file(prof_name, meta, reagents):
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    path = os.path.join(OUTPUT_DIR, meta["file"])

    lua_table = meta["lua_table"]

    print(f"[INFO] Writing {path}")

    with open(path, "w", encoding="utf-8") as f:
        f.write(f"{lua_table} = {{\n")
        for item_id, item_name in sorted(reagents.items()):
            f.write(f'    [{item_id}] = "{prof_name}", -- {item_name}\n')
        f.write("}\n")

    print(f"[OK] {prof_name}: {len(reagents)} reagents written")

def main():
    for prof_name, meta in PROFESSIONS.items():
        slug = meta["slug"]

        spell_ids = fetch_spell_ids_for_profession(slug)
        all_reagents = {}

        for spell_id in spell_ids:
            reagents = fetch_reagents_for_spell(spell_id)
            all_reagents.update(reagents)

        write_lua_file(prof_name, meta, all_reagents)

    print("[DONE] All profession files generated in ./output_mop")


if __name__ == "__main__":
    main()
