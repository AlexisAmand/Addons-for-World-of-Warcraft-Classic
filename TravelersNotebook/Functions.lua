-------------------------------
-- Charger une note de la liste
--------------------------------

function tb.tnLoadNote(index)
    tb.currentIndex = index
    tb.titleBox:SetText(tb.notes[index].title)
    tb.editBox:SetText(tb.notes[index].content)
    tb.mode = "EDITION"
    tb.AfficherBoutons()
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

----------------------------------------
-- Sauvegarde la note en cours d'édition
----------------------------------------

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

