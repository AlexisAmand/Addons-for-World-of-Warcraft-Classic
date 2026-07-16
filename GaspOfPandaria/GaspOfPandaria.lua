print("Gasp chargé !")
local nbCoups = 0

-- Création de la fenêtre

local frame = CreateFrame("Frame", "GaspWindow", UIParent, "BasicFrameTemplate")
frame:SetSize(400, 400)
frame:SetPoint("CENTER")

-- popup rules

StaticPopupDialogs["GASP_REGLES"] = {
    text = "Clique sur une gemme pour retourner les voisines.\nLe but : retourner toutes les gemmes !",
    button1 = "OK",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

-- popup si on a gagné !

StaticPopupDialogs["GASP_VICTOIRE"] = {
    text = "", -- sera remplacé dans OnShow
    button1 = "OK",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,

    OnShow = function(self)
        if nbCoups <= 10 then
            self.Text:SetText("Bravo ! Résolu en "..nbCoups.." coups ! Excellent !")
        elseif nbCoups <= 20 then
            self.Text:SetText("Bien joué ! Résolu en "..nbCoups.." coups.")
        else
            self.Text:SetText("Victoire ! Résolu en "..nbCoups.." coups.")
        end

        self:ClearAllPoints()
        self:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    end,
}

local grille = {}

local function CreerGrille()
    for y = 0, 3 do
        grille[y] = {}
        for x = 0, 3 do
            grille[y][x] = 0
        end
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
    -- local couleur = grille[0][0]
    for y = 0, 3 do
        for x = 0, 3 do
            if grille[y][x] ~= 1 then
                return -- pas encore gagné
            end
        end
    end
    print("Bravo ! Toutes les gemmes sont de la même couleur !")
    -- appel de la popup de victoire
    StaticPopup_Show("GASP_VICTOIRE")

    PlaySound(567399) -- petit son de victoire
end

-- On retourne un bouton ! 

local function Retourne(xc, yc)
    -- Joue un son (facultatif)
    PlaySound(567482) -- son générique WoW

    -- Incrémente le compteur de coups
    nbCoups = nbCoups + 1
    frame.coups:SetText("Coups : "..nbCoups)
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

CreerGrille()

-- Une zone pour le nombre de coups 

frame.coups = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
frame.coups:SetPoint("BOTTOM", 0, 10)
frame.coups:SetText("Coups : 0")

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

-- Bouton RULES (à gauche)
local boutonRules = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
boutonRules:SetSize(80, 25)
boutonRules:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 20, 20)
boutonRules:SetText("Règles")

boutonRules:SetScript("OnClick", function()
    StaticPopup_Show("GASP_REGLES")
end)

-- Bouton RESET (à droite)
local boutonReset = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
boutonReset:SetSize(80, 25)
boutonReset:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -20, 20)
boutonReset:SetText("Reset")

boutonReset:SetScript("OnClick", function()
    nbCoups = 0
    frame.coups:SetText("Coups : 0")

    CreerGrille()

    for y = 0, 3 do
        for x = 0, 3 do
            UpdateButton(x, y)
        end
    end
end)




















-- Bouton de contrôle (taille standard d'un bouton de minimap)
local miniButton = CreateFrame("Button", "GaspMiniButton", Minimap)
miniButton:SetSize(31, 31)
miniButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -12, -12) -- Position globale sur la minimap
miniButton:SetFrameStrata("MEDIUM")

-- Arrière-plan sombre (pour remplir le cercle sous ton icône)
local background = miniButton:CreateTexture(nil, "BACKGROUND")
background:SetSize(20, 20)
background:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
background:SetPoint("TOPLEFT", miniButton, "TOPLEFT", 7, -5) -- Décalage magique Blizzard

-- Icône verte (alignée pile dans le trou de la bordure)
local icon = miniButton:CreateTexture(nil, "ARTWORK")
icon:SetTexture("Interface\\AddOns\\GaspOfPandaria\\images\\play.tga")
icon:SetSize(17, 17) -- Taille standard du contenu du bouton
icon:SetPoint("TOPLEFT", miniButton, "TOPLEFT", 7, -5) -- Même décalage que l'arrière-plan

-- Bordure dorée (qui englobe le tout sans aucun offset)
local border = miniButton:CreateTexture(nil, "OVERLAY")
border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
border:SetSize(53, 53)
border:SetPoint("TOPLEFT", miniButton, "TOPLEFT", 0, 0) -- La bordure reste collée à 0,0

-- Halo au survol (aligné proprement sur le fond)
miniButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
local highlight = miniButton:GetHighlightTexture()
highlight:SetAllPoints(background)

-- Action au clic
miniButton:SetScript("OnClick", function()
    frame:Show()
end)

