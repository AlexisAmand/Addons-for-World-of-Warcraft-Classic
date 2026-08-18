fa = fa or {}

------------------------------------
-- Juste 2 chiffres après la virgule
------------------------------------

function fa.tronqueDeuxDecimales(nombre)
    return math.floor(nombre * 100) / 100
end

--------------------------------------
-- Conversion des secondes en hh:mm:ss
--------------------------------------

function fa.FormatTime(seconds)
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60

    if days > 0 then
        return string.format("%dj %02d:%02d:%02d", days, hours, minutes, secs)
    else
        return string.format("%02d:%02d:%02d", hours, minutes, secs)
    end
end

----------------------
-- affichage des stats
----------------------

function fa.afficherStats()

    fa.optionMenu:Hide()

    -- Création de la fenêtre

    fa.frameStats = CreateFrame("Frame", "FAWindow", UIParent)
    fa.frameStats:SetSize(300, 250)
    fa.frameStats:SetPoint("CENTER")

    -- On rend la fenêtre déplaçable
    fa.frameStats:SetMovable(true)
    fa.frameStats:EnableMouse(true)
    fa.frameStats:RegisterForDrag("LeftButton")

    fa.frameStats:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)

    fa.frameStats:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)

    -- Fond

    fa.frameStats.bg = fa.frameStats:CreateTexture(nil, "BACKGROUND")
    fa.frameStats.bg:SetAllPoints()
    fa.frameStats.bg:SetColorTexture(0, 0, 0, 0.7)

    -- Bordure

    fa.frameStats.border = CreateFrame("Frame", nil, fa.frameStats, "BackdropTemplate")
    fa.frameStats.border:SetAllPoints()
    fa.frameStats.border:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
    })

    -- Titre de la fenêtre

    fa.frameStats.titre = fa.frameStats:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    fa.frameStats.titre:ClearAllPoints()
    fa.frameStats.titre:SetPoint("TOP", fa.frameStats, "TOP", 0, -10)
    fa.frameStats.titre:SetText(fa.MAIN_STS)

    -- ligne de séparation

    fa.frameStatsSeparator = fa.frameStats:CreateTexture(nil, "ARTWORK")
    fa.frameStatsSeparator:SetColorTexture(1, 1, 1, 0.15)
    fa.frameStatsSeparator:SetSize(270, 1)
    fa.frameStatsSeparator:SetPoint("TOP", fa.frameStats.titre, "BOTTOM", 0, -4)

    -- Distance totale (en Yards)

    fa.frameStats.distanceYd = fa.frameStats:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.frameStats.distanceYd:SetPoint("TOPLEFT", fa.frameStatsSeparator, "TOPLEFT", 10, -12)
    local texte = string.format(fa.STAT_DIST_TOT.."%.2f yds", fa.tronqueDeuxDecimales(fa.distanceTotal))
    fa.frameStats.distanceYd:SetText(texte)

    -- Distance totale (en m)

    fa.frameStats.distanceM = fa.frameStats:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.frameStats.distanceM:SetPoint("TOPLEFT", fa.frameStatsSeparator, "TOPLEFT", 10, -27)
    local texte = string.format(fa.STAT_DIST_TOT.."%.2f m", fa.tronqueDeuxDecimales(fa.distanceTotal * fa.taux))
    fa.frameStats.distanceM:SetText(texte)

    -- Distance session (en Yards)

    fa.frameStats.sessionYd = fa.frameStats:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.frameStats.sessionYd:SetPoint("TOPLEFT", fa.frameStatsSeparator, "TOPLEFT", 10, -52)
    local texte = string.format(fa.STAT_DIST_SESS.."%.2f yds", fa.tronqueDeuxDecimales(fa.distanceSession))
    fa.frameStats.sessionYd:SetText(texte)

    -- Distance session (en m)

    fa.frameStats.sessionM = fa.frameStats:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.frameStats.sessionM:SetPoint("TOPLEFT", fa.frameStatsSeparator, "TOPLEFT",10 , -67)
    local texte = string.format(fa.STAT_DIST_SESS.."%.2f m", fa.tronqueDeuxDecimales(fa.distanceSession * fa.taux))
    fa.frameStats.sessionM:SetText(texte)

    -- Temps AFK

    fa.frameStats.afkText = fa.frameStats:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.frameStats.afkText:SetPoint("TOPLEFT", fa.frameStatsSeparator, "TOPLEFT", 10, -92)
    -- local texte = string.format(fa.STAT_DIST_TOT.."%.2f m", fa.fa.tronqueDeuxDecimales(fa.distanceTotal * fa.taux))
    fa.frameStats.afkText:SetText("AFK : "..fa.FormatTime(fa.restAFK).." test")

    -- Temps Ghost

    fa.frameStats.deadText = fa.frameStats:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.frameStats.deadText:SetPoint("TOPLEFT", fa.frameStatsSeparator, "TOPLEFT", 10, -107)
    -- local texte = string.format(fa.STAT_DIST_TOT.."%.2f m", fa.fa.tronqueDeuxDecimales(fa.distanceTotal * fa.taux))
    fa.frameStats.deadText:SetText("Ghost : "..fa.FormatTime(fa.ghostTime).." test")

    -- Texte en bas

    fa.frameStats.message = fa.frameStats:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.frameStats.message:SetPoint("BOTTOM", 0, 40)
    fa.frameStats.message:SetText(fa.STAT_PH)

    -- ligne de séparation

    fa.frameStatsSeparator = fa.frameStats:CreateTexture(nil, "ARTWORK")
    fa.frameStatsSeparator:SetColorTexture(1, 1, 1, 0.15)
    fa.frameStatsSeparator:SetSize(270, 1)
    fa.frameStatsSeparator:SetPoint("BOTTOM", fa.frameStats.message, "TOP", 0, 4)

    -- Bouton fermeture

    fa.closeButton = CreateFrame("Button", nil, fa.frameStats, "UIPanelButtonTemplate")
    fa.closeButton:SetSize(67, 25)
    fa.closeButton:SetText(fa.BTN_CLOSE)
    fa.closeButton:SetPoint("BOTTOM", fa.frameStats, "BOTTOM", 0, 10)
    fa.closeButton:SetScript("OnClick", function(self)
        fa.frameStats:Hide()
    end)
end