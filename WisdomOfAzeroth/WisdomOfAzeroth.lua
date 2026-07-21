Wisdom = {}
Wisdom.currentIndex = 1

-- Création du frame
Wisdom.f = CreateFrame("Frame", "WisdomOfAzerothFrame", UIParent, "BasicFrameTemplateWithInset")
Wisdom.f:SetPoint("CENTER")
Wisdom.f:SetWidth(350)

-- Fond
local bg = Wisdom.f:CreateTexture(nil, "BORDER")
bg:SetAllPoints(true)
bg:SetAlpha(0.9)

-- Titre
Wisdom.title = Wisdom.f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
Wisdom.title:SetPoint("TOP", 0, -5)
Wisdom.title:SetText("Wisdom of Azeroth")

-- Numéro
Wisdom.n = Wisdom.f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
Wisdom.n:SetPoint("TOP", Wisdom.title, "BOTTOM", 0, -10)

-- Texte
Wisdom.t = Wisdom.f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
Wisdom.t:SetPoint("TOP", Wisdom.n, "BOTTOM", 0, -15)
Wisdom.t:SetWidth(300)
Wisdom.t:SetWordWrap(true)
Wisdom.t:SetJustifyH("CENTER")
Wisdom.t:SetJustifyV("TOP")

-- Fonction d'affichage
function Wisdom.ShowQuote(index)
    Wisdom.currentIndex = index

    if Wisdom.currentIndex < 1 then
        Wisdom.currentIndex = #WOW_QUOTES
    elseif Wisdom.currentIndex > #WOW_QUOTES then
        Wisdom.currentIndex = 1
    end

    Wisdom.n:SetText("Proverbe n°" .. Wisdom.currentIndex .. "/" .. #WOW_QUOTES)
    Wisdom.t:SetText(WOW_QUOTES[Wisdom.currentIndex])

    -- local neededHeight = Wisdom.t:GetStringHeight() + 115
    -- Wisdom.f:SetHeight(neededHeight)

    Wisdom.f:SetHeight(160)
    Wisdom.f:Show()
end

-- Premier affichage
Wisdom.ShowQuote(math.random(#WOW_QUOTES))

-- Bouton Previous
local boutonPrevious = CreateFrame("Button", nil, Wisdom.f, "UIPanelButtonTemplate")
boutonPrevious:SetSize(75, 25)
boutonPrevious:SetText("Précédent")
boutonPrevious:SetPoint("BOTTOM", Wisdom.f, "BOTTOM", -40, 10)
boutonPrevious:SetScript("OnClick", function()
    Wisdom.ShowQuote(Wisdom.currentIndex - 1)
end)

-- Bouton Next
local boutonNext = CreateFrame("Button", nil, Wisdom.f, "UIPanelButtonTemplate")
boutonNext:SetSize(75, 25)
boutonNext:SetText("Suivant")
boutonNext:SetPoint("BOTTOM", Wisdom.f, "BOTTOM", 40, 10)
boutonNext:SetScript("OnClick", function()
    Wisdom.ShowQuote(Wisdom.currentIndex + 1)
end)

