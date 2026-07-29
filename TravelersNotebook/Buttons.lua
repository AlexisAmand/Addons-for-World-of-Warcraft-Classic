tb = tb or {}

-------------------------
-- Génération des boutons
-------------------------

function tb.CreationBoutons()

    -- bouton new note

    tb.newButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.newButton:SetSize(85, 25)
    tb.newButton:SetText(tb.text.BUTTON_NEW)
    tb.newButton:SetScript("OnClick", tb.tnNewNote)

    tb.newButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Create a new note")
        GameTooltip:Show()
    end)

    tb.newButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton save

    tb.saveButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.saveButton:SetSize(85, 25)
    tb.saveButton:SetText(tb.text.BUTTON_SAVE)
    tb.saveButton:SetScript("OnClick", tb.tnSaveNote)

    tb.saveButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Save this note")
        GameTooltip:Show()
    end)

    tb.saveButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton delete

    tb.deleteButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.deleteButton:SetSize(85, 25)
    tb.deleteButton:SetText(tb.text.BUTTON_DEL)
    tb.deleteButton:SetScript("OnClick", tb.tnDeleteNote)

    tb.deleteButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Delete this note")
        GameTooltip:Show()
    end)

    tb.deleteButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton about

    tb.aboutButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.aboutButton:SetSize(85, 25)
    tb.aboutButton:SetText(tb.text.BUTTON_ABOUT)
    tb.aboutButton:SetScript("OnClick", tb.tnAboutWindows)

    tb.aboutButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("About this addon")
        GameTooltip:Show()
    end)

    tb.aboutButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton Hide

    tb.hideButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.hideButton:SetSize(85, 25)
    tb.hideButton:SetText("Hide")
    tb.hideButton:SetScript("OnClick", tb.tnHideWindows)

    tb.hideButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Hide this windows")
        GameTooltip:Show()
    end)

    tb.hideButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton GPS

    tb.gpsButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.gpsButton:SetSize(85, 25)
    tb.gpsButton:SetText("GPS")
    tb.gpsButton:SetScript("OnClick", tb.CoordGPS)

    tb.gpsButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Add your current location to the note")
        GameTooltip:Show()
    end)

    tb.gpsButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton pour épingler

    tb.closeNoteButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.closeNoteButton:SetSize(85, 25)
    tb.closeNoteButton:SetText("Return")
    tb.closeNoteButton:SetScript("OnClick", tb.closeNote)

    tb.closeNoteButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Close this note")
        GameTooltip:Show()
    end)

    tb.closeNoteButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton pour épingler

    tb.pinButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.pinButton:SetSize(85, 25)
    tb.pinButton:SetText("Pin")
    tb.pinButton:SetScript("OnClick", tb.pinNote)

    tb.pinButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Pin/unpin this note")
        GameTooltip:Show()
    end)

    tb.pinButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- tous les boutons

    tb.allButtons = {
        tb.newButton,
        tb.saveButton,
        tb.deleteButton,
        tb.gpsButton,
        tb.closeNoteButton,
        tb.pinButton,
        tb.aboutButton,
        tb.hideButton
    }

    -- les modes d'affichage

    tb.modes = {
        LISTE = {
            tb.newButton,
            tb.aboutButton,
            tb.hideButton
        },

        EDITION = {
            tb.saveButton,
            tb.deleteButton,
            tb.gpsButton,
            tb.pinButton,
            tb.closeNoteButton,
            tb.hideButton
        }
    }

end

--------------------------------------------
-- Affiche les boutons en bas de l'interface
--------------------------------------------

function tb.AfficherBoutons()
    -- Cacher tous les boutons
    for _, bouton in pairs(tb.allButtons) do
        bouton:Hide()
    end

    local boutons = tb.modes[tb.mode]

    if not boutons then
        return
    end

    local total = #boutons
    local espace = 100
    local largeurTotale = (total - 1) * espace
    local startX = (tb.frame:GetWidth() - largeurTotale) / 2

    for i, bouton in ipairs(boutons) do
        bouton:Show()
        bouton:SetFrameLevel(tb.frame:GetFrameLevel() + 1)
        bouton:SetPoint("BOTTOM",tb.frame,"BOTTOMLEFT",  startX + (i - 1) * espace, 20)
    end
end

