Gasp = {}

-- Variables du jeu

Gasp.grille = {}
Gasp.boutons = {}
Gasp.nbCoups = 0
Gasp.frame = nil
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

    PlaySound(567399) -- petit son de victoire
end

-- On retourne un bouton ! 

function Gasp.Retourne(xc, yc)
    -- Joue un son (facultatif)
    PlaySound(567482) -- son générique WoW

    -- Incrémente le compteur de coups
    Gasp.nbCoups = Gasp.nbCoups + 1
    Gasp.frame.coups:SetText("Moves : "..Gasp.nbCoups.."   Record : "..Gasp.GetRecordText())

    -- Parcourt les voisins autour du pion cliqué
    for y = yc - 1, yc + 1 do
        for x = xc - 1, xc + 1 do
            -- Vérifie que la case existe dans la grille
            if x >= 0 and x <= 3 and y >= 0 and y <= 3 then
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