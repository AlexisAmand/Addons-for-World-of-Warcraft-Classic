fa = fa or {}

----------------------
-- affichage des stats
----------------------

function fa.afficherAchievements()

    fa.optionMenu:Hide()

    if fa.frameStats:IsShown() then
        fa.frameStats:Hide()
    else
        fa.frameStats:Show()
    end

    -- Fenêtre
    fa.frameAchievements = CreateFrame("Frame", "FAWindow", UIParent)
    fa.frameAchievements:SetSize(300, 250)
    fa.frameAchievements:SetPoint("CENTER")

    -- On rend la fenêtre déplaçable
    fa.frameAchievements:SetMovable(true)
    fa.frameAchievements:EnableMouse(true)
    fa.frameAchievements:RegisterForDrag("LeftButton")

    fa.frameAchievements:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)

    fa.frameAchievements:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)

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
    fa.frameAchievements.titre:SetPoint("TOP", fa.frameAchievements, "TOP", 0, -10)
    local count = 0

    for _, achievement in ipairs(fa.achievements) do
        if FASaved.FeetOfAzerothDB.achievements[achievement.id] then 
            count = count + 1
        end
    end

    local texte = string.format(fa.ACHIEV_TITLE.." : %d / %d", count, #fa.achievements)
    fa.frameAchievements.titre:SetText(texte)

    -- Ligne de séparation supérieure
    local topSeparator = fa.frameAchievements:CreateTexture(nil, "ARTWORK")
    topSeparator:SetColorTexture(1, 1, 1, 0.15)
    topSeparator:SetSize(270, 1)
    topSeparator:SetPoint("TOP", fa.frameAchievements.titre, "BOTTOM", 0, -4)

    ----------------------------------------------------------------
    -- Zone de défilement
    ----------------------------------------------------------------

    local scrollFrame = CreateFrame("ScrollFrame", nil, fa.frameAchievements, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", topSeparator, "BOTTOMLEFT", 0, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", fa.frameAchievements, "BOTTOMRIGHT", -25, 75)

    -- Contenu de la zone scrollable

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetWidth(245)
    content:SetHeight(1)

    scrollFrame:SetScrollChild(content)

    ----------------------------------------------------------------
    -- Liste des succès
    ----------------------------------------------------------------

    local lineHeight = 25
    local i = 0

    for _, achievement in ipairs(fa.achievements) do

        i = i + 1

        -- Rond
        local indicator = content:CreateTexture(nil, "ARTWORK")
        indicator:SetSize(20, 20)
        indicator:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -((i - 1) * lineHeight))

        if FASaved.FeetOfAzerothDB.achievements[achievement.id] then
            indicator:SetTexture("Interface\\COMMON\\Indicator-green")
        else
            indicator:SetTexture("Interface\\COMMON\\Indicator-gray")
        end

        -- Nom
        local nom = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        nom:SetPoint("LEFT", indicator, "RIGHT", 5, 0)
        nom:SetText(achievement.name)

        -- Tooltip
        nom:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(achievement.description)
            GameTooltip:Show()
        end)

        nom:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)

    end

    -- Hauteur nécessaire pour le contenu
    local contentHeight = math.max(1, i * lineHeight)
    content:SetHeight(contentHeight)

    ----------------------------------------------------------------
    -- Texte en bas
    ----------------------------------------------------------------

    fa.frameAchievements.message = fa.frameAchievements:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.frameAchievements.message:SetPoint("BOTTOM", fa.frameAchievements, "BOTTOM", 0, 40)
    fa.frameAchievements.message:SetText(fa.JOKE)

    -- Ligne de séparation inférieure
    local bottomSeparator = fa.frameAchievements:CreateTexture(nil, "ARTWORK")
    bottomSeparator:SetColorTexture(1, 1, 1, 0.15)
    bottomSeparator:SetSize(270, 1)
    bottomSeparator:SetPoint("BOTTOM", fa.frameAchievements.message, "TOP", 0, 4)

    ----------------------------------------------------------------
    -- Bouton fermeture
    ----------------------------------------------------------------

    fa.closeButton = CreateFrame("Button", nil, fa.frameAchievements, "UIPanelButtonTemplate")
    fa.closeButton:SetSize(67, 25)
    fa.closeButton:SetText(fa.BTN_CLOSE)
    fa.closeButton:SetPoint("BOTTOM", fa.frameAchievements, "BOTTOM", 0, 10)

    fa.closeButton:SetScript("OnClick", function(self)
        fa.frameAchievements:Hide()
    end)

end

----------------------------
-- pop qui affiche le succès
----------------------------

function fa.afficherSucces(achievement)

    if fa.successFrame then
        fa.successFrame:Hide()
    end

    fa.successFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    fa.successFrame:SetSize(280, 150)
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
        ..achievement.name
        .."\n\n"
        ..achievement.description
        )

    fa.successFrame.elapsed = 0

    fa.successFrame:SetScript("OnUpdate", function(self, elapsed)
        self.elapsed = self.elapsed + elapsed

        if self.elapsed >= 5 then
            self:Hide()
            self:SetScript("OnUpdate", nil)
        end
    end)

    fa.successFrame:Show()

    print("|cff00ff00"..fa.ADDON_TITLE.." :|r "..fa.CSL_FEATS_OK..achievement.name)

end

------------------------
-- Validation des succès
------------------------

function fa.validationAchievements()
    for _, achievement in ipairs(fa.achievements) do
        if fa.distanceTotal * fa.taux >= achievement.distance
        and not FASaved.FeetOfAzerothDB.achievements[achievement.id] then
            FASaved.FeetOfAzerothDB.achievements[achievement.id] = true
            fa.afficherSucces(achievement)
        end
    end
end

