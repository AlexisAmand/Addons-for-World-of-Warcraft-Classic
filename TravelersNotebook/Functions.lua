tb = tb or {}

-------------------------------------
-- Le bouton flottant quand on clique
-------------------------------------

function tb.Toggle()
    if tb.frame:IsShown() then
        tb.frame:Hide()
        print("|cff00ff00"..tb.text.ADDON_TITLE.." :|r "..tb.text.CONSOLE_HIDE_01)
    else
        tb.mode = "LISTE"
        tb.AfficherBoutons()
        tb.frame:Show()
        print("|cff00ff00"..tb.text.ADDON_TITLE.." :|r "..tb.text.CONSOLE_SHOW_01)
    end
end

-------------------------------
-- Charger une note de la liste
--------------------------------

function tb.tnLoadNote(index)
    tb.currentIndex = index
    tb.titleBox:SetText(tb.notes[index].title)
    tb.editBox:SetText(tb.notes[index].content)
    tb.mode = "EDITION"
    tb.AfficherBoutons()

    if not tb.notes[index].color then
        tb.notes[index].color = {1, 0.82, 0}
    end

    tb.editBox:SetTextColor(tb.notes[index].color[1], tb.notes[index].color[2], tb.notes[index].color[3])

    if tb.notes[index].pinned then
        tb.pinButton:SetText(tb.text.BUTTON_UNPIN)
    else
        tb.pinButton:SetText(tb.text.BUTTON_PIN)
    end
end

-------------------------------
-- Création d'une nouvelle note
-------------------------------

function tb.tnNewNote()
    tb.currentIndex = nil
    tb.titleBox:SetText(tb.text.ENTER_TITLE)
    tb.editBox:SetText(tb.text.ENTER_CONTENT)
    tb.mode = "EDITION"
    tb.AfficherBoutons()
    print("|cff00ff00"..tb.text.ADDON_TITLE.." :|r "..tb.text.CONSOLE_SHOW_02)
end

-----------------------------------------------------
-- Sauvegarde manuellement la note en cours d'édition
-- C'est ici que le tableau est agrandi de +1
-----------------------------------------------------

function tb.tnSaveNote()
    local titre = tb.titleBox:GetText()
    local contenu = tb.editBox:GetText()

    if titre == "" then
        print(tb.text.NO_TITLE)
        tnshowNoTitle()
        return
    end

    if not tb.currentIndex then
        tb.currentIndex = #tb.notes + 1
        tb.notes[tb.currentIndex] = {}
    end

    tb.notes[tb.currentIndex].title = titre
    tb.notes[tb.currentIndex].content = contenu
    tb.notes[tb.currentIndex].created = time()
    TBSaved = TBSaved or {}
    TBSaved.notes = tb.notes
    tnshowSaved()
    print("|cff00ff00"..tb.text.ADDON_TITLE.." :|r "..tb.text.CONSOLE_SAVE_01)
    tb.tnRefreshList()
end

---------------------------------------------
-- Sauvegarde auto la note en cours d'édition
-- C'est ici que le tableau est agrandi de +1
---------------------------------------------

function tb.tnSaveAutoNote()
    tb.notes = tb.notes or {}

    local titre = tb.titleBox:GetText()
    local contenu = tb.editBox:GetText()

    if titre == tb.text.ENTER_TITLE and contenu == tb.text.ENTER_CONTENT then
        return
    end

    if not titre or titre:match("^%s*$") then
        titre = tb.text.NO_TITLE_01
        tb.notes[tb.currentIndex].title = titre
    end

    if not tb.currentIndex then
        tb.currentIndex = #tb.notes + 1
        tb.notes[tb.currentIndex] = {}
    end

    if tb.notes[tb.currentIndex].pinned == nil then
        tb.notes[tb.currentIndex].pinned = false
    end

    tb.notes[tb.currentIndex].title = titre
    tb.notes[tb.currentIndex].content = contenu
    tb.notes[tb.currentIndex].created = time()
    TBSaved = TBSaved or {}
    TBSaved.notes = tb.notes
    print("|cff00ff00"..tb.text.ADDON_TITLE.." :|r "..tb.text.CONSOLE_SAVE_01)
    tb.tnRefreshList()
end

----------------------------
-- Affiche le nom de la zone
----------------------------

function tb.nomZone()

    local mapID = C_Map.GetBestMapForUnit("player")
    local zone = C_Map.GetMapInfo(mapID)
    local subZoneName = GetSubZoneText()
    local nomLieu = zone.name

    if subZoneName ~= "" and subZoneName ~= zone.name then
        nomLieu = string.format(
            "%s (%s)",
            subZoneName,
            zone.name
        )
    end

    if zone then
        local position = C_Map.GetPlayerMapPosition(mapID, "player")

        if position then

            local texte = string.format(
                "[%s]",
                nomLieu
            )

            tb.editBox:Insert(texte)
        end
    end
    tb.insertMenu:Hide()
end

--------------------------------------
-- Supprime la note en cours d'édition
--------------------------------------

function tb.tnDeleteNote()
    if not tb.currentIndex then
        print(tb.text.NO_NOTE_DELETE)
        tnshowNoNote()
        return
    end

    table.remove(tb.notes, tb.currentIndex)
    tb.currentIndex = nil

    tb.titleBox:SetText(tb.text.ENTER_TITLE)
    tb.editBox:SetText(tb.text.ENTER_CONTENT)

    tnshowDeleted()
    print("|cff00ff00"..tb.text.ADDON_TITLE.." :|r "..tb.text.CONSOLE_DELETE)
    tb.tnRefreshList()
    -- tb.closeNote()
end

-----------------------------------
-- Ferme la note en cours d'édition
------------------------------------

function tb.closeNote()
    tb.tnSaveAutoNote()
    tb.mode = "LISTE"
    tb.AfficherBoutons()
    tb.insertMenu:Hide()
    tb.titleBox:SetText(tb.text.TEMP_TITLE)
    tb.editBox:SetText(tb.text.TEMP_CONTENT)
end

------------------------------------------
-- (des)épingle la note en cours d'édition
------------------------------------------

function tb.pinNote()

    if tb.currentIndex then
        local note = tb.notes[tb.currentIndex]

        if note then
            note.pinned = not (note.pinned == true)
            TBSaved.notes = tb.notes
            tb.tnRefreshList()
        end

        if note.pinned then
            print("|cff00ff00"..tb.text.ADDON_TITLE.." :|r "..tb.text.CONSOLE_PIN)
            tb.pinButton:SetText(tb.text.BUTTON_UNPIN)
        else
            print("|cff00ff00"..tb.text.ADDON_TITLE.." :|r "..tb.text.CONSOLE_UNPIN)
            tb.pinButton:SetText(tb.text.BUTTON_PIN)
        end

    end
    tb.editMenu:Hide()
end

-----------
-- À propos
-----------

function tb.tnAboutWindows()
    tnshowAbout()
end

-------------------------------
-- Cacher la fenêtre principale
-------------------------------

function tb.tnHideWindows()
    if tb.frame:IsShown() then
        tb.mode = "LISTE"
        tb.AfficherBoutons()
        tb.frame:Hide()  
        tb.insertMenu:Hide()  
        print("|cff00ff00"..tb.text.ADDON_TITLE.." :|r "..tb.text.CONSOLE_HIDE_02)
    end
end

------------------
-- Affiche l'heure
------------------

function tb.AddTime()
    local heure = date("%X")
    tb.editBox:Insert(heure)
    tb.insertMenu:Hide()
end

------------------
-- Affiche la date
------------------

function tb.AddDate()
    local currentDate = date("%x")
    tb.editBox:Insert(currentDate)
    tb.insertMenu:Hide()
end

-----------------------------
-- Affiche les X,Y de la zone
-----------------------------

function tb.CoordGPS()

    local mapID = C_Map.GetBestMapForUnit("player")
    local zone = C_Map.GetMapInfo(mapID)
    local subZoneName = GetSubZoneText()
    local nomLieu = zone.name

    if zone then
        local position = C_Map.GetPlayerMapPosition(mapID, "player")

        if position then
            local x, y = position:GetXY()

            local texte = string.format(
                "%.1f, %.1f",
                x * 100,
                y * 100
            )

            tb.editBox:Insert(texte)
        end
    end
    tb.insertMenu:Hide()
end

-----------------------
-- Ajoute un séparateur
-----------------------

function tb.addSeparator()
    tb.editBox:Insert("\n--------------------------------------------------------------\n")
    tb.insertMenu:Hide()
end 

--------------------------------
-- Ajoute le nom d'un PNJ ciblé
--------------------------------

function tb.afficheTarget()
    local nom = UnitName("target")

    if nom then
        tb.editBox:Insert(nom)
    else
        tnNoPnjSelected()
        print("|cff00ff00"..tb.text.ADDON_TITLE.." :|r "..tb.text.CONSOLE_NOTARGET)
    end
end

------------------------------
-- Ajoute le combo PNJ + Place
------------------------------

function tb.comboLocation()
    local mapID = C_Map.GetBestMapForUnit("player")
    local zone = C_Map.GetMapInfo(mapID)
    local subZoneName = GetSubZoneText()
    local nomLieu = zone.name

    if subZoneName ~= "" and subZoneName ~= zone.name then
        nomLieu = string.format(
            "[%s (%s)]",
            subZoneName,
            zone.name
        )
    end

    if zone then
        local position = C_Map.GetPlayerMapPosition(mapID, "player")

        if position then
            local x, y = position:GetXY()

            local texte = string.format(
                "%s %.1f, %.1f",
                nomLieu,
                x * 100,
                y * 100
            )

            tb.editBox:Insert(texte)
        end
    end
    tb.insertMenu:Hide()
end

-------------------------------
-- couleur de la zone d'édition
-------------------------------

function tb.choisirColor(couleur)
    tb.editBox:SetTextColor(couleur[1], couleur[2], couleur[3])

    if tb.currentIndex and tb.notes[tb.currentIndex] then
        tb.notes[tb.currentIndex].color = couleur
        tb.editMenu:Hide()
    end
end
