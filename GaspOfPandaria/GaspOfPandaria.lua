--------------------------
-- Gestion des sauvegardes
--------------------------

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")

loader:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "GaspOfPandaria" then
        
        -- Chargement des sauvegardes
        GaspSaved = GaspSaved or {}

        -- Record
        GaspSaved.records = GaspSaved.records or {}

        -- Initialiser les records pour tous les niveaux
        for lvl = 1, 3 do
            if GaspSaved.records[lvl] == nil then
                GaspSaved.records[lvl] = 0
            end
        end

        -- Charger le record du niveau actuel
        Gasp.record = GaspSaved.records[math.floor(Gasp.niveau/2)]

        -- Si une grille sauvegardée existe, on la restaure
        if GaspSaved.grille then
            Gasp.grille = {}

            for y = 0, Gasp.niveau do
                Gasp.grille[y] = {}
                for x = 0, Gasp.niveau do
                    Gasp.grille[y][x] = GaspSaved.grille[y][x]
                end
            end

            -- Restaurer le nombre de coups
            Gasp.nbCoups = GaspSaved.nbCoups or 0
 
        else
            -- Sinon, nouvelle grille
            Gasp.CreerGrille()
            Gasp.nbCoups = 0
        end

        -- Mise à jour visuelle si l'UI existe déjà
        if Gasp.frame and Gasp.frame.coups then
            Gasp.frame.coups:SetText("Moves : 0  Wisdom of level "..math.floor(Gasp.niveau/2).." : "..Gasp.GetRecordText())
        end

        -- Mise à jour des boutons si déjà créés
        if Gasp.boutons then
            for y = 0, Gasp.niveau do
                for x = 0, Gasp.niveau do
                    Gasp.UpdateButton(x, y)
                end
            end
        end
    end
end)

------------------
-- Bouton flottant
------------------

-- Bouton 
local btn = CreateFrame("Button", "GOPFloatingButton", UIParent, "SecureActionButtonTemplate")
btn:SetSize(32, 32)
btn:SetPoint("CENTER") -- position initiale

-- Icône
local icon = btn:CreateTexture(nil, "BACKGROUND")
icon:SetAllPoints()
icon:SetTexture("Interface\\AddOns\\GaspOfPandaria\\images\\play.tga") 

-- Tooltip
btn:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Gasp Of Pandaria")
    GameTooltip:AddLine("Clic to play", 1, 1, 1)
    GameTooltip:Show()
end)

btn:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

-- Clic pour ouvrir ton addon
btn:SetScript("OnClick", function()
    if Gasp.frame:IsShown() then
        Gasp.frame:Hide()
    else
        Gasp.frame:Show()

        -- Charger le record du niveau actuel
        Gasp.record = GaspSaved.records and GaspSaved.records[math.floor(Gasp.niveau/2)] or nil

        if GaspSaved.grille then
            local savedMessages = {
                "A saved game was found.\nYour puzzle awaits.",
                "Your previous game has been recovered.\nShall we continue?",
                "The gems remember you.\nResume your journey?"
            }

            local msg = savedMessages[math.random(#savedMessages)]
            StaticPopupDialogs["SAVED_GAME"].text = msg

            StaticPopup_Show("SAVED_GAME")
        end
    end
end)

-- Déplacement du bouton

btn:SetMovable(true)
btn:EnableMouse(true)
btn:RegisterForDrag("LeftButton")
btn:SetScript("OnDragStart", btn.StartMoving)
btn:SetScript("OnDragStop", btn.StopMovingOrSizing)

-------------------------
-- Création de la fenêtre
-------------------------

Gasp.frame = CreateFrame("Frame", "GaspWindow", UIParent, "BasicFrameTemplate")
Gasp.frame:Hide()
Gasp.frame:SetSize(500, 400)
Gasp.frame:SetPoint("CENTER")

--------------------------------
-- On rend la fenêtre déplaçable
--------------------------------

Gasp.frame:SetFrameStrata("HIGH")
Gasp.frame:SetMovable(true)
Gasp.frame:EnableMouse(true)
Gasp.frame:RegisterForDrag("LeftButton")

Gasp.frame:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)

Gasp.frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)

---------------------------------------
-- Création de la grille de jeu logique
---------------------------------------

Gasp.CreerGrille()

-----------------------------------
-- Une zone pour le nombre de coups
----------------------------------- 

Gasp.frame.coups = Gasp.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
Gasp.frame.coups:SetPoint("TOP", Gasp.frame, "TOP", 0, -40)
Gasp.frame.coups:SetText("Moves : 0  Wisdom of level "..math.floor(Gasp.niveau/2).." : 0")

-- Fond derrière le texte
local coupsBG = CreateFrame("Frame", nil, Gasp.frame)
coupsBG:SetPoint("CENTER", Gasp.frame.coups, "CENTER")
coupsBG:SetSize(Gasp.frame.coups:GetStringWidth() + 20, Gasp.frame.coups:GetStringHeight() + 12)

coupsBG.texture = coupsBG:CreateTexture(nil, "BACKGROUND")
coupsBG.texture:SetAllPoints()
coupsBG.texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background-Dark")
coupsBG.texture:SetVertexColor(0.8, 0.7, 0.5, 0.6)

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
texture:SetTexture("Interface\\AddOns\\GaspOfPandaria\\images\\back03.tga")
texture:SetAlpha(0.5)

----------------------------
--  un titre pour la fenêtre
----------------------------

Gasp.frame.title = Gasp.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
Gasp.frame.title:SetPoint("TOP", 0, -5)
Gasp.frame.title:SetText("Gasp Of Pandaria")

-----------------------------------
-- un container pour la zone de jeu 
-----------------------------------

local gridFrame = CreateFrame("Frame", nil, Gasp.frame)
local espace = 5
local totalSize = (Gasp.taille * (Gasp.niveau + 1)) + (espace * Gasp.niveau)

-- Hauteur utile entre le titre et les boutons
local hauteurCadre = Gasp.frame:GetHeight() - 120  -- ajuster selon le layout
local offsetY = (hauteurCadre - totalSize) / 2

gridFrame:SetSize(totalSize, totalSize)
gridFrame:SetPoint("TOP", Gasp.frame, "TOP", 0, -70 - offsetY)

-----------------------
-- Création des gemmes
-----------------------

Gasp.CreationDesBoutons(gridFrame, espace)

--------------------------------------
-- Création des boutons de l'interface
--------------------------------------

-- Bouton 8x8
--------------

local bouton8x8 = CreateFrame("Button", nil, Gasp.frame, "UIPanelButtonTemplate")
bouton8x8:SetSize(68, 25)
bouton8x8:SetText("Level 3")

bouton8x8:SetScript("OnClick", function()
    Gasp.niveau = 7 -- car on utilise 0..5 pour un 6x6
    Gasp.taille = 29 -- plus de boutons, donc boutons + petits
    Gasp.nbCoups = 0
    Gasp.niveauText = "3"
    Gasp.frame.coups:SetText("Moves : 0  Wisdom of level "..math.floor(Gasp.niveau/2).." : "..Gasp.GetRecordText())

    Gasp.CreerGrille()
    Gasp.CreationDesBoutons(gridFrame, espace)

    -- rafraîchir les boutons :
    for y = 0, Gasp.niveau do
        for x = 0, Gasp.niveau do
            Gasp.UpdateButton(x, y)
        end
    end

end)

-- Bouton 6x6
--------------

local bouton6x6 = CreateFrame("Button", nil, Gasp.frame, "UIPanelButtonTemplate")
bouton6x6:SetSize(68, 25)
bouton6x6:SetText("Level 2")

bouton6x6:SetScript("OnClick", function()
    Gasp.niveau = 5 -- car on utilise 0..5 pour un 6x6
    Gasp.taille = 42 -- plus de boutons, donc boutons + petits
    Gasp.nbCoups = 0
    Gasp.niveauText = "2"
    Gasp.frame.coups:SetText("Moves : 0  Wisdom of level "..math.floor(Gasp.niveau/2).." : "..Gasp.GetRecordText())

    Gasp.CreerGrille()
    Gasp.CreationDesBoutons(gridFrame, espace)

    -- rafraîchir les boutons :
    for y = 0, Gasp.niveau do
        for x = 0, Gasp.niveau do
            Gasp.UpdateButton(x, y)
        end
    end

end)

-- Bouton 4x4
-------------
local bouton4x4 = CreateFrame("Button", nil, Gasp.frame, "UIPanelButtonTemplate")
bouton4x4:SetSize(68, 25) -- pour 4 bouton c'était 80,25
bouton4x4:SetText("Level 1")

bouton4x4:SetScript("OnClick", function()
    Gasp.niveau = 3 -- car on utilise 0..3 pour un 4x4
    Gasp.taille = 55 -- plus de boutons, donc boutons + petits
    Gasp.nbCoups = 0
    Gasp.niveauText = "1"
    Gasp.frame.coups:SetText("Moves : 0  Wisdom of level "..math.floor(Gasp.niveau/2).." : "..Gasp.GetRecordText())

    Gasp.CreerGrille()
    Gasp.CreationDesBoutons(gridFrame, espace)

    -- rafraîchir les boutons :
    for y = 0, Gasp.niveau do
        for x = 0, Gasp.niveau do
            Gasp.UpdateButton(x, y)
        end
    end


end)

-- Bouton shuffle
-----------------

local boutonShuffle = CreateFrame("Button", nil, Gasp.frame, "UIPanelButtonTemplate")
boutonShuffle:SetSize(68, 25)
boutonShuffle:SetText("Gust")

boutonShuffle:SetScript("OnClick", function()
    PlaySoundFile("Interface\\AddOns\\GaspOfPandaria\\sounds\\wind.wav")
    Gasp.melangerGrille()   
end)

-- Bouton rules
---------------

local boutonRules = CreateFrame("Button", nil, Gasp.frame, "UIPanelButtonTemplate")
boutonRules:SetSize(68, 25)
boutonRules:SetText("Rules")

boutonRules:SetScript("OnClick", function()
    StaticPopup_Show("GASP_REGLES")
end)

-- Bouton reset
---------------

local boutonReset = CreateFrame("Button", nil, Gasp.frame, "UIPanelButtonTemplate")
boutonReset:SetSize(68, 25)
boutonReset:SetText("Reset")

boutonReset:SetScript("OnClick", function()
    Gasp.nbCoups = 0
    Gasp.frame.coups:SetText("Moves : 0  Wisdom of level "..math.floor(Gasp.niveau/2).." : "..Gasp.GetRecordText())
    Gasp.CreerGrille()

    -- rafraîchir les boutons :
    for y = 0, Gasp.niveau do
        for x = 0, Gasp.niveau do
            Gasp.UpdateButton(x, y)
        end
    end

end)

----------------------------
-- On place bien les boutons
----------------------------

local boutons = {boutonRules, boutonReset, boutonShuffle, bouton4x4, bouton6x6, bouton8x8}

local total = #boutons
local espace = 77 -- distance entre les boutons, pour 4 c'est 100
local largeurTotale = (total - 1) * espace
local startX = (Gasp.frame:GetWidth() - largeurTotale) / 2

for i, b in ipairs(boutons) do
    b:ClearAllPoints()
    b:SetPoint("BOTTOM", Gasp.frame, "BOTTOMLEFT", startX + (i - 1) * espace, 20)
end


