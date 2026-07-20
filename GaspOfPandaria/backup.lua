-- Gestion des sauvegardes

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")

loader:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "GaspOfPandaria" then
        
        -- Chargement des sauvegardes
        GaspSaved = GaspSaved or {}

        -- Record
        Gasp.record = GaspSaved.record or nil

        -- Si une grille sauvegardée existe, on la restaure
        if GaspSaved.grille then
            Gasp.grille = {}

            for y = 0, Gasp.niveau do
                Gasp.grille[y] = {}
                for x = 0, Gasp.niveau do
                    Gasp.grille[y][x] = GaspSaved.grille[y][x]
                end
            end

            -- Restaurer le nombre de coups
            Gasp.nbCoups = GaspSaved.nbCoups or 0
 
        else
            -- Sinon, nouvelle grille
            Gasp.CreerGrille()
            Gasp.nbCoups = 0
        end

        -- Mise à jour visuelle si l'UI existe déjà
        if Gasp.frame and Gasp.frame.coups then
            Gasp.frame.coups:SetText("Moves : "..Gasp.nbCoups.."  Record : "..Gasp.GetRecordText())
        end

        -- Mise à jour des boutons si déjà créés
        if Gasp.boutons then
            for y = 0, Gasp.niveau do
                for x = 0, Gasp.niveau do
                    Gasp.UpdateButton(x, y)
                end
            end
        end
    end
end)