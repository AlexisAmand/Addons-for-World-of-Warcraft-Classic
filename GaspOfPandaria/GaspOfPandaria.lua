print("Gasp chargé !")
local nbCoups = 0

-- Tableau logique 4x4

local grille = {}
for y = 0, 3 do
    grille[y] = {}
    for x = 0, 3 do
        grille[y][x] = 0 -- 0 = blanc, 1 = noir
    end
end

-- Tableau pour stocker les boutons

local boutons = {}

-- Fonction pour mettre à jour la couleur d'un pion

local function UpdateButton(x, y)
    local button = boutons[y][x]
    if grille[y][x] == 0 then
        button:SetNormalTexture("Interface\\AddOns\\GaspOfPandaria\\images\\gem_blue.tga")
    else
        button:SetNormalTexture("Interface\\AddOns\\GaspOfPandaria\\images\\gem_green.tga")
    end
end

-- On vérifie si le joueur a gagné !

local function VerificationGrille()
    local couleur = grille[0][0]
    for y = 0, 3 do
        for x = 0, 3 do
            if grille[y][x] ~= couleur then
                return -- pas encore gagné
            end
        end
    end
    print("Bravo ! Toutes les gemmes sont de la même couleur !")
    PlaySound(567399) -- petit son de victoire
end

-- On retourne un bouton ! 

local function Retourne(xc, yc)
    -- Joue un son (facultatif)
    PlaySound(567482) -- son générique WoW

    -- Incrémente le compteur de coups
    nbCoups = nbCoups + 1
    print("Coup n°"..nbCoups)

    -- Parcourt les voisins autour du pion cliqué
    for y = yc - 1, yc + 1 do
        for x = xc - 1, xc + 1 do
            -- Vérifie que la case existe dans la grille
            if x >= 0 and x <= 3 and y >= 0 and y <= 3 then
                -- Ne pas changer la case cliquée elle-même
                if not (x == xc and y == yc) then
                    grille[y][x] = 1 - grille[y][x]
                    UpdateButton(x, y)
                end
            end
        end
    end

    -- Vérifie la victoire
    VerificationGrille()
end

-- Fonction pour basculer la couleur d'un pion

local function ToggleColor(x, y)
    grille[y][x] = 1 - grille[y][x] -- inverse 0 ↔ 1
    UpdateButton(x, y)
end

-- Création de la fenêtre

local frame = CreateFrame("Frame", "GaspWindow", UIParent, "BasicFrameTemplate")
frame:SetSize(400, 400)
frame:SetPoint("CENTER")

-- Une texture dans la fond de la fenêtre

local texture = frame:CreateTexture()
texture:SetAllPoints()
texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")

--  un titre pour la fenêtre

frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
frame.title:SetPoint("TOP", 0, -5)
frame.title:SetText("Gasp Of Pandaria")

-- Une commande pour la console affiche la fenêtre

SLASH_GASP1 = "/gaspofpandaria"

SlashCmdList["GASP"] = function()
    print("Gasp fonctionne !")
    frame:Show()
end

-- un container pour la zone de jeu 

local gridFrame = CreateFrame("Frame", nil, frame)
gridFrame:SetSize(230, 230)
gridFrame:SetPoint("CENTER", frame, "CENTER", 0, 0)

-- Création des boutons

for y = 0, 3 do
    boutons[y] = {}
    for x = 0, 3 do
        local button = CreateFrame("Button", "GaspPion"..x..y, gridFrame)
        local taille = 50
        local espace = 5

        button:SetSize(taille, taille)
        button:SetPoint("TOPLEFT", x * (taille + espace), -y * (taille + espace))
        button:SetNormalTexture("Interface\\AddOns\\GaspOfPandaria\\images\\gem_blue.tga")

        button:SetScript("OnClick", function()
            Retourne(x, y)
        end)

        boutons[y][x] = button
    end
end
