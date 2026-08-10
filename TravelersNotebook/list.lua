------------------------------------------
-- LISTBOX : rafraîchir la liste des notes
------------------------------------------

function tb.tnRefreshList()

    local sortedNotes = {}

    -- Effacer les anciennes lignes
    
    for _, row in ipairs(tb.noteRows) do
        row:Hide()
    end
    tb.noteRows = {}

    -- tri date croissante

    if tb.sortMode == "TC" then
        table.sort(tb.notes, function(a, b)
            if not a.created then
                return false
            end

            if not b.created then
                return true
            end

            return a.created > b.created
        end)
    end

    -- tri date décroissante

    if tb.sortMode == "TD" then
        table.sort(tb.notes, function(a, b)
            if not a.created then
                return false
            end

            if not b.created then
                return true
            end

            return a.created < b.created
        end)
    end

    -- tri Z..A

    if tb.sortMode == "ZA" then
        table.sort(tb.notes, function(a, b)
            return string.lower(a.title) > string.lower(b.title)
        end)
    end

    -- tri A..Z

    if tb.sortMode == "AZ" then
        table.sort(tb.notes, function(a, b)
            return string.lower(a.title) < string.lower(b.title)
        end)
    end

    -- On met les éléments triés dans la liste "logique"

    if tb.sortMode == "D" then -- tri par défaut

        -- D'abord les notes épinglées
        for index, note in ipairs(tb.notes) do
            if note.pinned and tb.noteCorrespond(note, tb.recherche or "") then
                table.insert(sortedNotes, {
                    index = index,
                    note = note
                })
            end
        end

        -- Ensuite les notes normales
        for index, note in ipairs(tb.notes) do
            if not note.pinned and tb.noteCorrespond(note, tb.recherche or "") then
                table.insert(sortedNotes, {
                    index = index,
                    note = note
                })
            end
        end

    else

        -- AZ ou ZA
        for index, note in ipairs(tb.notes) do
            if tb.noteCorrespond(note, tb.recherche or "") then
                table.insert(sortedNotes, {
                    index = index,
                    note = note
                })
            end
        end

    end

    -- et maintenant, on les mets dans la liste qui s'affiche

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