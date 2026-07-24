-----------------------------------------
-- fonction qui affiche une fenêtre about
-----------------------------------------

function tnshowAbout()

    local aboutFrame = CreateFrame("Frame", "TNAbout", UIParent, "BasicFrameTemplateWithInset")

    aboutFrame:SetFrameStrata("DIALOG")
    aboutFrame:SetFrameLevel(tb.frame:GetFrameLevel() + 10)

    aboutFrame:SetSize(250, 120)
    aboutFrame:SetPoint("CENTER")
    
    aboutFrame.title = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    aboutFrame.title:SetPoint("TOP", 0, -5)
    aboutFrame.title:SetText("About")

    aboutFrame.text = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    aboutFrame.text:SetWidth(250)
    aboutFrame.text:SetJustifyH("CENTER")
    aboutFrame.text:SetPoint("TOP", 0, -40)

    aboutFrame.text:SetText(
    "Traveler's Notebook\n"..
    "Version "..tb.version.."\n"..
    "By Hanslex\n\n"
    )

    aboutFrame:Show()

    local closeButton = CreateFrame("Button", nil, aboutFrame, "UIPanelButtonTemplate")
    closeButton:SetSize(80, 25)
    closeButton:SetPoint("BOTTOM", 0, 10)
    closeButton:SetText("Close")
    closeButton:SetScript("OnClick", function()
        aboutFrame:Hide()
    end)

end

------------------------------------------------------
-- fonction qui affiche une confirmation de sauvegarde
------------------------------------------------------

function tnshowSaved()

    local saveFrame = CreateFrame("Frame", "TNsave", UIParent, "BasicFrameTemplateWithInset")

    saveFrame:SetFrameStrata("DIALOG")
    saveFrame:SetFrameLevel(Gasp.frame:GetFrameLevel() + 10)

    saveFrame:SetSize(250, 100)
    saveFrame:SetPoint("CENTER")
    
    saveFrame.title = saveFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    saveFrame.title:SetPoint("TOP", 0, -5)
    saveFrame.title:SetText("Message")

    saveFrame.text = saveFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    saveFrame.text:SetWidth(250)
    saveFrame.text:SetJustifyH("CENTER")
    saveFrame.text:SetPoint("TOP", 0, -40)
    saveFrame.text:SetText("The note has been saved successfully!")

    saveFrame:Show()

    local closeButton = CreateFrame("Button", nil, saveFrame, "UIPanelButtonTemplate")
    closeButton:SetSize(80, 25)
    closeButton:SetPoint("BOTTOM", 0, 10)
    closeButton:SetText("Close")
    closeButton:SetScript("OnClick", function()
        saveFrame:Hide()
    end)

end

------------------------------------------------------
-- fonction qui affiche une confirmation de suppresion
------------------------------------------------------

function tnshowDeleted()

    local deleteFrame = CreateFrame("Frame", "TNdelete", UIParent, "BasicFrameTemplateWithInset")

    deleteFrame:SetFrameStrata("DIALOG")
    deleteFrame:SetFrameLevel(Gasp.frame:GetFrameLevel() + 10)

    deleteFrame:SetSize(250, 100)
    deleteFrame:SetPoint("CENTER")
    
    deleteFrame.title = deleteFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    deleteFrame.title:SetPoint("TOP", 0, -5)
    deleteFrame.title:SetText("Message")

    deleteFrame.text = deleteFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    deleteFrame.text:SetWidth(250)
    deleteFrame.text:SetJustifyH("CENTER")
    deleteFrame.text:SetPoint("TOP", 0, -40)
    deleteFrame.text:SetText("The note has been deleted.")

    deleteFrame:Show()

    local closeButton = CreateFrame("Button", nil, deleteFrame, "UIPanelButtonTemplate")
    closeButton:SetSize(80, 25)
    closeButton:SetPoint("BOTTOM", 0, 10)
    closeButton:SetText("Close")
    closeButton:SetScript("OnClick", function()
        deleteFrame:Hide()
    end)

end

--------------------------------------------------
-- fonction qui affiche un message si pas de titre
--------------------------------------------------

function tnshowNoTitle()

    local notitleFrame = CreateFrame("Frame", "TNnotitle", UIParent, "BasicFrameTemplateWithInset")

    notitleFrame:SetFrameStrata("DIALOG")
    notitleFrame:SetFrameLevel(Gasp.frame:GetFrameLevel() + 10)

    notitleFrame:SetSize(250, 100)
    notitleFrame:SetPoint("CENTER")
    
    notitleFrame.title = notitleFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    notitleFrame.title:SetPoint("TOP", 0, -5)
    notitleFrame.title:SetText("Message")

    notitleFrame.text = notitleFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    notitleFrame.text:SetWidth(250)
    notitleFrame.text:SetJustifyH("CENTER")
    notitleFrame.text:SetPoint("TOP", 0, -40)
    notitleFrame.text:SetText("Unable to save: no title.")

    notitleFrame:Show()

    local closeButton = CreateFrame("Button", nil, notitleFrame, "UIPanelButtonTemplate")
    closeButton:SetSize(80, 25)
    closeButton:SetPoint("BOTTOM", 0, 10)
    closeButton:SetText("Close")
    closeButton:SetScript("OnClick", function()
        notitleFrame:Hide()
    end)

end

-----------------------------------------------------------
-- fonction qui affiche un message si pas de note à effacer
-----------------------------------------------------------

function tnshowNoNote()

    local nonoteFrame = CreateFrame("Frame", "TNnonote", UIParent, "BasicFrameTemplateWithInset")

    nonoteFrame:SetFrameStrata("DIALOG")
    nonoteFrame:SetFrameLevel(Gasp.frame:GetFrameLevel() + 10)

    nonoteFrame:SetSize(250, 100)
    nonoteFrame:SetPoint("CENTER")
    
    nonoteFrame.title = nonoteFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    nonoteFrame.title:SetPoint("TOP", 0, -5)
    nonoteFrame.title:SetText("Message")

    nonoteFrame.text = nonoteFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    nonoteFrame.text:SetWidth(250)
    nonoteFrame.text:SetJustifyH("CENTER")
    nonoteFrame.text:SetPoint("TOP", 0, -40)
    nonoteFrame.text:SetText("Unable to save: no title.")

    nonoteFrame:Show()

    local closeButton = CreateFrame("Button", nil, nonoteFrame, "UIPanelButtonTemplate")
    closeButton:SetSize(80, 25)
    closeButton:SetPoint("BOTTOM", 0, 10)
    closeButton:SetText("Close")
    closeButton:SetScript("OnClick", function()
        nonoteFrame:Hide()
    end)

end