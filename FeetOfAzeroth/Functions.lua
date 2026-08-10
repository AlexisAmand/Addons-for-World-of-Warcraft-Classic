fa = fa or {}

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
    fa.toggleButton:SetSize(75, 25)
    fa.toggleButton:SetText("Toggle")
    fa.toggleButton:SetPoint("BOTTOM", fa.frame, "BOTTOM", 0, 7)
    fa.toggleButton:SetScript("OnClick", fa.toggleTexte)
end

-- formatage du texte 

function fa.formatDistance(distance)

    local metres = distance * 0.9144

    if metres < 10 then
        return string.format("%.2f m", metres)

    elseif metres < 100 then
        return string.format("%.2f dam", metres / 10)

    elseif metres < 1000 then
        return string.format("%.2f hm", metres / 100)

    elseif metres < 1000000 then
        return string.format("%.2f km", metres / 1000)

    elseif metres < 1000000000 then
        return string.format("%.2f Mm", metres / 1000000)

    else
        return string.format("%.2f Gm", metres / 1000000000)
    end

end

-- met à jour le texte du compteur

function fa.updateTexte()

    if fa.nbclic == 1 then
        -- afficher le Total
        fa.piedTexte:SetText(
            string.format("Lifetime : "..fa.formatDistance(fa.distanceTotal))
        )
    else
        -- affichage
        fa.piedTexte:SetText(
            string.format("Session : "..fa.formatDistance(fa.distanceSession))
        )
        fa.nbclic = 0
    end  
end

-- récup position

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

-- toggle le texte

function fa.toggleTexte()
    fa.nbclic = fa.nbclic + 1
    fa.updateTexte() 
end

-- actualise la fenêtre

function fa.demarrerPodometre()
    fa.timer = C_Timer.NewTicker(0.1, function()
        fa.recuperationPosition()
        fa.afficheCoordonnees()
    end)
end 

-- gps

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

