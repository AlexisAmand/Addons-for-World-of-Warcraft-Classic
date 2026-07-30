tb = tb or {}

-------------------------------------
-- Le bouton flottant quand on clique
-------------------------------------

function tb.Toggle()
    if tb.frame:IsShown() then
        tb.frame:Hide()
        print("|cff00ff00Traveler's Notebook :|r Until next time, adventurer!")
    else
        tb.mode = "LISTE"
        tb.AfficherBoutons()
        tb.frame:Show()
        print("|cff00ff00Traveler's Notebook :|r A new adventure begins!")
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

    if tb.notes[index].pinned then
        tb.pinButton:SetText("Unpin")
    else
        tb.pinButton:SetText("Pin")
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
    print("|cff00ff00Traveler's Notebook :|r A new journey begins!")
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
    TBSaved = TBSaved or {}
    TBSaved.notes = tb.notes
    tnshowSaved()
    print("|cff00ff00Traveler's Notebook :|r Notes saved.")
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
        titre = "no-title"
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
    TBSaved = TBSaved or {}
    TBSaved.notes = tb.notes
    print("|cff00ff00Traveler's Notebook :|r Notes saved.")
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

    tb.titleBox:SetText("Enter the title here")
    tb.editBox:SetText("And here the content")

    tnshowDeleted()
    print("|cff00ff00Traveler's Notebook :|r This page has been removed.")
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
            print("|cff00ff00Traveler's Notebook :|r A page worth remembering!")
            tb.pinButton:SetText("Unpin")
        else
            print("|cff00ff00Traveler's Notebook :|r This page is no longer marked.")
            tb.pinButton:SetText("Pin")
        end

    end
    tb.insertMenu:Hide()
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
        print("|cff00ff00Traveler's Notebook :|r See you later !")
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