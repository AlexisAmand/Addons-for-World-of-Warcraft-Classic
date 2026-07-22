tb = {}

tb.notes = {}
tb.noteRows = {}
tb.currentIndex = nil
tb.version = "0.0.2"

--------------------------
-- Gestion des sauvegardes
--------------------------

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
    if addon == "TravelersNotebook" then
        TBSaved = TBSaved or {}
        TBSaved.notes = TBSaved.notes or {}

        tb.notes = TBSaved.notes
        tb.refreshList()
    end
end)

--------------------------
-- Bouton dans l'interface
--------------------------

-- Bouton flottant Traveler's Notebook
local btn = CreateFrame("Button", "TNFloatingButton", UIParent, "SecureActionButtonTemplate")
btn:SetSize(40, 40)
btn:SetPoint("CENTER") -- position initiale

-- Icône
local icon = btn:CreateTexture(nil, "BACKGROUND")
icon:SetAllPoints()
icon:SetTexture("Interface\\AddOns\\TravelersNotebook\\images\\book_icon.tga") -- icône de parchemin

-- Tooltip
btn:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Traveler's Notebook")
    GameTooltip:AddLine("Clic to open Traveler's Notebook", 1, 1, 1)
    GameTooltip:Show()
end)

btn:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

-- Clic pour ouvrir ton addon
btn:SetScript("OnClick", function()
    if tb.frame:IsShown() then
        tb.frame:Hide()
    else
        tb.frame:Show()
    end
end)

-- Déplacement du bouton
btn:SetMovable(true)
btn:EnableMouse(true)
btn:RegisterForDrag("LeftButton")
btn:SetScript("OnDragStart", btn.StartMoving)
btn:SetScript("OnDragStop", btn.StopMovingOrSizing)

------------------------------------------------------------
-- LISTBOX : rafraîchir la liste des notes
------------------------------------------------------------
function tb.refreshList()
    -- Effacer les anciennes lignes
    for _, row in ipairs(tb.noteRows) do
        row:Hide()
    end
    tb.noteRows = {}

    local y = -10
    for index, note in pairs(tb.notes) do
        local row = CreateFrame("Button", nil, tb.listContent)
        row:SetPoint("TOPLEFT", 0, y)
        row:SetSize(200, 20)

        row.text = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.text:SetPoint("LEFT", 5, 0)
        row.text:SetText(note.title)

        row:SetScript("OnClick", function()
            tb.loadNote(index)
        end)

        table.insert(tb.noteRows, row)
        y = y - 22
    end
end

------------------------------------------------------------
-- Charger une note
------------------------------------------------------------
function tb.loadNote(index)
    tb.currentIndex = index
    tb.titleBox:SetText(tb.notes[index].title)
    tb.editBox:SetText(tb.notes[index].content)
end

------------------------------------------------------------
-- Nouvelle note
------------------------------------------------------------
function tb.newNote()
    tb.currentIndex = nil
    tb.titleBox:SetText("Enter the title")
    tb.editBox:SetText("And here the content")
end

------------------------------------------------------------
-- Sauvegarder une note
------------------------------------------------------------
function tb.saveNote()
    local titre = tb.titleBox:GetText()
    local contenu = tb.editBox:GetText()

    if titre == "" then
        print("Unable to save: no title.")
        return
    end

    if not tb.currentIndex then
        tb.currentIndex = #tb.notes + 1
        tb.notes[tb.currentIndex] = {}
    end

    tb.notes[tb.currentIndex].title = titre
    tb.notes[tb.currentIndex].content = contenu
    TBSaved.notes = tb.notes
    showSaved()
    tb.refreshList()
end

------------------------------------------------------------
-- Supprimer une note
------------------------------------------------------------
function tb.deleteNote()
    if not tb.currentIndex then
        print("No notes to delete.")
        return
    end

    tb.notes[tb.currentIndex] = nil
    tb.currentIndex = nil

    tb.titleBox:SetText("")
    tb.editBox:SetText("")

    showDeleted()
    tb.refreshList()
end

------------------------------------------------------------
-- À propos
------------------------------------------------------------
function tb.aboutWindows()
    showAbout()
end

------------------------------------------------------------
-- Commande /tn
------------------------------------------------------------
SLASH_TRAVELERNOTE1 = "/tn"
SlashCmdList["TRAVELERNOTE"] = function()
    if tb.frame:IsShown() then
        tb.frame:Hide()
    else
        tb.frame:Show()
    end
end

------------------------------------------------------------
-- Fenêtre principale
------------------------------------------------------------
tb.frame = CreateFrame("Frame", "tbWindow", UIParent, "BasicFrameTemplate")
tb.frame:SetSize(700, 400)
tb.frame:SetPoint("CENTER")

tb.frame.title = tb.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
tb.frame.title:SetPoint("TOP", 0, -5)
tb.frame.title:SetText("Traveler's Notebook")

------------------------------------------------------------
-- LISTBOX (à gauche)
------------------------------------------------------------
tb.listFrame = CreateFrame("ScrollFrame", "tbListFrame", tb.frame, "UIPanelScrollFrameTemplate")
tb.listFrame:SetPoint("TOPLEFT", tb.frame, "TOPLEFT", 20, -40)
tb.listFrame:SetSize(200, 300)

tb.listContent = CreateFrame("Frame", nil, tb.listFrame)
tb.listContent:SetSize(200, 600)

-- Add a background texture
local bg = tb.listContent:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints(tb.listContent) -- make it fill the frame
bg:SetColorTexture(0, 0, 0, 0.5) -- RGBA: black with 50% transparency

tb.listFrame:SetScrollChild(tb.listContent)

------------------------------------------------------------
-- Champ titre (à droite)
------------------------------------------------------------
tb.titleBox = CreateFrame("EditBox", "tbTitleBox", tb.frame, "InputBoxTemplate")
tb.titleBox:SetSize(300, 20)
tb.titleBox:SetPoint("TOPLEFT", tb.listFrame, "TOPRIGHT", 20, 0)
tb.titleBox:SetAutoFocus(false)

------------------------------------------------------------
-- Zone de texte (scrollable)
------------------------------------------------------------
tb.scrollFrame = CreateFrame("ScrollFrame", "tbScrollFrame", tb.frame, "UIPanelScrollFrameTemplate")
tb.scrollFrame:SetPoint("TOPLEFT", tb.titleBox, "BOTTOMLEFT", 0, -20)
tb.scrollFrame:SetPoint("BOTTOMRIGHT", tb.frame, "BOTTOMRIGHT", -40, 60)

tb.editBox = CreateFrame("EditBox", "tbEditBox", tb.scrollFrame)
tb.editBox:SetMultiLine(true)
tb.editBox:SetFontObject("GameFontNormal")
tb.editBox:SetWidth(400)
tb.editBox:SetHeight(800)
tb.editBox:SetAutoFocus(false)

-- Add a background texture
local bg = tb.scrollFrame:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints(tb.scrollFrame) -- make it fill the frame
bg:SetColorTexture(0, 0, 0, 0.5) -- RGBA: black with 50% transparency

tb.scrollFrame:SetScrollChild(tb.editBox)

tb.editBox:SetText("Welcome in Traveler's Notebook !")

------------------------------------------------------------
-- Boutons
------------------------------------------------------------
tb.newButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
tb.newButton:SetSize(115, 25)
tb.newButton:SetText("New note")
tb.newButton:SetScript("OnClick", tb.newNote)

tb.saveButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
tb.saveButton:SetSize(115, 25)
tb.saveButton:SetText("Save")
tb.saveButton:SetScript("OnClick", tb.saveNote)

tb.deleteButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
tb.deleteButton:SetSize(115, 25)
tb.deleteButton:SetText("Delete")
tb.deleteButton:SetScript("OnClick", tb.deleteNote)

tb.aboutButton = CreateFrame("Button", nil, tb.frame, "UIPanelButtonTemplate")
tb.aboutButton:SetSize(115, 25)
tb.aboutButton:SetText("About")
tb.aboutButton:SetScript("OnClick", tb.aboutWindows)

-- Placement automatique des boutons
local boutons = {tb.newButton, tb.saveButton, tb.deleteButton, tb.aboutButton}
local total = #boutons
local espace = 120
local largeurTotale = (total - 1) * espace
local startX = (tb.frame:GetWidth() - largeurTotale) / 2

for i, b in ipairs(boutons) do
    b:ClearAllPoints()
    b:SetPoint("BOTTOM", tb.frame, "BOTTOMLEFT", startX + (i - 1) * espace, 20)
end