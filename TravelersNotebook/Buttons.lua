tb = tb or {}

function tb.CreationInsertMenu()

    tb.insertMenu = CreateFrame("Frame", nil, tb.frame, "BackdropTemplate")
    tb.insertMenu:SetSize(120, 200)

    tb.insertMenu:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 12,
    })

    tb.insertMenu:SetBackdropColor(0, 0, 0, 0.9)
    tb.insertMenu:SetFrameStrata("DIALOG")
    tb.insertMenu:SetPoint("BOTTOMLEFT", tb.menuButton, "TOPLEFT", 0, 5)
    tb.insertMenu:Hide()

    tb.gpsButton = CreateFrame("Button", nil, tb.insertMenu, "UIPanelButtonTemplate")
    tb.gpsButton:SetSize(75, 25)
    tb.gpsButton:SetText(tb.text.BUTTON_GPS)
    tb.gpsButton:SetPoint("TOP", tb.insertMenu, "TOP", 0, -10)
    tb.gpsButton:SetScript("OnClick", tb.CoordGPS)

    tb.timeButton = CreateFrame("Button", nil, tb.insertMenu, "UIPanelButtonTemplate")
    tb.timeButton:SetSize(75, 25)
    tb.timeButton:SetText(tb.text.BUTTON_TIME)
    tb.timeButton:SetPoint("TOP", tb.insertMenu, "TOP", 0, -40)
    tb.timeButton:SetScript("OnClick", tb.AddTime)

    tb.dateButton = CreateFrame("Button", nil, tb.insertMenu, "UIPanelButtonTemplate")
    tb.dateButton:SetSize(75, 25)
    tb.dateButton:SetText(tb.text.BUTTON_DATE)
    tb.dateButton:SetPoint("TOP", tb.insertMenu, "TOP", 0, -70)
    tb.dateButton:SetScript("OnClick", tb.AddDate)
   
    tb.nomZoneDateButton = CreateFrame("Button", nil, tb.insertMenu, "UIPanelButtonTemplate")
    tb.nomZoneDateButton:SetSize(75, 25)
    tb.nomZoneDateButton:SetText(tb.text.BUTTON_ZONE)
    tb.nomZoneDateButton:SetPoint("TOP", tb.insertMenu, "TOP", 0, -100)
    tb.nomZoneDateButton:SetScript("OnClick", tb.nomZone)

    tb.separatorButton = CreateFrame("Button", nil, tb.insertMenu, "UIPanelButtonTemplate")
    tb.separatorButton:SetSize(75, 25)
    tb.separatorButton:SetText(tb.text.BUTTON_LINE)
    tb.separatorButton:SetPoint("TOP", tb.insertMenu, "TOP", 0, -130)
    tb.separatorButton:SetScript("OnClick", tb.addSeparator)

    tb.targetButton = CreateFrame("Button", nil, tb.insertMenu, "UIPanelButtonTemplate")
    tb.targetButton:SetSize(75, 25)
    tb.targetButton:SetText(tb.text.BUTTON_PNJ)
    tb.targetButton:SetPoint("TOP", tb.insertMenu, "TOP", 0, -160)
    tb.targetButton:SetScript("OnClick", tb.afficheTarget)

end

-------------------------
-- Génération des boutons
-------------------------

function tb.CreationBoutons()

    -- bouton pour le sousmenu

    tb.menuButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.menuButton:SetSize(75, 25)
    tb.menuButton:SetText(tb.text.BUTTON_INSERT)
    tb.menuButton:SetScript("OnClick", function(self)
        if tb.insertMenu:IsShown() then
            tb.insertMenu:Hide()
        else
            tb.insertMenu:Show()
        end
    end)

    tb.menuButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_INSERT_HELP)
        GameTooltip:Show()
    end)

    tb.menuButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- créer le contenu du menu
    tb.CreationInsertMenu()

    -- bouton new note

    tb.newButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.newButton:SetSize(75, 25)
    tb.newButton:SetText(tb.text.BUTTON_NEW)
    tb.newButton:SetScript("OnClick", tb.tnNewNote)

    tb.newButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_NEW_HELP)
        GameTooltip:Show()
    end)

    tb.newButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton save

    tb.saveButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.saveButton:SetSize(75, 25)
    tb.saveButton:SetText(tb.text.BUTTON_SAVE)
    tb.saveButton:SetScript("OnClick", tb.tnSaveNote)

    tb.saveButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_SAVE_HELP)
        GameTooltip:Show()
    end)

    tb.saveButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton delete

    tb.deleteButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.deleteButton:SetSize(75, 25)
    tb.deleteButton:SetText(tb.text.BUTTON_DEL)
    tb.deleteButton:SetScript("OnClick", tb.tnDeleteNote)

    tb.deleteButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_DEL_HELP)
        GameTooltip:Show()
    end)

    tb.deleteButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton about

    tb.aboutButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.aboutButton:SetSize(75, 25)
    tb.aboutButton:SetText(tb.text.BUTTON_ABOUT)
    tb.aboutButton:SetScript("OnClick", tb.tnAboutWindows)

    tb.aboutButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_ABOUT_HELP)
        GameTooltip:Show()
    end)

    tb.aboutButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton Hide

    tb.hideButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.hideButton:SetSize(75, 25)
    tb.hideButton:SetText(tb.text.BUTTON_HIDE)
    tb.hideButton:SetScript("OnClick", tb.tnHideWindows)

    tb.hideButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_HIDE_HELP)
        GameTooltip:Show()
    end)

    tb.hideButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton pour fermer

    tb.closeNoteButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.closeNoteButton:SetSize(75, 25)
    tb.closeNoteButton:SetText(tb.text.BUTTON_RETURN)
    tb.closeNoteButton:SetScript("OnClick", tb.closeNote)

    tb.closeNoteButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_RETURN_HELP)
        GameTooltip:Show()
    end)

    tb.closeNoteButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton pour épingler

    tb.pinButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.pinButton:SetSize(75, 25)
    tb.pinButton:SetText(tb.text.BUTTON_PIN)
    tb.pinButton:SetScript("OnClick", tb.pinNote)

    tb.pinButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_PIN_HELP)
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
        tb.closeNoteButton,
        tb.pinButton,
        tb.menuButton,
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
            tb.pinButton,
            tb.menuButton,
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

