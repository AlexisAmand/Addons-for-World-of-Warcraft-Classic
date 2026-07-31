-- Remember:
-- This is a notebook, not an office suite.

tb = tb or {}

tb.notes = {}
tb.noteRows = {}
tb.currentIndex = nil
tb.version = C_AddOns.GetAddOnMetadata("TravelersNoteBook", "Version")
tb.noteModifiee = false

function tb.ShowPlaceholder()
    local child = tb.scrollFrame:GetScrollChild()
    child:SetText(tb.text.NO_NOTE_YET)
    child:SetTextColor(0.7, 0.7, 0.7)
    child.isPlaceholder = true
end

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

        if #tb.notes == 0 then

            tb.notes[1] = {
            title = "Welcome !",
            content = [[
            This notebook is ready for your adventures.

            Use the Add button to insert useful information.

            Available tools:
            - New : Create a note.
            - GPS: Insert your current coordinates.
            - Zone: Insert your current zone.
            - Date: Insert the current date.
            - Time: Insert the current time.
            - Separator: Add a visual separator.

            Write down your discoveries, reminders, and memories.

            Happy travels!
            ]]
            }
            TBSaved.notes = tb.notes

            tb.titleBox:SetText(tb.notes[1].title)
            tb.editBox:SetText(tb.notes[1].content)
            tb.tnRefreshList()

        else
            tb.titleBox:SetText(tb.notes[1].title)
            tb.editBox:SetText(tb.notes[1].content)
            tb.tnRefreshList()
        end
    end

end)

--------------------------
-- Bouton dans l'interface
--------------------------

-- Bouton flottant Traveler's Notebook
local btn = CreateFrame("CheckButton", "TNFloatingButton", UIParent, "ActionButtonTemplate")
btn:SetSize(36, 36)
btn:SetPoint("CENTER")

-- Icône
local icon = _G[btn:GetName().."Icon"]
icon:SetTexture("Interface\\AddOns\\TravelersNotebook\\images\\book.tga") 

local cd = _G[btn:GetName().."Cooldown"]
cd:SetCooldown(GetTime(), 1) 

local bg = btn:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints()
bg:SetTexture("Interface\\Buttons\\UI-Quickslot")

-- Tooltip
btn:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(tb.text.ADDON_TITLE)
    GameTooltip:AddLine(tb.text.ICON_TOOLTIP, 1, 1, 1)
    GameTooltip:Show()
end)

btn:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

-- Clic pour ouvrir ton addon

btn:SetScript("OnClick", function(self)
    self:SetChecked(false) 
    tb.Toggle()
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

function tb.tnRefreshList()

    local sortedNotes = {}

    -- Effacer les anciennes lignes
    for _, row in ipairs(tb.noteRows) do
        row:Hide()
    end
    tb.noteRows = {}

    -- D'abord les notes épinglées
    for index, note in ipairs(tb.notes) do
        if note.pinned then
            table.insert(sortedNotes, {
                index = index,
                note = note
            })
        end
    end

    -- Ensuite les notes normales
    for index, note in ipairs(tb.notes) do
        if not note.pinned then
            table.insert(sortedNotes, {
                index = index,
                note = note
            })
        end
    end

    local y = -10

    for _, entry in ipairs(sortedNotes) do

        local index = entry.index
        local note = entry.note

        local row = CreateFrame("Button", nil, tb.listContent)
        row:SetPoint("TOPLEFT", 0, y)
        row:SetSize(200, 20)

        row.pinIcon = row:CreateTexture(nil, "ARTWORK")
        row.pinIcon:SetSize(12, 12)
        row.pinIcon:SetPoint("LEFT", 2, 0)

        row.text = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.text:SetPoint("LEFT", 20, 0)
        row.text:SetText(note.title)

        if note.pinned then
            row.pinIcon:SetTexture("Interface\\COMMON\\Indicator-green")
        else
            row.pinIcon:SetTexture("Interface\\COMMON\\Indicator-gray")
        end

        row:SetScript("OnClick", function()
            tb.tnLoadNote(index)
        end)

        table.insert(tb.noteRows, row)
        y = y - 22
    end
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

-- texture de fond

local bg = tb.frame:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints()
bg:SetTexture("interface/framegeneral/ui-background-rock.blp")

---------------------------------
-- On rend la fenêtre déplaçable
--------------------------------

tb.frame:SetMovable(true)
tb.frame:EnableMouse(true)
tb.frame:RegisterForDrag("LeftButton")

tb.frame:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)

tb.frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)

----------------------------
--  un titre pour la fenêtre
----------------------------

tb.frame.title = tb.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
tb.frame.title:SetPoint("TOP", 0, -5)
tb.frame.title:SetText(tb.text.ADDON_TITLE.." v"..tb.version)

------------------------------------------------------------
-- LISTBOX (à gauche)
------------------------------------------------------------
tb.listFrame = CreateFrame("ScrollFrame", "tbListFrame", tb.frame, "UIPanelScrollFrameTemplate")
tb.listFrame:SetPoint("TOPLEFT", tb.frame, "TOPLEFT", 20, -60)
tb.listFrame:SetSize(200, 280)

tb.listContent = CreateFrame("Frame", nil, tb.listFrame)
tb.listContent:SetSize(200, 600)

-- Add a title
tb.listTitle = tb.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
tb.listTitle:SetText(tb.text.MY_NOTES)
tb.listTitle:SetPoint("BOTTOMLEFT", tb.listFrame, "TOPLEFT", 0, 10)

-- Add a background texture
local bg = tb.listContent:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints(tb.listContent) -- make it fill the frame
bg:SetColorTexture(0, 0, 0, 0.5) -- RGBA: black with 50% transparency

tb.listFrame:SetScrollChild(tb.listContent)

------------------------------------------------------------
-- Champ titre (à droite)
------------------------------------------------------------
tb.titleBox = CreateFrame("EditBox", "tbTitleBox", tb.frame, "InputBoxTemplate")
tb.titleBox:SetSize(400, 20)
tb.titleBox:SetPoint("TOPLEFT", tb.listFrame, "TOPRIGHT", 40, 0)
tb.titleBox:SetAutoFocus(false)
tb.titleBox:SetFontObject("GameFontNormal")

-- Add a background texture
local bg = tb.titleBox:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints(tb.titleBox) -- make it fill the frame
bg:SetColorTexture(0, 0, 0, 0.5) -- RGBA: black with 50% transparency

------------------------------------------------------------
-- Zone de texte (scrollable)
------------------------------------------------------------
tb.scrollFrame = CreateFrame("ScrollFrame", "tbScrollFrame", tb.frame, "UIPanelScrollFrameTemplate")
tb.scrollFrame:SetPoint("TOPLEFT", tb.titleBox, "BOTTOMLEFT", 0, -20)
tb.scrollFrame:SetPoint("BOTTOMRIGHT", tb.frame, "BOTTOMRIGHT", -40, 60)

tb.editBox = CreateFrame("EditBox", "tbEditBox", tb.scrollFrame)
tb.editBox:SetMultiLine(true)
tb.editBox:SetFontObject("GameFontNormal")

-- tb.editBox:SetWidth(400)
tb.editBox:SetWidth(tb.scrollFrame:GetWidth())

tb.editBox:SetHeight(800) 
tb.editBox:SetAutoFocus(false)

tb.editBox:SetScript("OnTextChanged", function()
    tb.noteModifiee = true
end)

tb.editBox:SetScript("OnCursorChanged", function(self, x, y, w, h)
    tb.scrollFrame:UpdateScrollChildRect()

    local scrollHeight = tb.scrollFrame:GetVerticalScrollRange()

    if y < -scrollHeight then
        tb.scrollFrame:SetVerticalScroll(scrollHeight)
    end
end)

tb.scrollFrame:SetScrollChild(tb.editBox)

-- test
tb.editBox:SetScript("OnEditFocusGained", function(self)
    if self.isPlaceholder then
        self:SetText("")
        self:SetTextColor(1, 1, 1)
        self.isPlaceholder = false
    end
end)
-- fin test

-- Add a background texture
local bg = tb.scrollFrame:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints(tb.scrollFrame) -- make it fill the frame
bg:SetColorTexture(0, 0, 0, 0.5) -- RGBA: black with 50% transparency

tb.scrollFrame:SetScrollChild(tb.editBox)

tb.editBox:SetText(tb.text.WELCOME)

-- Traitement de l'affichage des boutons

tb.CreationBoutons()
tb.mode = "LISTE"
tb.AfficherBoutons()

print("|cff00ff00"..tb.text.ADDON_TITLE.." :|r "..tb.text.CONSOLE_HELLO)