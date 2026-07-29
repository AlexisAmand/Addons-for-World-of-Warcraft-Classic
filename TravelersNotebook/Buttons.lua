tb = tb or {}

-------------------------
-- Génération des boutons
-------------------------

function tb.CreationBoutons()

    tb.newButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.newButton:SetSize(115, 25)
    tb.newButton:SetText(tb.text.BUTTON_NEW)
    tb.newButton:SetScript("OnClick", tb.tnNewNote)

    tb.saveButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.saveButton:SetSize(100, 25)
    tb.saveButton:SetText(tb.text.BUTTON_SAVE)
    tb.saveButton:SetScript("OnClick", tb.tnSaveNote)

    tb.deleteButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.deleteButton:SetSize(100, 25)
    tb.deleteButton:SetText(tb.text.BUTTON_DEL)
    tb.deleteButton:SetScript("OnClick", tb.tnDeleteNote)

    tb.aboutButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.aboutButton:SetSize(100, 25)
    tb.aboutButton:SetText(tb.text.BUTTON_ABOUT)
    tb.aboutButton:SetScript("OnClick", tb.tnAboutWindows)

    tb.hideButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.hideButton:SetSize(100, 25)
    tb.hideButton:SetText("Hide")
    tb.hideButton:SetScript("OnClick", tb.tnHideWindows)

    -- tous les boutons

    tb.allButtons = {
        tb.newButton,
        tb.saveButton,
        tb.deleteButton,
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
            tb.aboutButton,
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
    local espace = 120
    local largeurTotale = (total - 1) * espace
    local startX = (tb.frame:GetWidth() - largeurTotale) / 2

    for i, bouton in ipairs(boutons) do
        bouton:Show()
        bouton:SetFrameLevel(tb.frame:GetFrameLevel() + 1)
        bouton:SetPoint("BOTTOM",tb.frame,"BOTTOMLEFT",  startX + (i - 1) * espace, 20)
    end
end

