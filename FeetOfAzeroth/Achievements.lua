-- Titre : Achivements X / 20

-- Premier pas : 1 km
-- Promenade : 10 km
-- Aventurier : 50 km
-- Voyageur d'Azeroth : 100 km
-- Grand Routard : 500 km
-- Pélerin d'Azeroth : 1 000 km
-- Infatigable : 5 000 km
-- Azeroth est ma maison : 10 000 km

-- À travers les Royaumes de l'Est : 100 km dans les Royaumes de l'Est
-- Jusqu'aux confins de Kalimdor : 100 km sur Kalimdor
-- Sur les traces des pandarens : 100 km en Pandarie

fa = fa or {}

fa.achievements = {
    {
        id = "A",
        name = "Premiers pas",
        description = "Parcourez 1 km.",
        distance = 1000,
        reussi = false
    },
    {
        id = "B",
        name = "Voyageur",
        description = "Parcourez 10 km.",
        distance = 10000,
        reussi = false
    },
    {
        id = "C",
        name = "Marcheur infatigable",
        description = "Parcourez 1000 km.",
        distance = 1000000,
        reussi = false
    },
}

----------------------
-- affichage des stats
----------------------

function fa.afficherAchievements()

    fa.optionMenu:Hide()

    -- fenêtre

    fa.frameAchievements = CreateFrame("Frame", "FAWindow", UIParent)
    fa.frameAchievements:SetSize(300, 250)
    fa.frameAchievements:SetPoint("CENTER")

    -- Fond

    fa.frameAchievements.bg = fa.frameAchievements:CreateTexture(nil, "BACKGROUND")
    fa.frameAchievements.bg:SetAllPoints()
    fa.frameAchievements.bg:SetColorTexture(0, 0, 0, 0.7)

    -- Bordure

    fa.frameAchievements.border = CreateFrame("Frame", nil, fa.frameAchievements, "BackdropTemplate")
    fa.frameAchievements.border:SetAllPoints()
    fa.frameAchievements.border:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
    })

    -- Titre

    fa.frameAchievements.titre = fa.frameAchievements:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    fa.frameAchievements.titre:ClearAllPoints()
    fa.frameAchievements.titre:SetPoint("TOP", fa.frameAchievements, "TOP", 0, -10)
    fa.frameAchievements.titre:SetText("Achievements")

    -- ligne de séparation

    fa.frameAchievementsSeparator = fa.frameAchievements:CreateTexture(nil, "ARTWORK")
    fa.frameAchievementsSeparator:SetColorTexture(1, 1, 1, 0.15)
    fa.frameAchievementsSeparator:SetSize(270, 1)
    fa.frameAchievementsSeparator:SetPoint("TOP", fa.frameAchievements.titre, "BOTTOM", 0, -4)

    -- Achichage de la liste des succès

    local i = 1

    for _, achievement in ipairs(fa.achievements) do

        -- Rond
        local indicator = fa.frameAchievements:CreateTexture(nil, "ARTWORK")
        indicator:SetSize(20, 20)
        indicator:SetPoint("TOPLEFT", fa.frameAchievementsSeparator, "TOPLEFT", 10, -15 * i)

        if FASaved.FeetOfAzerothDB.achievements[achievement.id] then
            indicator:SetTexture("Interface\\COMMON\\Indicator-green")
        else
            indicator:SetTexture("Interface\\COMMON\\Indicator-gray")
        end

        -- Nom
        local nom = fa.frameAchievements:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        nom:SetPoint("LEFT", indicator, "RIGHT", 5, 0)
        nom:SetText(achievement.name)

        -- Description dans un tooltip
        nom:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(achievement.description)
            GameTooltip:Show()
        end)

        nom:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)

        i = i + 1
    end

    -- Texte en bas

    fa.frameAchievements.message = fa.frameAchievements:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.frameAchievements.message:SetPoint("BOTTOM", 0, 40)
    fa.frameAchievements.message:SetText("Noodle soup & naps keep you healthy !")

    -- ligne de séparation

    fa.frameAchievementsSeparator = fa.frameAchievements:CreateTexture(nil, "ARTWORK")
    fa.frameAchievementsSeparator:SetColorTexture(1, 1, 1, 0.15)
    fa.frameAchievementsSeparator:SetSize(270, 1)
    fa.frameAchievementsSeparator:SetPoint("BOTTOM", fa.frameAchievements.message, "TOP", 0, 4)

    -- Bouton fermeture

    fa.closeButton = CreateFrame("Button", nil, fa.frameAchievements, "UIPanelButtonTemplate")
    fa.closeButton:SetSize(67, 25)
    fa.closeButton:SetText("Close")
    fa.closeButton:SetPoint("BOTTOM", fa.frameAchievements, "BOTTOM", 0, 10)
    fa.closeButton:SetScript("OnClick", function(self)
        fa.frameAchievements:Hide()
    end)
end

----------------------------
-- pop qui affiche le succès
----------------------------

function fa.afficherSucces(achievement)

    fa.successFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    fa.successFrame:SetSize(180, 135)
    fa.successFrame:SetPoint("TOP")

    fa.successFrame.bg = fa.successFrame:CreateTexture(nil, "BACKGROUND")
    fa.successFrame.bg:SetAllPoints()
    fa.successFrame.bg:SetColorTexture(0, 0, 0, 0.7)

    fa.successFrame.border = CreateFrame("Frame", nil, fa.successFrame, "BackdropTemplate")
    fa.successFrame.border:SetAllPoints()
    fa.successFrame.border:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
    })

    local nom = fa.successFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nom:SetPoint("TOP", 0, 0)
    nom:SetText(
    "Great !\n\nSuccès débloqué !\n\n"
    .. achievement.name
    .. "\n\n"
    .. achievement.description
)

    fa.successFrame:Show()
end

------------------------
-- Validation des succès
------------------------

function fa.validationAchievements()
    for _, achievement in ipairs(fa.achievements) do
        if fa.distanceTotal * 0.9144 >= achievement.distance
        and not FASaved.FeetOfAzerothDB.achievements[achievement.id] then
            FASaved.FeetOfAzerothDB.achievements[achievement.id] = true
            fa.afficherSucces(achievement)
        end
    end
end

