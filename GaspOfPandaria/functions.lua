Gasp = {}

-------------------
-- Variables du jeu
-------------------

Gasp.version = "v0.12"
Gasp.grille = {}
Gasp.boutons = {}
Gasp.nbCoups = 0
Gasp.frame = nil
Gasp.record = nil
Gasp.niveau = 3
Gasp.niveauText = nil
Gasp.taille = 55

Gasp.textures = {
    [1] = {
        recto = "Interface\\AddOns\\GaspOfPandaria\\images\\gem_blue.tga",
        verso = "Interface\\AddOns\\GaspOfPandaria\\images\\gem_green.tga",
    },
    [2] = {
        recto = "Interface\\AddOns\\GaspOfPandaria\\images\\gem_red.tga",
        verso = "Interface\\AddOns\\GaspOfPandaria\\images\\gem_yellow.tga",
    },
    [3] = {
        recto = "Interface\\AddOns\\GaspOfPandaria\\images\\gem_purple.tga",
        verso = "Interface\\AddOns\\GaspOfPandaria\\images\\gem_orange.tga",
    },
}

-------------------------------
-- création de la grille de jeu
-------------------------------

function Gasp.CreerGrille()

    -- grille logique
    for y = 0, Gasp.niveau do
        Gasp.grille[y] = {}
        for x = 0, Gasp.niveau do
            Gasp.grille[y][x] = 0
        end
    end
    
end

---------------------------------------------------
-- Fonction pour mettre à jour la couleur d'un pion
---------------------------------------------------

function Gasp.UpdateButton(x, y)

    local button = Gasp.boutons[y][x]

    -- Choix de la texture selon l'état
    --if Gasp.grille[y][x] == 0 then
    --    button:SetNormalTexture("Interface\\AddOns\\GaspOfPandaria\\images\\gem_blue.tga")
    --else
    --    button:SetNormalTexture("Interface\\AddOns\\GaspOfPandaria\\images\\gem_green.tga")
    --end

    local levelId = math.floor(Gasp.niveau / 2)
    local tex = Gasp.textures[levelId]

    if Gasp.grille[y][x] == 0 then
        button:SetNormalTexture(tex.recto)
    else
        button:SetNormalTexture(tex.verso)
    end

    -- Animation fade-in / fade-out
    if not button.fadeAnim then
        local fade = button:CreateAnimationGroup()

        local a1 = fade:CreateAnimation("Alpha")
        a1:SetFromAlpha(1)
        a1:SetToAlpha(0.3)
        a1:SetDuration(0.05)
        a1:SetSmoothing("OUT")

        local a2 = fade:CreateAnimation("Alpha")
        a2:SetFromAlpha(0.3)
        a2:SetToAlpha(1)
        a2:SetDuration(0.05)
        a2:SetSmoothing("IN")

        button.fadeAnim = fade
    end

    button.fadeAnim:Play()
end

------------------------------------
-- On vérifie si le joueur a gagné !
------------------------------------

function Gasp.VerificationGrille()
    -- local couleur = Gasp.grille[0][0]
    for y = 0, Gasp.niveau do
        for x = 0, Gasp.niveau do
            if Gasp.grille[y][x] ~= 1 then
                return -- pas encore gagné
            end
        end
    end

    -- appel de la popup de victoire

    if Gasp.record == 0 or Gasp.nbCoups < Gasp.record then
        nouveauRecord = true
        Gasp.record = Gasp.nbCoups
        GaspSaved.records[math.floor(Gasp.niveau/2)] = Gasp.record
    end

    -- popup

    if nouveauRecord then
        StaticPopupDialogs["NEW_RECORD"].text = "Victory !\n\nOne gem moved, one lesson learned.\nNew record in "
        .. Gasp.GetRecordText() .. " moves."
        StaticPopup_Show("NEW_RECORD")
        GaspSaved.grille = nil
        GaspSaved.nbCoups = nil
    else 
        StaticPopup_Show("GASP_VICTOIRE")
        GaspSaved.grille = nil
        GaspSaved.nbCoups = nil
    end

    -- affichage
    Gasp.frame.coups:SetText("Moves : 0  Wisdom of level "..math.floor(Gasp.niveau/2).." : "..Gasp.GetRecordText())

    -- reset de la grille
    Gasp.CreerGrille()

    -- rafraîchir les boutons :
    for y = 0, Gasp.niveau do
        for x = 0, Gasp.niveau do
            Gasp.UpdateButton(x, y)
        end
    end

    -- reset du nombre de coups
    Gasp.nbCoups = 0 
  
end

--------------------------
-- On retourne un bouton ! 
--------------------------

function Gasp.Retourne(xc, yc)
    -- Joue un son
    PlaySoundFile("Interface\\AddOns\\GaspOfPandaria\\sounds\\Bottle-7.wav")

    -- Incrémente le compteur de coups
    Gasp.nbCoups = Gasp.nbCoups + 1
    Gasp.frame.coups:SetText("Moves : "..Gasp.nbCoups.."  Wisdom of level "..math.floor(Gasp.niveau/2).." : "..Gasp.GetRecordText())

    -- Parcourt les voisins autour du pion cliqué
    for y = yc - 1, yc + 1 do
        for x = xc - 1, xc + 1 do
            -- Vérifie que la case existe dans la grille
            if x >= 0 and x <= Gasp.niveau and y >= 0 and y <= Gasp.niveau then
                -- Ne pas changer la case cliquée elle-même
                if not (x == xc and y == yc) then
                    Gasp.grille[y][x] = 1 - Gasp.grille[y][x]
                    Gasp.UpdateButton(x, y)
                end
            end
        end
    end

    -- Sauvegarde de la grille
    GaspSaved.grille = {}

    for y = 0, Gasp.niveau do
        GaspSaved.grille[y] = {}
        for x = 0, Gasp.niveau do
            GaspSaved.grille[y][x] = Gasp.grille[y][x]
        end
    end

    -- Sauvegarde du nombre de coups
    GaspSaved.nbCoups = Gasp.nbCoups

    -- Vérifie la victoire
    Gasp.VerificationGrille()
end

----------------------------------------------
-- Fonction pour basculer la couleur d'un pion
-- (à supprimer ?)
----------------------------------------------

function Gasp.ToggleColor(x, y)
    Gasp.grille[y][x] = 1 - Gasp.grille[y][x] -- inverse 0 ↔ 1
    Gasp.UpdateButton(x, y)
end

--------------------------------------
-- Récupération de la valeur du record
--------------------------------------

function Gasp.GetRecordText()
    return GaspSaved.records[math.floor(Gasp.niveau/2)] or "-"
end

-----------------------
-- création des boutons 
-----------------------

function Gasp.CreationDesBoutons(gridFrame, espace)

    -- Si des boutons existent déjà, on les cache
    if Gasp.boutons then
        for y, ligne in pairs(Gasp.boutons) do
            for x, btn in pairs(ligne) do
                btn:Hide()
            end
        end
    end

    for y = 0, Gasp.niveau do
        Gasp.boutons[y] = {}
        for x = 0, Gasp.niveau do
            local button = CreateFrame("Button", "GaspPion"..x..y, gridFrame)
           
            button:SetSize(Gasp.taille, Gasp.taille)
            local offsetX = (gridFrame:GetWidth() - (Gasp.niveau + 1) * (Gasp.taille + espace)) / 2
            local offsetY = -((gridFrame:GetHeight() - (Gasp.niveau + 1) * (Gasp.taille + espace)) / 2)
            button:SetPoint("TOPLEFT", offsetX + x * (Gasp.taille + espace), offsetY - y * (Gasp.taille + espace))

            button:SetNormalTexture("Interface\\AddOns\\GaspOfPandaria\\images\\gem_blue.tga")

            -- capture locale des coordonnées
            -- local bx, by = x, y
            button:SetScript("OnClick", function()
                Gasp.Retourne(x, y)
            end)

            Gasp.boutons[y][x] = button
            print("plop")
            C_Timer.After(1, function() end)
        end
    end
end

---------------------------------
-- fonction qui mélange la grille
---------------------------------

function Gasp.melangerGrille()
    local flat = {}

    -- On aplatit la grille
    for y = 0, Gasp.niveau do
        for x = 0, Gasp.niveau do
            table.insert(flat, Gasp.grille[y][x])
        end
    end

    -- Fisher-Yates sur la liste plate
    for i = #flat, 2, -1 do
        local j = math.random(i)
        flat[i], flat[j] = flat[j], flat[i]
    end

    -- On remet dans la grille
    local index = 1
    for y = 0, Gasp.niveau do
        for x = 0, Gasp.niveau do
            Gasp.grille[y][x] = flat[index]
            index = index + 1
        end
    end

    -- Mise à jour des boutons
    for y = 0, Gasp.niveau do
        for x = 0, Gasp.niveau do
            Gasp.UpdateButton(x, y)
        end
    end
end

