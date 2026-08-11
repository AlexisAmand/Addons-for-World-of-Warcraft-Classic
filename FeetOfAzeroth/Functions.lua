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

    -- bouton switch

    fa.mydButton = CreateFrame("Button", nil, fa.optionMenu, "UIPanelButtonTemplate")
    fa.mydButton:SetSize(67, 25)
    fa.mydButton:SetText("m / yd")
    fa.mydButton:SetPoint("TOPRIGHT", fa.topSeparator, "TOPRIGHT", -5, -8)
    fa.mydButton:SetScript("OnClick", fa.switchUnites)

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

    -- une zone pour les coordonnées
    fa.coordTexte = fa.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    fa.coordTexte:ClearAllPoints()
    fa.coordTexte:SetPoint("TOP", fa.frame, "TOP", 0, -40)

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

        local distanceAffichee = distance * 0.9144
        
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

----------------------------------
-- met à jour le texte du compteur
----------------------------------

function fa.updateTexte()

    if fa.nbclic == 1 then
        -- afficher le Total
        fa.piedTexte:SetText(
            string.format("Lifetime : "..fa.formatDistance(fa.distanceTotal))
        )
    elseif fa.nbclic == 2 then
        -- affichage de l'heure
        local heure = date("%H:%M:%S")
        fa.piedTexte:SetText("It's :"..heure)
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
    fa.x, fa.y, fa.instanceID = UnitPosition("player")

    -- première position : on mémorise seulement
    if not fa.ancienneX then
        fa.ancienneX = fa.x
        fa.ancienneY = fa.y
        return
    end

    -- calcul du déplacement
    local dx = fa.x - fa.ancienneX
    local dy = fa.y - fa.ancienneY

    fa.distance = math.sqrt(dx * dx + dy * dy)

    -- calculs en yards
    fa.distanceSession = fa.distanceSession + fa.distance
    fa.distanceTotal = fa.distanceTotal + fa.distance

    FASaved.FeetOfAzerothDB.distanceTotal = fa.distanceTotal

    -- la position actuelle devient l'ancienne position
    fa.ancienneX = fa.x
    fa.ancienneY = fa.y

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
    aboutFrame:SetFrameLevel(tb.frame:GetFrameLevel() + 10)

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
    else
        fa.uniteMetrique = true
    end

end


