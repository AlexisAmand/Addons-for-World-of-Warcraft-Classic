tb = tb or {}

function tb.CreationEditMenu()

    tb.editMenu = CreateFrame("Frame", nil, tb.frame, "BackdropTemplate")
    tb.editMenu:SetSize(180, 180)  -- 180,135

    tb.editMenu:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 12,
    })

    -- bouton insert

    tb.editMenu:SetBackdropColor(0, 0, 0, 0.9)
    tb.editMenu:SetFrameStrata("DIALOG")
    tb.editMenu:SetPoint("BOTTOM", tb.menu2Button, "TOP", 0, 5)
    tb.editMenu:Hide()

    -- bouton pour épingler

    tb.pinButton = CreateFrame("Button", nil, tb.editMenu, "UIPanelButtonTemplate")
    tb.pinButton:SetSize(75, 25)
    tb.pinButton:SetText(tb.text.BUTTON_PIN)
    tb.pinButton:SetPoint("TOPLEFT", tb.editMenu, "TOPLEFT", 10, -10)

    tb.pinButton:SetScript("OnClick", tb.pinNote)

    tb.pinButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_PIN_HELP)
        GameTooltip:Show()
    end)

    tb.pinButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- a title pour la palette
    tb.colorTitle = tb.editMenu:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    tb.colorTitle:SetText(tb.text.TXTCOLOR)
    tb.colorTitle:SetPoint("TOPRIGHT", tb.editMenu, "TOPRIGHT", -13, -10)

    -- 1er colonne des boutons de couleur

    local mesCouleurs = {jaune = {255/255, 241/255, 118/255}, rouge = {255/255, 138/255, 138/255}, orange = {255/255, 183/255, 120/255}, vert = {156/255, 220/255, 156/255}, bleu = {137/255, 196/255, 244/255}, violet = {190/255, 155/255, 230/255}}
    local position = 0

    for  c, couleur in pairs(mesCouleurs) do
        tb.colorButton = CreateFrame("Button", nil, tb.editMenu)
        tb.colorButton:SetSize(15, 15)

        tb.colorButton:SetPoint("TOPRIGHT", tb.editMenu, "TOPRIGHT", -10, - (30 + (position * 25)))

        tb.colorButton.texture = tb.colorButton:CreateTexture(nil, "BACKGROUND")
        tb.colorButton.texture:SetAllPoints()
        tb.colorButton.texture:SetColorTexture(couleur[1], couleur[2], couleur[3])
        
        tb.colorButton:SetScript("OnClick", function(self)
            tb.choisirColor(couleur)
        end)
        
        tb.colorButton:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(tb.text.CHOOSECOLOR)
            GameTooltip:Show()
        end)

        tb.colorButton:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)  
        
        position = position + 1
        
    end

    -- 2e colonne des boutons de couleur

    local mesCouleurs = {rose = {245/255, 166/255, 205/255}, cyan = {125/255, 220/255, 195/255}, bleuciel = {170/255, 215/255, 245/255}, menthe = {155/255, 225/255, 195/255}, marronclair = {205/255, 165/255, 195/255}, grisclair = {200/255, 200/255, 200/255}}
    local position = 0

    for  c, couleur in pairs(mesCouleurs) do
        tb.colorButton = CreateFrame("Button", nil, tb.editMenu)
        tb.colorButton:SetSize(15, 15)

        tb.colorButton:SetPoint("TOPRIGHT", tb.editMenu, "TOPRIGHT", - 35, - (30 + (position * 25)))

        tb.colorButton.texture = tb.colorButton:CreateTexture(nil, "BACKGROUND")
        tb.colorButton.texture:SetAllPoints()
        tb.colorButton.texture:SetColorTexture(couleur[1], couleur[2], couleur[3])
        
        tb.colorButton:SetScript("OnClick", function(self)
            tb.choisirColor(couleur)
        end)
        
        tb.colorButton:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(tb.text.CHOOSECOLOR)
            GameTooltip:Show()
        end)

        tb.colorButton:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)  
        
        position = position + 1
        
    end

    -- 3e colonne des boutons de couleur

    local mesCouleurs = {corail = {245/255, 145/255, 125/255}, magentaclair = {225/255, 145/255, 205/255}, oliveclair = {190/255, 195/255, 120/255}, turquoise = {105/255, 200/255, 190/255}, beige = {230/255, 205/255, 165/255}, lavande = {205/255, 185/255, 235/255}}
    local position = 0

    for  c, couleur in pairs(mesCouleurs) do
        tb.colorButton = CreateFrame("Button", nil, tb.editMenu)
        tb.colorButton:SetSize(15, 15)

        tb.colorButton:SetPoint("TOPRIGHT", tb.editMenu, "TOPRIGHT", - 60, - (30 + (position * 25)))

        tb.colorButton.texture = tb.colorButton:CreateTexture(nil, "BACKGROUND")
        tb.colorButton.texture:SetAllPoints()
        tb.colorButton.texture:SetColorTexture(couleur[1], couleur[2], couleur[3])
        
        tb.colorButton:SetScript("OnClick", function(self)
            tb.choisirColor(couleur)
        end)
        
        tb.colorButton:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(tb.text.CHOOSECOLOR)
            GameTooltip:Show()
        end)

        tb.colorButton:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)  
        
        position = position + 1
        
    end    

end

function tb.CreationInsertMenu()

    tb.insertMenu = CreateFrame("Frame", nil, tb.frame, "BackdropTemplate")
    tb.insertMenu:SetSize(180, 135)

    tb.insertMenu:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 12,
    })

    -- bouton insert

    tb.insertMenu:SetBackdropColor(0, 0, 0, 0.9)
    tb.insertMenu:SetFrameStrata("DIALOG")
    tb.insertMenu:SetPoint("BOTTOM", tb.menuButton, "TOP", 0, 5)
    tb.insertMenu:Hide()

    -- bouton GPS

    tb.gpsButton = CreateFrame("Button", nil, tb.insertMenu, "UIPanelButtonTemplate")
    tb.gpsButton:SetSize(75, 25)
    tb.gpsButton:SetText(tb.text.BUTTON_GPS)
    tb.gpsButton:SetPoint("TOPLEFT", tb.insertMenu, "TOPLEFT", 10, -10)
    tb.gpsButton:SetScript("OnClick", tb.CoordGPS)

    tb.gpsButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_GPS_HELP)
        GameTooltip:Show()
    end)

    tb.menuButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton time

    tb.timeButton = CreateFrame("Button", nil, tb.insertMenu, "UIPanelButtonTemplate")
    tb.timeButton:SetSize(75, 25)
    tb.timeButton:SetText(tb.text.BUTTON_TIME)
    -- tb.timeButton:SetPoint("TOP", tb.insertMenu, "TOP", 0, -40)
    tb.timeButton:SetPoint("TOPRIGHT", tb.insertMenu, "TOPRIGHT", -10, -10)
    tb.timeButton:SetScript("OnClick", tb.AddTime)

    tb.timeButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_TIME_HELP)
        GameTooltip:Show()
    end)

    tb.menuButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton date

    tb.dateButton = CreateFrame("Button", nil, tb.insertMenu, "UIPanelButtonTemplate")
    tb.dateButton:SetSize(75, 25)
    tb.dateButton:SetText(tb.text.BUTTON_DATE)
    tb.dateButton:SetPoint("TOPLEFT", tb.insertMenu, "TOPLEFT", 10, -40)
    tb.dateButton:SetScript("OnClick", tb.AddDate)

    tb.dateButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_DATE_HELP)
        GameTooltip:Show()
    end)

    tb.menuButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton zone
   
    tb.nomZoneDateButton = CreateFrame("Button", nil, tb.insertMenu, "UIPanelButtonTemplate")
    tb.nomZoneDateButton:SetSize(75, 25)
    tb.nomZoneDateButton:SetText(tb.text.BUTTON_ZONE)
    tb.nomZoneDateButton:SetPoint("TOPRIGHT", tb.insertMenu, "TOPRIGHT", -10, -40)
    tb.nomZoneDateButton:SetScript("OnClick", tb.nomZone)

    tb.nomZoneDateButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_ZONE_HELP)
        GameTooltip:Show()
    end)

    tb.nomZoneDateButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton line

    tb.separatorButton = CreateFrame("Button", nil, tb.insertMenu, "UIPanelButtonTemplate")
    tb.separatorButton:SetSize(75, 25)
    tb.separatorButton:SetText(tb.text.BUTTON_LINE)
    tb.separatorButton:SetPoint("TOPLEFT", tb.insertMenu, "TOPLEFT", 10, -70)
    tb.separatorButton:SetScript("OnClick", tb.addSeparator)

    tb.separatorButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_LINE_HELP)
        GameTooltip:Show()
    end)

    tb.separatorButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton pnj

    tb.targetButton = CreateFrame("Button", nil, tb.insertMenu, "UIPanelButtonTemplate")
    tb.targetButton:SetSize(75, 25)
    tb.targetButton:SetText(tb.text.BUTTON_PNJ)
    tb.targetButton:SetPoint("TOPRIGHT", tb.insertMenu, "TOPRIGHT", -10, -70)
    tb.targetButton:SetScript("OnClick", tb.afficheTarget)

    tb.targetButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_PNJ_HELP)
        GameTooltip:Show()
    end)

    tb.targetButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- bouton combo

    tb.comboButton = CreateFrame("Button", nil, tb.insertMenu, "UIPanelButtonTemplate")
    tb.comboButton:SetSize(75, 25)
    tb.comboButton:SetText(tb.text.BUTTON_POSITION)
    tb.comboButton:SetPoint("TOPLEFT", tb.insertMenu, "TOPLEFT", 10, -100)
    tb.comboButton:SetScript("OnClick", tb.comboLocation)

    tb.comboButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTTON_POSITION_HELP)
        GameTooltip:Show()
    end)

    tb.comboButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

end

-------------------------
-- Génération des boutons
-------------------------

function tb.CreationBoutons()

    -- bouton insert : pour le sousmenu

    tb.menuButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.menuButton:SetSize(75, 25)
    tb.menuButton:SetText(tb.text.BUTTON_INSERT)
    tb.menuButton:SetScript("OnClick", function(self)
        tb.editMenu:Hide()
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

    -- bouton edit : pour le sousmenu

    tb.menu2Button = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
    tb.menu2Button:SetSize(75, 25)
    tb.menu2Button:SetText(tb.text.BUTONN_EDIT)
    tb.menu2Button:SetScript("OnClick", function(self)
        tb.insertMenu:Hide()
        if tb.editMenu:IsShown() then
            tb.editMenu:Hide()
        else
            tb.editMenu:Show()
        end
    end)

    tb.menu2Button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tb.text.BUTONN_EDIT_HELP)
        GameTooltip:Show()
    end)

    tb.menu2Button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- créer le contenu des menus
    tb.CreationInsertMenu()
    tb.CreationEditMenu()

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

    -- tous les boutons

    tb.allButtons = {
        tb.newButton,
        tb.saveButton,
        tb.deleteButton,
        tb.closeNoteButton,
        tb.menu2Button,
        tb.menuButton,
        tb.aboutButton,
        tb.hideButton,
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
            tb.menu2Button,
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

