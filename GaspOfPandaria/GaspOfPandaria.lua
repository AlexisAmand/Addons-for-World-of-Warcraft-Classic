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
Gasp.frame:Hide()
Gasp.frame:SetSize(400, 400)
Gasp.frame:SetPoint("CENTER")

-- Création de la grille de jeu logique

Gasp.CreerGrille()

-----------------------------------
-- Une zone pour le nombre de coups
----------------------------------- 

Gasp.frame.coups = Gasp.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
Gasp.frame.coups:SetPoint("TOP", Gasp.frame, "TOP", 0, -40)
Gasp.frame.coups:SetText("Moves : 0   Record : 0")

-- Fond derrière le texte
local coupsBG = CreateFrame("Frame", nil, Gasp.frame)
coupsBG:SetPoint("CENTER", Gasp.frame.coups, "CENTER")
coupsBG:SetSize(Gasp.frame.coups:GetStringWidth() + 20, Gasp.frame.coups:GetStringHeight() + 12)

coupsBG.texture = coupsBG:CreateTexture(nil, "BACKGROUND")
coupsBG.texture:SetAllPoints()
coupsBG.texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background-Dark")
coupsBG.texture:SetVertexColor(0.8, 0.7, 0.5, 0.6)  -- ton parchemin chaud

-- Bordure haut
local top = coupsBG:CreateTexture(nil, "BORDER")
top:SetColorTexture(1, 1, 1, 0.6)
top:SetPoint("TOPLEFT", coupsBG, "TOPLEFT", 0, 0)
top:SetPoint("TOPRIGHT", coupsBG, "TOPRIGHT", 0, 0)
top:SetHeight(1)

-- Bordure bas
local bottom = coupsBG:CreateTexture(nil, "BORDER")
bottom:SetColorTexture(1, 1, 1, 0.6)
bottom:SetPoint("BOTTOMLEFT", coupsBG, "BOTTOMLEFT", 0, 0)
bottom:SetPoint("BOTTOMRIGHT", coupsBG, "BOTTOMRIGHT", 0, 0)
bottom:SetHeight(1)

-- Bordure gauche
local left = coupsBG:CreateTexture(nil, "BORDER")
left:SetColorTexture(1, 1, 1, 0.6)
left:SetPoint("TOPLEFT", coupsBG, "TOPLEFT", 0, 0)
left:SetPoint("BOTTOMLEFT", coupsBG, "BOTTOMLEFT", 0, 0)
left:SetWidth(1)

-- Bordure droite
local right = coupsBG:CreateTexture(nil, "BORDER")
right:SetColorTexture(1, 1, 1, 0.6)
right:SetPoint("TOPRIGHT", coupsBG, "TOPRIGHT", 0, 0)
right:SetPoint("BOTTOMRIGHT", coupsBG, "BOTTOMRIGHT", 0, 0)
right:SetWidth(1)

-----------------------------------------
-- Une texture dans la fond de la fenêtre
-----------------------------------------

local texture = Gasp.frame:CreateTexture()
texture:SetAllPoints()
-- texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
texture:SetTexture("Interface\\AddOns\\GaspOfPandaria\\images\\back01.tga")
texture:SetAlpha(0.5)
-- texture:SetVertexColor(0.8, 0.8, 0.9)
-- texture:SetDesaturated(true)

----------------------------
--  un titre pour la fenêtre
----------------------------

Gasp.frame.title = Gasp.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
Gasp.frame.title:SetPoint("TOP", 0, -5)
Gasp.frame.title:SetText("Gasp Of Pandaria")

-- Une commande pour la console affiche la fenêtre

SLASH_GASP1 = "/gaspofpandaria"

SlashCmdList["GASP"] = function()
    Gasp.frame:Show()
end

-----------------------------------
-- un container pour la zone de jeu 
-----------------------------------

local gridFrame = CreateFrame("Frame", nil, Gasp.frame)
local espace = 5
local totalSize = (Gasp.taille * (Gasp.niveau + 1)) + (espace * Gasp.niveau)

-- Hauteur utile entre le titre et les boutons
local hauteurCadre = Gasp.frame:GetHeight() - 120  -- ajuste selon ton layout
local offsetY = (hauteurCadre - totalSize) / 2

gridFrame:SetSize(totalSize, totalSize)
gridFrame:SetPoint("TOP", Gasp.frame, "TOP", 0, -60 - offsetY)

-- Création des boutons

for y = 0, Gasp.niveau do
    Gasp.boutons[y] = {}
    for x = 0, Gasp.niveau do
        local button = CreateFrame("Button", "GaspPion"..x..y, gridFrame)

        button:SetSize(Gasp.taille, Gasp.taille)
        button:SetPoint("TOPLEFT", x * (Gasp.taille + espace), -y * (Gasp.taille + espace))
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

    for y = 0, Gasp.niveau do
        for x = 0, Gasp.niveau do
            Gasp.UpdateButton(x, y)
        end
    end
end)

-- Bouton de contrôle (taille standard d'un bouton de minimap)
local miniButton = CreateFrame("Button", "GaspMiniButton", Minimap)
miniButton:SetSize(31, 31)
miniButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -12, -12) -- Position globale sur la minimap
miniButton:SetFrameStrata("MEDIUM")

-- Arrière-plan sombre (pour remplir le cercle sous l'icône)
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

