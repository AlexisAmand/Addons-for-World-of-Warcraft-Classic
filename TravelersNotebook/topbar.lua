tb = tb or {}

-----------------------------------------------------------
-- Fonction qui lance l'affichage des éléments de la topbar
-----------------------------------------------------------

function tb.CreateTopBar()
    print("création de la barre")
    tb.topBar = CreateFrame("Frame", nil, tb.frame)
    tb.topBar:SetSize(700, 40) 
    tb.topBar:SetPoint("TOPLEFT", tb.frame, "TOPLEFT", 0, -20)

    -- Add a background texture
    
    tb.topBar.texture = tb.topBar:CreateTexture(nil, "BACKGROUND")
    tb.topBar.texture:SetAllPoints()
    tb.topBar.texture:SetColorTexture(0, 1, 0, 0)

    tb.CreateSearchBox()
    tb.CreateHideInCombat()
    -- tb.CreateSortButton()
end

--------------------------------------------
-- Fonction qui affiche la zone de recherche
--------------------------------------------

function tb.CreateSearchBox()
    print("création de la zone de recherche")
    tb.searchBox = CreateFrame("EditBox", nil, tb.topBar, "InputBoxTemplate")
    tb.searchBox:SetSize(200, 20)
    tb.searchBox:SetPoint("LEFT", tb.topBar, "LEFT", 20, 0)
    tb.searchBox:SetAutoFocus(false)
    tb.searchBox:SetText("")

    tb.searchPlaceholder = tb.searchBox:CreateFontString(nil, "ARTWORK", "GameFontDisable")
    tb.searchPlaceholder:SetText("Search notes...")
    tb.searchPlaceholder:SetPoint("LEFT", tb.searchBox, "LEFT", 22, 0)

    tb.searchIcon = tb.searchBox:CreateTexture(nil, "ARTWORK")
    tb.searchIcon:SetSize(14, 14)
    tb.searchIcon:SetPoint("LEFT", tb.searchBox, "LEFT", 5, 0)
    tb.searchIcon:SetTexture("Interface\\Common\\UI-Searchbox-Icon")

    tb.searchBox:SetScript("OnEditFocusGained", function()
    tb.searchPlaceholder:Hide()
    end)

    tb.searchBox:SetScript("OnEditFocusLost", function()
        if tb.searchBox:GetText() == "" then
            tb.searchPlaceholder:Show()
        end
    end)

    tb.searchBox:SetScript("OnTextChanged", function()
        local mot = tb.searchBox:GetText()

        if mot == "" then
            tb.searchPlaceholder:Show()
            tb.filtreListe("")
        else
            tb.searchPlaceholder:Hide()
            tb.filtreListe(mot)
        end
    end)

    tb.searchBox:SetAutoFocus(false)
end

-----------------------------------------
-- Fonction qui affiche la check bok hide
-----------------------------------------

function tb.CreateHideInCombat()
    print("création de la checkbox hide")
    tb.checkHide = CreateFrame("CheckButton", nil, tb.topBar, "UICheckButtonTemplate")
    tb.checkHide:SetSize(20, 20)
    tb.checkHide:SetPoint("RIGHT", tb.topBar, "RIGHT", -20, 0)
    tb.checkHide:SetScript("OnClick", tb.checkBagarre)
    tb.checkHide:Show()
    
    -- Add a text
    tb.textHideText = tb.checkHide:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    tb.textHideText:SetText("Hide in combat")
    tb.textHideText:SetPoint("RIGHT", tb.checkHide, "RIGHT", -20, 0)
end

------------------------------------------
-- Fonction qui affiche les boutons de tri
------------------------------------------

function tb.CreateSortButton()
    print("création du button de tri")
    tb.triButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.triButton:SetSize(75, 25)
    tb.triButton:SetPoint("LEFT", tb.textHideText, "LEFT", 0, 0)
    tb.triButton:SetText("Sort")
end

-------------------
-- Check la bagarre
-------------------

function tb.checkBagarre()
    tb.combatFrame = CreateFrame("Frame")
    tb.combatFrame:RegisterEvent("PLAYER_REGEN_DISABLED")

    tb.combatFrame:SetScript("OnEvent", function()
        if tb.checkHide:GetChecked() then
            tb.frame:Hide()
        end
    end)  
end

----------------------------------------------
-- Filtre la liste en fonction de la recherche
----------------------------------------------

function tb.filtreListe(mot)
    tb.recherche = mot
    tb.tnRefreshList()
end

function tb.noteCorrespond(note, mot)
    if mot == "" then
        return true
    end

    mot = string.lower(mot)

    local titre = string.lower(note.title or "")
    local contenu = string.lower(note.content or "")

    return string.find(titre, mot, 1, true)
        or string.find(contenu, mot, 1, true)
end