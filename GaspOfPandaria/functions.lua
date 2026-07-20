Gasp = {}

-- Variables du jeu

Gasp.version = "v0.11"
Gasp.grille = {}
Gasp.boutons = {}
Gasp.nbCoups = 0
Gasp.frame = nilff
Gasp.record = nil

-- Gasp.niveau = 3 -- on fait -1 car le tableau à zéro 
-- Gasp.taille = 60 -- taille des gemmes

Gasp.niveau = 3
Gasp.taille = 55

-- création de la grille de jeu

function Gasp.CreerGrille()
    for y = 0, Gasp.niveau do
        Gasp.grille[y] = {}
        for x = 0, Gasp.niveau do
            Gasp.grille[y][x] = 0
        end
    end
end

-- Fonction pour mettre à jour la couleur d'un pion

function Gasp.UpdateButton(x, y)

    local button = Gasp.boutons[y][x]

    -- Choix de la texture selon l'état
    if Gasp.grille[y][x] == 0 then
        button:SetNormalTexture("Interface\\AddOns\\GaspOfPandaria\\images\\gem_blue.tga")
    else
        button:SetNormalTexture("Interface\\AddOns\\GaspOfPandaria\\images\\gem_green.tga")
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

-- On vérifie si le joueur a gagné !

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
    StaticPopup_Show("GASP_VICTOIRE")

    if Gasp.record == 0 or Gasp.nbCoups < Gasp.record then
        Gasp.record = Gasp.nbCoups
        GaspSaved.record = Gasp.record
    end

    Gasp.frame.coups:SetText("Moves : "..Gasp.nbCoups.."   Record : "..Gasp.record)
    
end

-- On retourne un bouton ! 

function Gasp.Retourne(xc, yc)
    -- Joue un son
    PlaySoundFile("Interface\\AddOns\\GaspOfPandaria\\sounds\\Bottle-7.wav")

    -- Incrémente le compteur de coups
    Gasp.nbCoups = Gasp.nbCoups + 1
    Gasp.frame.coups:SetText("Moves : "..Gasp.nbCoups.."   Record : "..Gasp.GetRecordText())

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

    -- Vérifie la victoire
    Gasp.VerificationGrille()
end

-- Fonction pour basculer la couleur d'un pion

function Gasp.ToggleColor(x, y)
    Gasp.grille[y][x] = 1 - Gasp.grille[y][x] -- inverse 0 ↔ 1
    Gasp.UpdateButton(x, y)
end

-- record

function Gasp.GetRecordText()
    if Gasp.record == nil then
        return "-"
    else
        return Gasp.record
    end
end

-- création des boutons 

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

            -- Texture Gust (flash blanc)
            local gust = button:CreateTexture(nil, "OVERLAY")
            gust:SetAllPoints()
            gust:SetColorTexture(1, 1, 1, 0) -- invisible au repos
            button.gust = gust

            -- Animation Gust
            local ag = gust:CreateAnimationGroup()

            local fadeIn = ag:CreateAnimation("Alpha")
            fadeIn:SetFromAlpha(0)
            fadeIn:SetToAlpha(0.4)
            fadeIn:SetDuration(0.1)

            local fadeOut = ag:CreateAnimation("Alpha")
            fadeOut:SetFromAlpha(0.4)
            fadeOut:SetToAlpha(0)
            fadeOut:SetDuration(0.1)

            button.gustAnim = ag


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

function Gasp.EffetGust()
    for y = 0, Gasp.niveau do
        for x = 0, Gasp.niveau do
            local btn = Gasp.boutons[y][x]
            if btn and btn.gustAnim then
                btn.gustAnim:Play()
            end
        end
    end
end


-- fonction qui mélange !

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

