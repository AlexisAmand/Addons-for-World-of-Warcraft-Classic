tb = tb or {}

-----------------------------------------------------------
-- Fonction qui lance l'affichage des éléments de la topbar
-----------------------------------------------------------

function tb.CreateTopBar()
    tb.topBar = CreateFrame("Frame", nil, tb.frame)
    tb.topBar:SetSize(700, 40) 
    tb.topBar:SetPoint("TOPLEFT", tb.frame, "TOPLEFT", 0, -23)

    -- Ajout de la background texture
    
    tb.topBar.texture = tb.topBar:CreateTexture(nil, "BACKGROUND")
    tb.topBar.texture:SetAllPoints()
    tb.topBar.texture:SetColorTexture(0, 1, 0, 0)

    -- ligne de séparation

    tb.topSeparator = tb.frame:CreateTexture(nil, "ARTWORK")
    tb.topSeparator:SetColorTexture(1, 1, 1, 0.15)
    tb.topSeparator:SetSize(660, 1)
    tb.topSeparator:SetPoint("TOP", tb.topBar, "BOTTOM", 0, 0)

    tb.CreateSearchBox()
    tb.CreateHideInCombat()
    tb.CreateSortButton()


end

--------------------------------------------
-- Fonction qui affiche la zone de recherche
--------------------------------------------

function tb.CreateSearchBox()
    tb.searchBox = CreateFrame("EditBox", nil, tb.topBar, "InputBoxTemplate")
    tb.searchBox:SetSize(200, 20)
    tb.searchBox:SetPoint("LEFT", tb.topBar, "LEFT", 20, 0)
    tb.searchBox:SetAutoFocus(false)
    tb.searchBox:SetText("")

    tb.searchPlaceholder = tb.searchBox:CreateFontString(nil, "ARTWORK", "GameFontDisable")
    tb.searchPlaceholder:SetText(tb.text.TB_searchbox)
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
    tb.checkHide = CreateFrame("CheckButton", nil, tb.topBar, "UICheckButtonTemplate")
    tb.checkHide:SetSize(20, 20)
    tb.checkHide:SetPoint("RIGHT", tb.topBar, "RIGHT", -20, 0)
    tb.checkHide:SetScript("OnClick", tb.checkBagarre)
    tb.checkHide:Show()
    
    -- Add a text
    tb.textHideText = tb.checkHide:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    tb.textHideText:SetText(tb.text_TB_hide)
    tb.textHideText:SetPoint("RIGHT", tb.checkHide, "RIGHT", -20, 0)
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

------------------------------------------
-- Fonction qui affiche les boutons de tri
------------------------------------------

function tb.CreateSortButton()

    tb.sortMenu = CreateFrame("Frame", nil, tb.topBar, "BackdropTemplate")
    tb.sortMenu:SetSize(100, 170)

    tb.sortMenu:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 12,
    })

    tb.triButton = CreateFrame("Button", nil, tb.topBar, "UIPanelButtonTemplate")
    tb.triButton:SetSize(75, 25)
    tb.triButton:SetPoint("RIGHT", tb.textHideText, "LEFT", -10, 0)
    tb.triButton:SetText(tb.text_TB_sort_btn)
    tb.triButton:SetScript("OnClick", function(self)
        if tb.sortMenu:IsShown() then
            tb.sortMenu:Hide()
        else
            tb.sortMenu:Show()
        end
    end)

    tb.sortMenu:SetBackdropColor(0, 0, 0, 0.9)
    tb.sortMenu:SetFrameStrata("DIALOG")
    tb.sortMenu:SetPoint("TOP", tb.triButton, "BOTTOM", 0, -5)
    tb.sortMenu:Hide()

    -- bouton tri A..Z
    tb.azButton = CreateFrame("Button", nil, tb.sortMenu, "UIPanelButtonTemplate")
    tb.azButton:SetSize(75, 25)
    tb.azButton:SetText(tb.text_TB_btn_01)
    tb.azButton:SetPoint("TOP", tb.sortMenu, "TOP", 0, -10)
    tb.azButton:SetScript("OnClick", tb.triAZ)

    -- bouton tri Z..A
    tb.zaButton = CreateFrame("Button", nil, tb.sortMenu, "UIPanelButtonTemplate")
    tb.zaButton:SetSize(75, 25)
    tb.zaButton:SetText(tb.text_TB_btn_02)
    tb.zaButton:SetPoint("TOP", tb.sortMenu, "TOP", 0, -40)
    tb.zaButton:SetScript("OnClick", tb.triZA)

    -- bouton tri défaut
    tb.defautButton = CreateFrame("Button", nil, tb.sortMenu, "UIPanelButtonTemplate")
    tb.defautButton:SetSize(75, 25)
    tb.defautButton:SetText(tb.text_TB_btn_03)
    tb.defautButton:SetPoint("TOP", tb.sortMenu, "TOP", 0, -70)
    tb.defautButton:SetScript("OnClick", tb.triDefaut)

    -- bouton tri chrono
    tb.chrono01Button = CreateFrame("Button", nil, tb.sortMenu, "UIPanelButtonTemplate")
    tb.chrono01Button:SetSize(75, 25)
    tb.chrono01Button:SetText(tb.text_TB_btn_04)
    tb.chrono01Button:SetPoint("TOP", tb.sortMenu, "TOP", 0, -100)
    tb.chrono01Button:SetScript("OnClick", tb.triDate01)

    -- local arrow = tb.chrono01Button:CreateTexture(nil, "ARTWORK")
    -- arrow:SetSize(12, 12)
    -- arrow:SetPoint("RIGHT", -5, 0)
    -- arrow:SetTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up")

    -- bouton tri chrono
    tb.chrono02Button = CreateFrame("Button", nil, tb.sortMenu, "UIPanelButtonTemplate")
    tb.chrono02Button:SetSize(75, 25)
    tb.chrono02Button:SetText(tb.text_TB_btn_05)
    tb.chrono02Button:SetPoint("TOP", tb.sortMenu, "TOP", 0, -130)
    tb.chrono02Button:SetScript("OnClick", tb.triDate02)

end

----------------------------
-- fonction pour le tri A..Z
----------------------------

function tb.triAZ()
    tb.sortMenu:Hide()
    tb.sortMode = "AZ"
    tb.tnRefreshList()
end

----------------------------
-- fonction pour le tri Z..A
----------------------------

function tb.triZA()
    tb.sortMenu:Hide()
    tb.sortMode = "ZA"
    tb.tnRefreshList()
end

----------------------------
-- fonction pour le tri Z..A
----------------------------

function tb.triDefaut()
    tb.sortMenu:Hide()
    tb.sortMode = "D"
    tb.tnRefreshList()
end

---------------------------------
-- fonction pour date croissante
--------------------------------

function tb.triDate01()
    tb.sortMenu:Hide()
    tb.sortMode = "TC"
    tb.tnRefreshList()
end

----------------------------------
-- fonction pour date décroissante
----------------------------------

function tb.triDate02()
    tb.sortMenu:Hide()
    tb.sortMode = "TD"
    tb.tnRefreshList()
end