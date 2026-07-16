local f = CreateFrame("Frame", "WisdomOfAzerothFrame", UIParent, "BasicFrameTemplateWithInset")
f:SetPoint("CENTER")
f:SetSize(350, 150)

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
local neededHeight = t:GetStringHeight() + 80
f:SetHeight(neededHeight)
