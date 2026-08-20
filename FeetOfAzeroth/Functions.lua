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
    fa.optionTitre:SetText(fa.ADDON_TITLE.." "..fa.VERSION)

    -- ligne de séparation

    fa.topSeparator = fa.optionMenu:CreateTexture(nil, "ARTWORK")
    fa.topSeparator:SetColorTexture(1, 1, 1, 0.15)
    fa.topSeparator:SetSize(150, 1)
    fa.topSeparator:SetPoint("TOP", fa.optionTitre, "BOTTOM", 0, -4)

    -- bouton menu

    fa.menuButton = CreateFrame("Button", nil, fa.frame, "UIPanelButtonTemplate")
    fa.menuButton:SetSize(67, 25)
    fa.menuButton:SetText(fa.MAIN_OPT)
    fa.menuButton:SetPoint("BOTTOMRIGHT", fa.frame, "BOTTOMRIGHT", -7, 7)

    fa.menuButton:SetScript("OnClick", function(self)
        -- fa.frameAchievements:Hide()
        if fa.optionMenu:IsShown() then
            fa.optionMenu:Hide()
        else
            fa.optionMenu:Show()
        end
    end)

    -- bouton about

    fa.aboutButton = CreateFrame("Button", nil, fa.optionMenu, "UIPanelButtonTemplate")
    fa.aboutButton:SetSize(67, 25)
    fa.aboutButton:SetText(fa.MAIN_ABT)
    fa.aboutButton:SetPoint("TOPLEFT", fa.topSeparator, "TOPLEFT", 5, -8)
    fa.aboutButton:SetScript("OnClick", fa.showAbout)

    -- bouton reset all

    fa.resetAllButton = CreateFrame("Button", nil, fa.optionMenu, "UIPanelButtonTemplate")
    fa.resetAllButton:SetSize(67, 25)
    fa.resetAllButton:SetText(fa.MAIN_RST)
    fa.resetAllButton:SetPoint("TOPLEFT", fa.aboutButton, "TOPLEFT", 0, -28)
    fa.resetAllButton:SetScript("OnClick", function(self)
        fa.distanceSession = 0
        -- fa.distanceTotal = 0
        fa.recordVitesse = 0
    end)

    -- bouton achievements

    fa.achievementButton = CreateFrame("Button", nil, fa.optionMenu, "UIPanelButtonTemplate")
    fa.achievementButton:SetSize(67, 25)
    fa.achievementButton:SetText(fa.MAIN_FTS)
    fa.achievementButton:SetPoint("TOPLEFT", fa.resetAllButton, "TOPLEFT", 0, -28)
    fa.achievementButton:SetScript("OnClick",  fa.afficherAchievements)

    -- bouton switch

    fa.mydButton = CreateFrame("Button", nil, fa.optionMenu, "UIPanelButtonTemplate")
    fa.mydButton:SetSize(67, 25)
    fa.mydButton:SetText(fa.MAIN_CNV)
    fa.mydButton:SetPoint("TOPRIGHT", fa.topSeparator, "TOPRIGHT", -5, -8)
    fa.mydButton:SetScript("OnClick", fa.switchUnites)

    -- bouton stats

    fa.statButton = CreateFrame("Button", nil, fa.optionMenu, "UIPanelButtonTemplate")
    fa.statButton:SetSize(67, 25)
    fa.statButton:SetText(fa.MAIN_STS)
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
    fa.mainTexte = fa.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.mainTexte:ClearAllPoints()
    fa.mainTexte:SetPoint("TOP", fa.frame, "TOP", 0, -10) -- -10

    -- une zone pour la vitesse
    fa.secondTexte = fa.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.secondTexte:ClearAllPoints()
    fa.secondTexte:SetPoint("TOP", fa.frame, "TOP", 0, -29) -- -29
    fa.secondTexte:SetText(fa.MAIN_SPD)

    -- une zone pour les coordonnées
    fa.coordTexte = fa.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.coordTexte:ClearAllPoints()
    fa.coordTexte:SetPoint("TOP", fa.frame, "TOP", 0, -48) -- -48

    -- bouton toggle
    fa.toggleButton = CreateFrame("Button", nil, fa.frame, "UIPanelButtonTemplate")
    fa.toggleButton:SetSize(67, 25)
    fa.toggleButton:SetText(fa.MAIN_TGL)
    fa.toggleButton:SetPoint("BOTTOMLEFT", fa.frame, "BOTTOMLEFT", 7, 7)
    fa.toggleButton:SetScript("OnClick", fa.toggleTexte)

    fa.CreationMenu()

end

-------------------
--
-----------------

--------------------------------------
-- Conversion des secondes en hh:mm:ss
--------------------------------------

---------------------------------------------------------
-- formatage du texte avec les unités du système métrique
---------------------------------------------------------

function fa.formatDistance(distance)

    if fa.uniteMetrique then

        local distanceAffichee = distance * fa.taux
        
        if distanceAffichee < 10 then
            return string.format("%.2f m", fa.tronqueDeuxDecimales(distanceAffichee))

        elseif distanceAffichee < 100 then
            return string.format("%.2f dam", fa.tronqueDeuxDecimales(distanceAffichee / 10))

        elseif distanceAffichee < 1000 then
            return string.format("%.2f hm", fa.tronqueDeuxDecimales(distanceAffichee / 100))

        elseif distanceAffichee < 1000000 then
            return string.format("%.2f km", fa.tronqueDeuxDecimales(distanceAffichee / 1000))

        elseif distanceAffichee < 1000000000 then
            return string.format("%.2f Mm", fa.tronqueDeuxDecimales(distanceAffichee / 1000000))

        else
            return string.format("%.2f Gm", fa.tronqueDeuxDecimales(distanceAffichee / 1000000000))
        end

    else

        local distanceAffichee = distance

        if distanceAffichee < 10 then
            return string.format("%.2f yd", fa.tronqueDeuxDecimales(distanceAffichee))

        elseif distanceAffichee < 1000000 then
            return string.format("%.2f kyd", fa.tronqueDeuxDecimales(distanceAffichee / 1000))

        elseif distanceAffichee < 1000000000 then
            return string.format("%.2f Myd", fa.tronqueDeuxDecimales(distanceAffichee / 1000000))

        else
            return string.format("%.2f Gyd", fa.tronqueDeuxDecimales(distanceAffichee / 1000000000))
        end

    end

end

-----------------------------------------------
-- met à jour le texte du compteur selon toggle
-----------------------------------------------

function fa.updateTexte()

    if fa.nbclic == 1 then
        -- afficher la distance totale
        fa.mainTexte:SetText(
            string.format(fa.MAIN_LFTM..fa.formatDistance(fa.distanceTotal))
        )
        -- afficher la vitesse
        fa.secondTexte:SetText(fa.vitesseDuJoueur())
    elseif fa.nbclic == 2 then
        -- afficher la distance session
        fa.mainTexte:SetText(
            string.format(fa.MAIN_SESSION..fa.formatDistance(fa.distanceSession))
        )
        -- afficher la vitesse
        fa.secondTexte:SetText(fa.vitesseDuJoueur())      
    elseif fa.nbclic == 3 then
        -- afficher la distance session
        fa.mainTexte:SetText(
            string.format(fa.MAIN_SESSION..fa.formatDistance(fa.distanceSession))
        )
        -- afficher la distance totale
        fa.secondTexte:SetText(
            string.format(fa.MAIN_LFTM..fa.formatDistance(fa.distanceTotal))
        )  
    elseif fa.nbclic == 4 then
        -- affichage joke SW
        fa.mainTexte:SetText(fa.MAIN_HELLO)
        -- affichage de l'heure
        local heure = date("%I:%M:%S %p")
        fa.secondTexte:SetText(fa.MAIN_TM..heure)   
     else
        -- temps AFK
        fa.mainTexte:SetText(
            string.format("AFK : %s", fa.FormatTime(fa.restAFK))
        )
        -- temps DEAD
        fa.secondTexte:SetText(
            string.format("Ghost : %s", fa.FormatTime(fa.ghostTime))
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
        print("Téléportation détectée :", fa.distance, "yd")
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
    fa.timerPosition = C_Timer.NewTicker(0.1, function()
        fa.recuperationPosition()
    end)
    fa.timerAffichage = C_Timer.NewTicker(0.25, function()
        fa.afficheCoordonnees()
        fa.updateRecordVitesse()
    end)
    fa.timerTemps = C_Timer.NewTicker(1, function()
        fa.updateRestTime()
        fa.updateDeadTime()
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
            fa.MAIN_GPS.."%.2f, %.2f",
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

    local aboutFrame = CreateFrame("Frame", "FAAbout", UIParent, "BasicFrameTemplateWithInset")

    aboutFrame:SetFrameStrata("DIALOG")
    aboutFrame:SetFrameLevel(fa.frame:GetFrameLevel() + 10)

    aboutFrame:SetSize(250, 120)
    aboutFrame:SetPoint("CENTER")
    
    aboutFrame.title = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    aboutFrame.title:SetPoint("TOP", 0, -5)
    aboutFrame.title:SetText(fa.MAIN_ABT)

    aboutFrame.text = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    aboutFrame.text:SetWidth(250)
    aboutFrame.text:SetJustifyH("CENTER")
    aboutFrame.text:SetPoint("TOP", 0, -40)

    aboutFrame.text:SetText(
    fa.ADDON_TITLE.."\n"..
    fa.ABT_VERSION..fa.VERSION.."\n"..
    fa.ABT_BY..fa.AUTHOR.."\n\n"
    )

    aboutFrame:Show()

    local closeButton = CreateFrame("Button", nil, aboutFrame, "UIPanelButtonTemplate")
    closeButton:SetSize(80, 25)
    closeButton:SetPoint("BOTTOM", 0, 10)
    closeButton:SetText(fa.BTN_CLOSE)
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
        vitesse = vitesse * 3.29184 -- selon un ratio trouvé en ligne
        texte = string.format(fa.MAIN_SPD.." %.2f km/h", vitesse)
    else 
        texte = string.format(fa.MAIN_SPD.." %.2f yd/s", vitesse)
    end

    return texte
    
end

----------------------
-- affichage des stats
----------------------

-----------------------------
-- Temps d'AFK et/ou de repos
-----------------------------

function fa.updateRestTime()
    -- TODO : Compatibilité avec retail : IsPlayerAFK() ?
    if UnitIsAFK("player") then
        fa.restAFK = fa.restAFK + 0.1
        FASaved.FeetOfAzerothDB.restAFK = fa.restAFK
    end
end

-------------------------------------------
-- Temps passé en temps que mort ou fantôme
-------------------------------------------

function fa.updateDeadTime()
    -- TODO : Compatibilité avec retail  ? 
    if UnitIsDeadOrGhost("player") then
        fa.ghostTime = fa.ghostTime + 0.1
        FASaved.FeetOfAzerothDB.ghostTime = fa.ghostTime
    end
end

---------------------------------------
-- un record de vitesse est-il établi ?
---------------------------------------

function fa.updateRecordVitesse()
    local vitesse = GetUnitSpeed("player")

    if vitesse > fa.recordVitesse then
        fa.recordVitesse = vitesse
        FASaved.FeetOfAzerothDB.recordVitesse = fa.recordVitesse
        local texte = string.format("|cff00ff00" .. fa.ADDON_TITLE .. " :|r Nouveau record de vitesse : %.2f", fa.recordVitesse)
        print(texte)
    end
end
