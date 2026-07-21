local f = CreateFrame("Frame", "WisdomOfAzerothFrame", UIParent, "BasicFrameTemplateWithInset")
f:SetPoint("CENTER")

-- Fond moderne
local bg = f:CreateTexture(nil, "BORDER")
bg:SetAllPoints(true)
bg:SetAlpha(0.9)

-- Titre
f.title = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
f.title:SetPoint("TOP", 0, -5)
f.title:SetText("Wisdom of Azeroth")

-- Numéro du proverbe
local index = math.random(#WOW_QUOTES)
local n = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
n:SetPoint("TOP", f.title, "BOTTOM", 0, -10)
n:SetText("Proverbe n°" .. index .. "/" .. #WOW_QUOTES)

-- Texte du proverbe
local t = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
t:SetPoint("TOP", n, "BOTTOM", 0, -15)
t:SetWidth(300)              -- largeur max du texte
t:SetWordWrap(true)          -- active le retour à la ligne
t:SetJustifyH("CENTER")      -- centrage horizontal
t:SetJustifyV("TOP")         -- alignement vertical
t:SetText(WOW_QUOTES[index])

-- Ajustement automatique de la hauteur du cadre
local neededHeight = t:GetStringHeight() + 115
f:SetWidth(350)
f:SetHeight(neededHeight)

-- bouton suivant
-----------------

local boutonNext = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
boutonNext:SetSize(68, 25)
boutonNext:SetText("Suivant")
boutonNext:SetPoint("BOTTOM", f, "BOTTOM", 40, 10)

-- bouton précédent
-------------------

local boutonPrevious = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
boutonPrevious:SetSize(68, 25)
boutonPrevious:SetText("Précédent")
boutonPrevious:SetPoint("BOTTOM", f, "BOTTOM", -40, 10)
