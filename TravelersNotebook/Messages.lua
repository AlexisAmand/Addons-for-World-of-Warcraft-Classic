-----------------------------------------
-- fonction qui affiche une fenêtre about
-----------------------------------------

function showAbout()

    local optionsFrame = CreateFrame("Frame", "GaspOptions", UIParent, "BasicFrameTemplateWithInset")

    optionsFrame:SetFrameStrata("DIALOG")
    optionsFrame:SetFrameLevel(Gasp.frame:GetFrameLevel() + 10)

    optionsFrame:SetSize(250, 120)
    optionsFrame:SetPoint("CENTER")
    
    optionsFrame.title = optionsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    optionsFrame.title:SetPoint("TOP", 0, -5)
    optionsFrame.title:SetText("About")

    optionsFrame.text = optionsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    optionsFrame.text:SetWidth(250)
    optionsFrame.text:SetJustifyH("CENTER")
    optionsFrame.text:SetPoint("TOP", 0, -40)

    optionsFrame.text:SetText(
    "Traveler's Notebook\n"..
    "Version "..tb.version.."\n"..
    "By Hanslex\n\n"
    )

    optionsFrame:Show()

    local closeButton = CreateFrame("Button", nil, optionsFrame, "UIPanelButtonTemplate")
    closeButton:SetSize(80, 25)
    closeButton:SetPoint("BOTTOM", 0, 10)
    closeButton:SetText("Fermer")
    closeButton:SetScript("OnClick", function()
        optionsFrame:Hide()
    end)

end

------------------------------------------------------
-- fonction qui affiche une confirmation de sauvegarde
------------------------------------------------------

function showSaved()

    local optionsFrame = CreateFrame("Frame", "GaspOptions", UIParent, "BasicFrameTemplateWithInset")

    optionsFrame:SetFrameStrata("DIALOG")
    optionsFrame:SetFrameLevel(Gasp.frame:GetFrameLevel() + 10)

    optionsFrame:SetSize(250, 100)
    optionsFrame:SetPoint("CENTER")
    
    optionsFrame.title = optionsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    optionsFrame.title:SetPoint("TOP", 0, -5)
    optionsFrame.title:SetText("Message")

    optionsFrame.text = optionsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    optionsFrame.text:SetWidth(250)
    optionsFrame.text:SetJustifyH("CENTER")
    optionsFrame.text:SetPoint("TOP", 0, -40)
    optionsFrame.text:SetText("La note a bien été sauvegardée !")

    optionsFrame:Show()

    local closeButton = CreateFrame("Button", nil, optionsFrame, "UIPanelButtonTemplate")
    closeButton:SetSize(80, 25)
    closeButton:SetPoint("BOTTOM", 0, 10)
    closeButton:SetText("Close")
    closeButton:SetScript("OnClick", function()
        optionsFrame:Hide()
    end)

end

------------------------------------------------------
-- fonction qui affiche une confirmation de suppresion
------------------------------------------------------

function showDeleted()

    local optionsFrame = CreateFrame("Frame", "GaspOptions", UIParent, "BasicFrameTemplateWithInset")

    optionsFrame:SetFrameStrata("DIALOG")
    optionsFrame:SetFrameLevel(Gasp.frame:GetFrameLevel() + 10)

    optionsFrame:SetSize(250, 100)
    optionsFrame:SetPoint("CENTER")
    
    optionsFrame.title = optionsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    optionsFrame.title:SetPoint("TOP", 0, -5)
    optionsFrame.title:SetText("Message")

    optionsFrame.text = optionsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    optionsFrame.text:SetWidth(250)
    optionsFrame.text:SetJustifyH("CENTER")
    optionsFrame.text:SetPoint("TOP", 0, -40)
    optionsFrame.text:SetText("La note a bien été effacée !")

    optionsFrame:Show()

    local closeButton = CreateFrame("Button", nil, optionsFrame, "UIPanelButtonTemplate")
    closeButton:SetSize(80, 25)
    closeButton:SetPoint("BOTTOM", 0, 10)
    closeButton:SetText("Close")
    closeButton:SetScript("OnClick", function()
        optionsFrame:Hide()
    end)

end