-------------------------------------
-- Le bouton flottant quand on clique
-------------------------------------

function tb.Toggle()
    if tb.frame:IsShown() then
        tb.frame:Hide()
    else
        tb.mode = "EDITION"
        tb.AfficherBoutons()
        tb.frame:Show()
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
    TBSaved.notes = tb.notes
    tnshowSaved()
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

    if titre == "" then
        print(tb.text.NO_TITLE)
        tnshowNoTitle()
        return
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
    TBSaved.notes = tb.notes
    print("|cff00ff00Traveler's Notebook :|r sauvegarde automatique")
    tb.tnRefreshList()
end

-------------------------
-- Affiche les coords X,Y
-------------------------

function tb.CoordGPS()

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
            local x, y = position:GetXY()

            local texte = string.format(
                "[%s] %.1f, %.1f",
                nomLieu,
                x * 100,
                y * 100
            )

            tb.editBox:Insert(texte)
        end
    end

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

    tb.titleBox:SetText("")
    tb.editBox:SetText("")

    tnshowDeleted()
    tb.tnRefreshList()
end

-----------------------------------
-- Ferme la note en cours d'édition
------------------------------------

function tb.closeNote()
    print("fermeture de la note")
    tb.tnSaveAutoNote()
    tb.mode = "LISTE"
    tb.AfficherBoutons()
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
            tb.pinButton:SetText("Unpin")
        else
            tb.pinButton:SetText("Pin")
        end

    end

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
        print("Hide - Mode actuel :", tb.mode)
    end
end

