-- récupération de la LibProfessionDB

local DB = LibStub("LibProfessionDB-1.0", true)

-- pour chaque recette : son métier, son identifiant, et les informations de la recette
-- création de la DB

local CraftUsageDB = {}

for profId, recipeId, recipe in DB:Iterate() do
    for itemID, quantity in pairs(recipe.reagents) do

        if not CraftUsageDB[itemID] then
            CraftUsageDB[itemID] = {}
        end

        CraftUsageDB[itemID][profId] = true

    end
end

_G.CraftUsageDB = CraftUsageDB

-- liste des métiers

local ProfessionNames = {
    [129] = GetSpellInfo(3273),   -- Secourisme
    [164] = GetSpellInfo(2018),   -- Forge
    [165] = GetSpellInfo(2108),   -- Travail du cuir
    [171] = GetSpellInfo(2259),   -- Alchimie
    [182] = GetSpellInfo(2366),   -- Herboristerie
    [185] = GetSpellInfo(2550),   -- Cuisine
    [186] = GetSpellInfo(2575),   -- Minage
    [197] = GetSpellInfo(3908),   -- Couture
    [202] = GetSpellInfo(4036),   -- Ingénierie
    [333] = GetSpellInfo(7411),   -- Enchantement
    [356] = GetSpellInfo(7731),   -- Pêche
    [393] = GetSpellInfo(8613),   -- Dépeçage
    [773] = GetSpellInfo(45357),  -- Calligraphie
    [755] = GetSpellInfo(25229),  -- Joaillerie
}

-- icones pour les professions (a revoir)

local ProfessionIcons = {
    [129] = "Interface\\Icons\\spell_holy_sealofsacrifice", -- Secourisme (ok)
    [164] = "Interface\\Icons\\Trade_BlackSmithing", -- Forge (ok)
    [165] = "Interface\\Icons\\trade_leatherworking", -- Travail du cuir
    [171] = "Interface\\Icons\\Trade_Alchemy", -- Alchimie (ok)
    [182] = "Interface\\Icons\\spell_nature_naturetouchgrow", -- Herboristerie (ok)
    [185] = "Interface\\Icons\\INV_Misc_Food_15", -- Cuisine (ok)
    [186] = "interface\\icons\\trade_mining", -- Minage (ok)
    [197] = "Interface\\Icons\\trade_tailoring", -- Couture (ok)
    [202] = "Interface\\Icons\\trade_engineering", -- Ingénierie (ok)
    [333] = "Interface\\Icons\\Trade_Engraving", -- Enchantement (ok)
    [356] = "Interface\\Icons\\Trade_Fishing", -- Pêche (ok)
    [393] = "Interface\\Icons\\inv_misc_pelt_wolf_01", -- Dépeçage (ok)
    [773] = "Interface\\Icons\\INV_Inscription_Tradeskill01", -- Calligraphie
    [755] = "Interface\\Icons\\inv_misc_gem_01", -- Joaillerie (ok)
}

-- tooltip !

GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)

    local _, itemLink = tooltip:GetItem()

    if not itemLink then
        return
    end

    local itemID = tonumber(itemLink:match("item:(%d+)"))

    if not itemID then
        return
    end

    local usages = CraftUsageDB[itemID]

    if usages then
        for profId in pairs(usages) do
            local professionName = ProfessionNames[profId]
            local professionIcon = ProfessionIcons[profId]

            if professionName and professionIcon then
                tooltip:AddLine("|T" .. professionIcon .. ":16|t " .. professionName)
            end
        end

        tooltip:Show()
    end

end)



