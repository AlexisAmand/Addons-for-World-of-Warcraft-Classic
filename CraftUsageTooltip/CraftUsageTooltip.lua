local ADDON_NAME = ...

local PROF_NAMES = {
    Tailoring      = GetSpellInfo(3908),
    FirstAid       = GetSpellInfo(3273),
    Leatherworking = GetSpellInfo(2108),
    Blacksmithing  = GetSpellInfo(2018),
    Alchemy        = GetSpellInfo(2259),
    Enchanting     = GetSpellInfo(7411),
    Inscription    = GetSpellInfo(45357),
    Cooking        = GetSpellInfo(2550),
    Engineering    = GetSpellInfo(4036),
    Jewelcrafting  = GetSpellInfo(25229),
}

-- Trade Goods (classID = 7)
local SUBCLASS_TO_PROF = {
    [5]  = {PROF_NAMES.Tailoring, PROF_NAMES.FirstAid},     -- Cloth
    [6]  = {PROF_NAMES.Leatherworking},                     -- Leather
    [7]  = {PROF_NAMES.Blacksmithing},                      -- Metal & Stone
    [9]  = {PROF_NAMES.Alchemy, PROF_NAMES.Inscription},    -- Herb
    [12] = {PROF_NAMES.Enchanting},                         -- Enchanting
    [8]  = {PROF_NAMES.Cooking},                            -- Cooking
    [11] = {PROF_NAMES.Alchemy, PROF_NAMES.Engineering, PROF_NAMES.Cooking}, -- Other
    [10] = {  -- Elemental
        PROF_NAMES.Alchemy,
        PROF_NAMES.Enchanting,
        PROF_NAMES.Engineering,
        PROF_NAMES.Blacksmithing,
        PROF_NAMES.Tailoring,
        PROF_NAMES.Leatherworking
    },
}

local PROF_ICONS = {
    [5]  = "Interface\\Icons\\Trade_Tailoring",
    [6]  = "Interface\\Icons\\INV_Misc_LeatherScrap_02",
    [7]  = "Interface\\Icons\\Trade_BlackSmithing",
    [9]  = "Interface\\Icons\\Trade_Alchemy",
    [12] = "Interface\\Icons\\Trade_Engraving",
    [8]  = "Interface\\Icons\\INV_Misc_Food_15",
    [11] = "Interface\\Icons\\INV_Misc_Organ_01",
    [10] = "Interface\\Icons\\INV_Elemental_Primal_Fire",
}

local cache = {}

-- Exceptions pour les objets mal classés par Blizzard
local EXCEPTIONS = {

    --------------------------------------------------------------------
    -- VENINS / SACS DE VENIN / GLANDES À VENIN → Alchimie
    --------------------------------------------------------------------
    [1475] = { profs = { PROF_NAMES.Alchemy }, icon = "Interface\\Icons\\INV_Misc_Organ_01" }, -- Small Venom Sac
    [2924] = { profs = { PROF_NAMES.Alchemy }, icon = "Interface\\Icons\\INV_Misc_Organ_01" }, -- Venom Sac
    [1288] = { profs = { PROF_NAMES.Alchemy }, icon = "Interface\\Icons\\INV_Misc_Organ_01" }, -- Large Venom Sac
    [3174] = { profs = { PROF_NAMES.Alchemy }, icon = "Interface\\Icons\\INV_Misc_Organ_01" }, -- Spider Venom Sac

    --------------------------------------------------------------------
    -- ORGANES / PARTIES DE MONSTRES → Alchimie ou Cuisine
    --------------------------------------------------------------------
    [3172] = { profs = { PROF_NAMES.Alchemy }, icon = "Interface\\Icons\\INV_Misc_Organ_01" }, -- Boar Intestines
    [723]  = { profs = { PROF_NAMES.Cooking }, icon = "Interface\\Icons\\INV_Misc_Food_15" }, -- Boar Liver
    [3164] = { profs = { PROF_NAMES.Alchemy }, icon = "Interface\\Icons\\INV_Misc_Organ_01" }, -- Wolf Heart
    [11382] = { profs = { PROF_NAMES.Alchemy }, icon = "Interface\\Icons\\INV_Misc_Organ_01" }, -- Basilisk Heart / Dragon Heart / Troll Heart
    [10286] = { profs = { PROF_NAMES.Alchemy }, icon = "Interface\\Icons\\INV_Misc_Organ_01" }, -- Whelp Heart
    [12184] = { profs = { PROF_NAMES.Cooking }, icon = "Interface\\Icons\\INV_Misc_Food_15" }, -- Raptor Flesh
    [1015]  = { profs = { PROF_NAMES.Cooking }, icon = "Interface\\Icons\\INV_Misc_Food_15" }, -- Lean Wolf Flank

    --------------------------------------------------------------------
    -- CROCS / GRIFFES / GLANDES → Alchimie
    --------------------------------------------------------------------
    [4461] = { profs = { PROF_NAMES.Alchemy }, icon = "Interface\\Icons\\INV_Misc_Organ_01" }, -- Raptor Jaw
    [4460] = { profs = { PROF_NAMES.Alchemy }, icon = "Interface\\Icons\\INV_Misc_Organ_01" }, -- Raptor Claw
    [11370] = { profs = { PROF_NAMES.Alchemy }, icon = "Interface\\Icons\\INV_Misc_Organ_01" }, -- Basilisk Claw / Gland
    [11390] = { profs = { PROF_NAMES.Alchemy }, icon = "Interface\\Icons\\INV_Misc_Organ_01" }, -- Bat Gland
    [11391] = { profs = { PROF_NAMES.Alchemy }, icon = "Interface\\Icons\\INV_Misc_Organ_01" }, -- Snake Gland

    --------------------------------------------------------------------
    -- ÉCAILLES → Travail du cuir
    --------------------------------------------------------------------
    [5784] = { profs = { PROF_NAMES.Leatherworking }, icon = "Interface\\Icons\\INV_Misc_MonsterScales_03" }, -- Thick Murloc Scale
    [5785] = { profs = { PROF_NAMES.Leatherworking }, icon = "Interface\\Icons\\INV_Misc_MonsterScales_02" }, -- Thin Murloc Scale
    [15416] = { profs = { PROF_NAMES.Leatherworking }, icon = "Interface\\Icons\\INV_Misc_MonsterScales_03" }, -- Black Dragon Scale
    [15415] = { profs = { PROF_NAMES.Leatherworking }, icon = "Interface\\Icons\\INV_Misc_MonsterScales_03" }, -- Blue Dragon Scale
    [15414] = { profs = { PROF_NAMES.Leatherworking }, icon = "Interface\\Icons\\INV_Misc_MonsterScales_03" }, -- Red Dragon Scale

    --------------------------------------------------------------------
    -- COMPOSANTS D’INGÉNIERIE MAL CLASSÉS → Ingénierie
    --------------------------------------------------------------------
    [4364] = { profs = { PROF_NAMES.Engineering }, icon = "Interface\\Icons\\INV_Misc_Gear_01" }, -- Coarse Blasting Powder
    [4377] = { profs = { PROF_NAMES.Engineering }, icon = "Interface\\Icons\\INV_Misc_Gear_01" }, -- Heavy Blasting Powder
    [10505] = { profs = { PROF_NAMES.Engineering }, icon = "Interface\\Icons\\INV_Misc_Gear_01" }, -- Solid Blasting Powder
    [4367] = { profs = { PROF_NAMES.Engineering }, icon = "Interface\\Icons\\INV_Misc_Bomb_05" }, -- Copper Modulator
    [4371] = { profs = { PROF_NAMES.Engineering }, icon = "Interface\\Icons\\INV_Misc_Gear_01" }, -- Bronze Tube
    [4382] = { profs = { PROF_NAMES.Engineering }, icon = "Interface\\Icons\\INV_Misc_Gear_01" }, -- Iron Strut
}

local function AddProfToTooltip(tooltip)
    if not tooltip or not tooltip.GetItem then return end

    local _, link = tooltip:GetItem()
    if not link then
        local owner = tooltip:GetOwner()
        if owner and owner.GetItem then
            _, link = owner:GetItem()
        end
    end
    if not link then return end

    local itemID = tonumber(link:match("item:(%d+)"))
    if not itemID then return end

    if cache[itemID] then
        tooltip:AddLine(cache[itemID])
        tooltip:Show()
        return
    end

    local itemName, _, _, _, _, itemType, itemSubType = GetItemInfo(itemID)
    local classID, subClassID = select(12, GetItemInfo(itemID))
    if not classID then return end

    local text

    --------------------------------------------------------------------
    -- Couche 1 : détection multilingue par itemFamily
    --------------------------------------------------------------------
    local itemFamily = GetItemFamily(itemID)

    -- Poissons
    if itemFamily == 2 then
        local icon = "Interface\\Icons\\INV_Misc_Fish_03"
        text = "|cff00ff00|T" .. icon .. ":16|t " .. PROF_NAMES.Cooking .. "|r"
        cache[itemID] = text
        tooltip:AddLine(text)
        tooltip:Show()
        return
    end

    -- Viandes
    if itemFamily == 1 then
        local icon = "Interface\\Icons\\INV_Misc_Food_15"
        text = "|cff00ff00|T" .. icon .. ":16|t " .. PROF_NAMES.Cooking .. "|r"
        cache[itemID] = text
        tooltip:AddLine(text)
        tooltip:Show()
        return
    end

    --------------------------------------------------------------------
    -- Couche 2 : exceptions
    --------------------------------------------------------------------
    if EXCEPTIONS[itemID] then
        local e = EXCEPTIONS[itemID]
        text = "|cff00ff00|T" .. e.icon .. ":16|t " .. table.concat(e.profs, ", ") .. "|r"
        cache[itemID] = text
        tooltip:AddLine(text)
        tooltip:Show()
        return
    end

    --------------------------------------------------------------------
    -- 1) Trade Goods
    --------------------------------------------------------------------
    if classID == 7 then
        local profs = SUBCLASS_TO_PROF[subClassID]
        local icon = PROF_ICONS[subClassID]

        -- Teintures → Couture + Travail du cuir
        if subClassID == 11 and itemName and itemName:find("Teinture") then
            profs = {PROF_NAMES.Tailoring, PROF_NAMES.Leatherworking}
            icon = "Interface\\Icons\\INV_Dye_Blue"
        end

        if profs then
            text = "|cff00ff00|T" .. icon .. ":16|t " .. table.concat(profs, ", ") .. "|r"
        end

    --------------------------------------------------------------------
    -- 2) Gems
    --------------------------------------------------------------------
    elseif classID == 3 then
        local profs = {
            PROF_NAMES.Blacksmithing,
            PROF_NAMES.Engineering,
            PROF_NAMES.Jewelcrafting
        }
        local icon = "Interface\\Icons\\INV_Misc_Gem_Emerald_02"
        text = "|cff00ff00|T" .. icon .. ":16|t " .. table.concat(profs, ", ") .. "|r"

    --------------------------------------------------------------------
    -- 3) Élémentaires (Reagent / Elemental)
    --------------------------------------------------------------------
    elseif classID == 5 and itemSubType == "Elemental" then
        local profs = {
            PROF_NAMES.Alchemy,
            PROF_NAMES.Enchanting,
            PROF_NAMES.Engineering,
            PROF_NAMES.Blacksmithing,
            PROF_NAMES.Tailoring,
            PROF_NAMES.Leatherworking
        }
        local icon = "Interface\\Icons\\INV_Elemental_Primal_Fire"
        text = "|cff00ff00|T" .. icon .. ":16|t " .. table.concat(profs, ", ") .. "|r"

    --------------------------------------------------------------------
    -- 4) Reagents génériques
    --------------------------------------------------------------------
    elseif classID == 5 then
        local profs = {
            PROF_NAMES.Alchemy,
            PROF_NAMES.Enchanting,
            PROF_NAMES.Engineering,
            PROF_NAMES.Blacksmithing
        }
        local icon = "Interface\\Icons\\INV_Elemental_Primal_Fire"
        text = "|cff00ff00|T" .. icon .. ":16|t " .. table.concat(profs, ", ") .. "|r"
    end

    --------------------------------------------------------------------
    -- Finalisation
    --------------------------------------------------------------------
    if not text then return end

    cache[itemID] = text
    tooltip:AddLine(text)
    tooltip:Show()
end

GameTooltip:HookScript("OnTooltipSetItem", AddProfToTooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", AddProfToTooltip)
