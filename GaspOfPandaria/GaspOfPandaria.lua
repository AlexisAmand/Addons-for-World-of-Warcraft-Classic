-- Gestion des sauvegardes

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")

loader:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "GaspOfPandaria" then
        -- Chargement des sauvegardes
        GaspSaved = GaspSaved or {}
        Gasp.record = GaspSaved.record or nil

        print("Record chargé :", Gasp.record)

        -- Mise à jour de l'affichage si l'UI existe déjà
        if Gasp.frame and Gasp.frame.coups then
            Gasp.frame.coups:SetText("Moves : 0  Record : "..Gasp.GetRecordText())
        end
    end
end)

-- Création de la fenêtre

Gasp.frame = CreateFrame("Frame", "GaspWindow", UIParent, "BasicFrameTemplate")
Gasp.frame:SetSize(400, 400)
Gasp.frame:SetPoint("CENTER")

-- Affichage de la grille de jeu 

Gasp.CreerGrille()

-- Une zone pour le nombre de coups 

Gasp.frame.coups = Gasp.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
Gasp.frame.coups:SetPoint("BOTTOM", 0, 10)
Gasp.frame.coups:SetText("Moves : 0   Record : 0")

-- Une texture dans la fond de la fenêtre

local texture = Gasp.frame:CreateTexture()
texture:SetAllPoints()
-- texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
texture:SetTexture("Interface\\AddOns\\GaspOfPandaria\\images\\back01.tga")
texture:SetAlpha(0.5)
-- texture:SetVertexColor(0.8, 0.8, 0.9)
-- texture:SetDesaturated(true)


--  un titre pour la fenêtre

Gasp.frame.title = Gasp.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
Gasp.frame.title:SetPoint("TOP", 0, -5)
Gasp.frame.title:SetText("Gasp Of Pandaria")

-- Une commande pour la console affiche la fenêtre

SLASH_GASP1 = "/gaspofpandaria"

SlashCmdList["GASP"] = function()
    Gasp.frame:Show()
end

-- un container pour la zone de jeu 

local gridFrame = CreateFrame("Frame", nil, Gasp.frame)
local taille = 60
local espace = 5
local gridSize = (taille * 4) + (espace * 3)

gridFrame:SetSize(gridSize, gridSize)
gridFrame:SetPoint("CENTER", Gasp.frame, "CENTER", 0, 10)

-- Création des boutons

for y = 0, 3 do
    Gasp.boutons[y] = {}
    for x = 0, 3 do
        local button = CreateFrame("Button", "GaspPion"..x..y, gridFrame)
        -- local taille = 60
        -- local espace = 5

        button:SetSize(taille, taille)
        button:SetPoint("TOPLEFT", x * (taille + espace), -y * (taille + espace))
        button:SetNormalTexture("Interface\\AddOns\\GaspOfPandaria\\images\\gem_blue.tga")

        button:SetScript("OnClick", function()
            Gasp.Retourne(x, y)
        end)

        Gasp.boutons[y][x] = button
    end
end

-- Bouton RULES (à gauche)
local boutonRules = CreateFrame("Button", nil, Gasp.frame, "UIPanelButtonTemplate")
boutonRules:SetSize(80, 25)
boutonRules:SetPoint("BOTTOMLEFT", Gasp.frame, "BOTTOMLEFT", 20, 20)
boutonRules:SetText("Rules")

boutonRules:SetScript("OnClick", function()
    StaticPopup_Show("GASP_REGLES")
end)

-- Bouton RESET (à droite)
local boutonReset = CreateFrame("Button", nil, Gasp.frame, "UIPanelButtonTemplate")
boutonReset:SetSize(80, 25)
boutonReset:SetPoint("BOTTOMRIGHT", Gasp.frame, "BOTTOMRIGHT", -20, 20)
boutonReset:SetText("Reset")

boutonReset:SetScript("OnClick", function()
    Gasp.nbCoups = 0
    Gasp.frame.coups:SetText("Moves : 0  Record : "..Gasp.GetRecordText())
    Gasp.CreerGrille()

    for y = 0, 3 do
        for x = 0, 3 do
            Gasp.UpdateButton(x, y)
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
    Gasp.frame:Show()
end)

