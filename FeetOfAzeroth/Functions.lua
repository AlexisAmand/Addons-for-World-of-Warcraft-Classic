fa = fa or {}

-------------------
-- Menu des options
-------------------

function fa.CreationMenu()

    fa.optionMenu = CreateFrame("Frame", nil, fa.frame, "BackdropTemplate")
    fa.optionMenu:SetSize(180, 135) 

    fa.optionMenu.bg = fa.optionMenu:CreateTexture(nil, "BACKGROUND")
    fa.optionMenu.bg:SetAllPoints()
    fa.optionMenu.bg:SetColorTexture(0, 0, 0, 0.7)

    fa.optionMenu.border = CreateFrame("Frame", nil, fa.optionMenu, "BackdropTemplate")
    fa.optionMenu.border:SetAllPoints()
    fa.optionMenu.border:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
    })

    -- une zone pour le titre dans le menu des options
    fa.optionTitre = fa.optionMenu:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.optionTitre:ClearAllPoints()
    fa.optionTitre:SetPoint("TOP", fa.optionMenu, "TOP", 0, -10)
    fa.optionTitre:SetText("Feet Of Azeroth "..fa.VERSION)

    -- ligne de séparation

    fa.topSeparator = fa.optionMenu:CreateTexture(nil, "ARTWORK")
    fa.topSeparator:SetColorTexture(1, 1, 1, 0.15)
    fa.topSeparator:SetSize(150, 1)
    fa.topSeparator:SetPoint("TOP", fa.optionTitre, "BOTTOM", 0, -4)

    -- bouton menu

    fa.menuButton = CreateFrame("Button", nil, fa.frame, "UIPanelButtonTemplate")
    fa.menuButton:SetSize(67, 25)
    fa.menuButton:SetText("Menu")
    fa.menuButton:SetPoint("BOTTOMRIGHT", fa.frame, "BOTTOMRIGHT", -7, 7)

    fa.menuButton:SetScript("OnClick", function(self)
        if fa.optionMenu:IsShown() then
            fa.optionMenu:Hide()
        else
            fa.optionMenu:Show()
        end
    end)

    -- bouton about

    fa.aboutButton = CreateFrame("Button", nil, fa.optionMenu, "UIPanelButtonTemplate")
    fa.aboutButton:SetSize(67, 25)
    fa.aboutButton:SetText("About")
    fa.aboutButton:SetPoint("TOPLEFT", fa.topSeparator, "TOPLEFT", 5, -8)
    fa.aboutButton:SetScript("OnClick", fa.showAbout)

    -- bouton reset all

    fa.resetAllButton = CreateFrame("Button", nil, fa.optionMenu, "UIPanelButtonTemplate")
    fa.resetAllButton:SetSize(67, 25)
    fa.resetAllButton:SetText("Reset All")
    fa.resetAllButton:SetPoint("TOPLEFT", fa.aboutButton, "TOPLEFT", 0, -28)
    fa.resetAllButton:SetScript("OnClick", function(self)
        fa.distanceSession = 0
        fa.distanceTotal = 0
    end)

    -- bouton achievements

    fa.achievementButton = CreateFrame("Button", nil, fa.optionMenu, "UIPanelButtonTemplate")
    fa.achievementButton:SetSize(67, 25)
    fa.achievementButton:SetText("Feats")
    fa.achievementButton:SetPoint("TOPLEFT", fa.resetAllButton, "TOPLEFT", 0, -28)
    fa.achievementButton:SetScript("OnClick",  fa.afficherAchievements)

    -- bouton switch

    fa.mydButton = CreateFrame("Button", nil, fa.optionMenu, "UIPanelButtonTemplate")
    fa.mydButton:SetSize(67, 25)
    fa.mydButton:SetText("m / yd")
    fa.mydButton:SetPoint("TOPRIGHT", fa.topSeparator, "TOPRIGHT", -5, -8)
    fa.mydButton:SetScript("OnClick", fa.switchUnites)

    -- bouton stats

    fa.statButton = CreateFrame("Button", nil, fa.optionMenu, "UIPanelButtonTemplate")
    fa.statButton:SetSize(67, 25)
    fa.statButton:SetText("Stats")
    fa.statButton:SetPoint("TOPRIGHT", fa.mydButton, "TOPRIGHT", 0, -28)
    fa.statButton:SetScript("OnClick", fa.afficherStats)

    -- Position du menu 
    fa.optionMenu:SetPoint("TOP", fa.menuButton, "BOTTOM", 0, -10)

    -- Le menu est caché au démarrage 
    fa.optionMenu:Hide()
end

-------------------------
-- création de la fenêtre
-------------------------

function fa.creationFenetre()
    fa.frame = CreateFrame("Frame", "FAWindow", UIParent)
    fa.frame:SetSize(150, 100)
    fa.frame:SetPoint("CENTER")

    fa.frame.bg = fa.frame:CreateTexture(nil, "BACKGROUND")
    fa.frame.bg:SetAllPoints()
    fa.frame.bg:SetColorTexture(0, 0, 0, 0.7)

    fa.frame.border = CreateFrame("Frame", nil, fa.frame, "BackdropTemplate")
    fa.frame.border:SetAllPoints()
    fa.frame.border:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
    })

    -- On rend la fenêtre déplaçable
    fa.frame:SetMovable(true)
    fa.frame:EnableMouse(true)
    fa.frame:RegisterForDrag("LeftButton")

    fa.frame:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)

    fa.frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)

    -- une zone pour le texte
    fa.piedTexte = fa.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.piedTexte:ClearAllPoints()
    fa.piedTexte:SetPoint("TOP", fa.frame, "TOP", 0, -10)

    -- une zone pour la vitesse
    fa.vitesseTexte = fa.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.vitesseTexte:ClearAllPoints()
    fa.vitesseTexte:SetPoint("TOP", fa.frame, "TOP", 0, -29)
    fa.vitesseTexte:SetText("Vitesse")

    -- une zone pour les coordonnées
    fa.coordTexte = fa.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.coordTexte:ClearAllPoints()
    fa.coordTexte:SetPoint("TOP", fa.frame, "TOP", 0, -48)

    -- bouton toggle
    fa.toggleButton = CreateFrame("Button", nil, fa.frame, "UIPanelButtonTemplate")
    fa.toggleButton:SetSize(67, 25)
    fa.toggleButton:SetText("Toggle")
    fa.toggleButton:SetPoint("BOTTOMLEFT", fa.frame, "BOTTOMLEFT", 7, 7)
    fa.toggleButton:SetScript("OnClick", fa.toggleTexte)

    fa.CreationMenu()

end

-------------------
--
-----------------

local function tronqueDeuxDecimales(nombre)
    return math.floor(nombre * 100) / 100
end

---------------------------------------------------------
-- formatage du texte avec les unités du système métrique
---------------------------------------------------------

function fa.formatDistance(distance)

    if fa.uniteMetrique then

        local distanceAffichee = distance * fa.taux
        
        if distanceAffichee < 10 then
            return string.format("%.2f m", tronqueDeuxDecimales(distanceAffichee))

        elseif distanceAffichee < 100 then
            return string.format("%.2f dam", tronqueDeuxDecimales(distanceAffichee / 10))

        elseif distanceAffichee < 1000 then
            return string.format("%.2f hm", tronqueDeuxDecimales(distanceAffichee / 100))

        elseif distanceAffichee < 1000000 then
            return string.format("%.2f km", tronqueDeuxDecimales(distanceAffichee / 1000))

        elseif distanceAffichee < 1000000000 then
            return string.format("%.2f Mm", tronqueDeuxDecimales(distanceAffichee / 1000000))

        else
            return string.format("%.2f Gm", tronqueDeuxDecimales(distanceAffichee / 1000000000))
        end

    else

        local distanceAffichee = distance

        if distanceAffichee < 10 then
            return string.format("%.2f yd", tronqueDeuxDecimales(distanceAffichee))

        elseif distanceAffichee < 1000000 then
            return string.format("%.2f kyd", tronqueDeuxDecimales(distanceAffichee / 1000))

        elseif distanceAffichee < 1000000000 then
            return string.format("%.2f Myd", tronqueDeuxDecimales(distanceAffichee / 1000000))

        else
            return string.format("%.2f Gyd", tronqueDeuxDecimales(distanceAffichee / 1000000000))
        end

    end

end

-----------------------------------------------
-- met à jour le texte du compteur selon toggle
-----------------------------------------------

function fa.updateTexte()

    if fa.nbclic == 1 then
        -- afficher le Total
        fa.piedTexte:SetText(
            string.format("Lifetime : "..fa.formatDistance(fa.distanceTotal))
        )
    elseif fa.nbclic == 2 then
        -- affichage de l'heure
        local heure = date("%I:%M:%S %p")
        fa.piedTexte:SetText("It's : "..heure)
    elseif fa.nbclic == 3 then
        -- affichage de l'heure
        fa.piedTexte:SetText("Hello there !")
    else
        -- affichage de le session
        fa.piedTexte:SetText(
            string.format("Session : "..fa.formatDistance(fa.distanceSession))
        )
        fa.nbclic = 0
    end  
end

---------------------------------
-- récup de la position du joueur
---------------------------------

function fa.recuperationPosition()

    -- récupération de la position du joueur
    fa.x, fa.y, fa.z, fa.instanceID = UnitPosition("player")

    -- coordonnées temporairement indisponibles
    if not fa.x or not fa.y or not fa.z then
        fa.ancienneX = nil
        fa.ancienneY = nil
        fa.ancienneZ = nil
        return
    end

    -- première position : on mémorise seulement
    if not fa.ancienneX then
        fa.ancienneX = fa.x
        fa.ancienneY = fa.y
        fa.ancienneZ = fa.z
        return
    end

    -- calcul du déplacement
    local dx = fa.x - fa.ancienneX
    local dy = fa.y - fa.ancienneY
    local dz = fa.z - fa.ancienneZ

    fa.distance = math.sqrt(dx * dx + dy * dy + dz * dz)

    -- C'est une téléportation (test)
    local vitesse = GetUnitSpeed("player")

    if vitesse > 0 and fa.distance > vitesse * 0.1 * 2 then
        fa.distance = 0
        print("|cff00ff00"..fa.ADDON_TITLE.." :|r téléportation détectée !")
    end

    -- calculs en yards
    fa.distanceSession = fa.distanceSession + fa.distance
    fa.distanceTotal = fa.distanceTotal + fa.distance

    fa.validationAchievements()

    FASaved.FeetOfAzerothDB.distanceTotal = fa.distanceTotal

    -- la position actuelle devient l'ancienne position
    fa.ancienneX = fa.x
    fa.ancienneY = fa.y
    fa.ancienneZ = fa.z 

    fa.updateTexte()

end

----------------------------------
-- fonctionnement du bouton toggle
----------------------------------

function fa.toggleTexte()
    fa.nbclic = fa.nbclic + 1
    fa.updateTexte() 
end

--------------------------------------
-- actualise les infos dans la fenêtre
--------------------------------------

function fa.demarrerPodometre()
    fa.timer = C_Timer.NewTicker(0.1, function()
        fa.recuperationPosition()
        fa.afficheCoordonnees()
        fa.vitesseDuJoueur()
    end)
end 

---------------------------------------
-- affichage des coordonnées du joueurs
---------------------------------------

function fa.afficheCoordonnees()

    -- récup carte

    local mapID = C_Map.GetBestMapForUnit("player")

    if not mapID then
        return
    end

    -- récup position du joueur

    local position = C_Map.GetPlayerMapPosition(mapID, "player")

    if position then
        local a, b = position:GetXY()

        local texte = string.format(
            "GPS : %.2f, %.2f",
            a * 100,
            b * 100
        )

        -- mis à jour champ 

        fa.coordTexte:SetText(texte)
    end
end

----------------
-- fenêtre about
----------------

function fa.showAbout()

    fa.optionMenu:Hide()

    local aboutFrame = CreateFrame("Frame", "TNAbout", UIParent, "BasicFrameTemplateWithInset")

    aboutFrame:SetFrameStrata("DIALOG")
    aboutFrame:SetFrameLevel(fa.frame:GetFrameLevel() + 10)

    aboutFrame:SetSize(250, 120)
    aboutFrame:SetPoint("CENTER")
    
    aboutFrame.title = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    aboutFrame.title:SetPoint("TOP", 0, -5)
    aboutFrame.title:SetText("About")

    aboutFrame.text = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    aboutFrame.text:SetWidth(250)
    aboutFrame.text:SetJustifyH("CENTER")
    aboutFrame.text:SetPoint("TOP", 0, -40)

    aboutFrame.text:SetText(
    fa.ADDON_TITLE.."\n"..
    "Version "..fa.VERSION.."\n"..
    "By "..fa.AUTHOR.."\n\n"
    )

    aboutFrame:Show()

    local closeButton = CreateFrame("Button", nil, aboutFrame, "UIPanelButtonTemplate")
    closeButton:SetSize(80, 25)
    closeButton:SetPoint("BOTTOM", 0, 10)
    closeButton:SetText("close")
    closeButton:SetScript("OnClick", function()
        aboutFrame:Hide()
    end)

end

-------------------------------------
-- fonction qui switche entre yd et m
-------------------------------------

function  fa.switchUnites()

    if fa.uniteMetrique == true then
        fa.uniteMetrique = false 
        FASaved.FeetOfAzerothDB.uniteMetrique = false
    else
        fa.uniteMetrique = true
        FASaved.FeetOfAzerothDB.uniteMetrique = true
    end
    fa.optionMenu:Hide()
end

------------------------------------
-- affichage de la vitesse du joueur
------------------------------------

function  fa.vitesseDuJoueur()

    local vitesse = GetUnitSpeed("player")
    local texte

    if fa.uniteMetrique == true then 
        vitesse = vitesse * 3,29184 -- selon un ratio trouvé en ligne
        texte = string.format("Vitesse %.2f km/h", vitesse)
    else 
        texte = string.format("Vitesse %.2f yd/s", vitesse)
    end

    fa.vitesseTexte:SetText(texte)

end

----------------------
-- affichage des stats
----------------------

function fa.afficherStats()

    fa.optionMenu:Hide()

    -- fenêtre

    fa.frameStats = CreateFrame("Frame", "FAWindow", UIParent)
    fa.frameStats:SetSize(300, 250)
    fa.frameStats:SetPoint("CENTER")

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

    -- Titre

    fa.frameStats.titre = fa.frameStats:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    fa.frameStats.titre:ClearAllPoints()
    fa.frameStats.titre:SetPoint("TOP", fa.frameStats, "TOP", 0, -10)
    fa.frameStats.titre:SetText("Stats")

    -- ligne de séparation

    fa.frameStatsSeparator = fa.frameStats:CreateTexture(nil, "ARTWORK")
    fa.frameStatsSeparator:SetColorTexture(1, 1, 1, 0.15)
    fa.frameStatsSeparator:SetSize(270, 1)
    fa.frameStatsSeparator:SetPoint("TOP", fa.frameStats.titre, "BOTTOM", 0, -4)

    -- Distance totale (en Yards)

    fa.frameStats.distanceYd = fa.frameStats:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.frameStats.distanceYd:SetPoint("TOPLEFT", fa.frameStatsSeparator, "TOPLEFT", 10, -12)
    local texte = string.format("Distance Totale : %.2f yds", tronqueDeuxDecimales(fa.distanceTotal))
    fa.frameStats.distanceYd:SetText(texte)

    -- Distance totale (en m)

    fa.frameStats.distanceM = fa.frameStats:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.frameStats.distanceM:SetPoint("TOPLEFT", fa.frameStatsSeparator, "TOPLEFT", 10, -27)
    local texte = string.format("Distance Totale : %.2f m", tronqueDeuxDecimales(fa.distanceTotal * fa.taux))
    fa.frameStats.distanceM:SetText(texte)

    -- Distance session (en Yards)

    fa.frameStats.sessionYd = fa.frameStats:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.frameStats.sessionYd:SetPoint("TOPLEFT", fa.frameStatsSeparator, "TOPLEFT", 10, -52)
    local texte = string.format("Distance Session : %.2f yds", tronqueDeuxDecimales(fa.distanceSession))
    fa.frameStats.sessionYd:SetText(texte)

    -- Distance session (en m)

    fa.frameStats.sessionM = fa.frameStats:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.frameStats.sessionM:SetPoint("TOPLEFT", fa.frameStatsSeparator, "TOPLEFT",10 , -67)
    local texte = string.format("Distance Session : %.2f m", tronqueDeuxDecimales(fa.distanceSession * fa.taux))
    fa.frameStats.sessionM:SetText(texte)

    -- Texte en bas

    fa.frameStats.message = fa.frameStats:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.frameStats.message:SetPoint("BOTTOM", 0, 40)
    fa.frameStats.message:SetText("Noodle soup & naps keep you healthy !")

    -- ligne de séparation

    fa.frameStatsSeparator = fa.frameStats:CreateTexture(nil, "ARTWORK")
    fa.frameStatsSeparator:SetColorTexture(1, 1, 1, 0.15)
    fa.frameStatsSeparator:SetSize(270, 1)
    fa.frameStatsSeparator:SetPoint("BOTTOM", fa.frameStats.message, "TOP", 0, 4)

    -- Bouton fermeture

    fa.closeButton = CreateFrame("Button", nil, fa.frameStats, "UIPanelButtonTemplate")
    fa.closeButton:SetSize(67, 25)
    fa.closeButton:SetText("Close")
    fa.closeButton:SetPoint("BOTTOM", fa.frameStats, "BOTTOM", 0, 10)
    fa.closeButton:SetScript("OnClick", function(self)
        fa.frameStats:Hide()
    end)
end
