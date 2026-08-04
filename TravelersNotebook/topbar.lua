tb = tb or {}

-----------------------------------------------------------
-- Fonction qui lance l'affichage des éléments de la topbar
-----------------------------------------------------------

function tb.CreateTopBar()
    print("création de la barre")
    tb.topBar = CreateFrame("Frame", nil, tb.frame)
    tb.topBar:SetSize(700, 50) 
    tb.topBar:SetPoint("TOPLEFT", tb.frame, "TOPLEFT", 0, 0)

    -- Add a background texture
    
    tb.topBar.texture = tb.topBar:CreateTexture(nil, "BACKGROUND")
    tb.topBar.texture:SetAllPoints()
    tb.topBar.texture:SetColorTexture(0, 1, 0, 1)

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
    tb.searchBox:Show()
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