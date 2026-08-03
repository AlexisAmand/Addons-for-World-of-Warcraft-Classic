-- récupération de la LibProfessionDB

local DB = LibStub("LibProfessionDB-1.0", true)

-- la base est-elle prête ?

if DB and DB:IsReady() then
    print("ProfessionDB est prête !")
else
    print("ProfessionDB n'est pas prête.")
end

-- pour chaque recette : son métier, son identifiant, et les informations de la recette

local profsATester = {
    [129] = true,
    [164] = true,
    [197] = true,
    [202] = true,
}

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

-- icones pour les professions 

local ProfessionIcons = {
    [197] = "Interface\\Icons\\Trade_Tailoring",
    [165] = "Interface\\Icons\\INV_Misc_LeatherScrap_02",
    [164] = "Interface\\Icons\\Trade_BlackSmithing",
    [171] = "Interface\\Icons\\Trade_Alchemy",
    [333] = "Interface\\Icons\\Trade_Engraving",
    [185] = "Interface\\Icons\\INV_Misc_Food_15",
    [186] = "Interface\\Icons\\INV_Misc_Organ_01",
    [202] = "Interface\\Icons\\INV_Elemental_Primal_Fire",
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



