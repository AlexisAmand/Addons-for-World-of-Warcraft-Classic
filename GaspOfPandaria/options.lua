-----------------------------------------
-- fonction qui affiche une fenêtre about
-----------------------------------------

function showGaspAbout()

    local optionsFrame = CreateFrame("Frame", "GaspOptions", UIParent, "BasicFrameTemplateWithInset")

    optionsFrame:SetFrameStrata("DIALOG")
    optionsFrame:SetFrameLevel(Gasp.frame:GetFrameLevel() + 10)

    optionsFrame:SetSize(350, 250)
    optionsFrame:SetPoint("CENTER")
    
    optionsFrame.title = optionsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    optionsFrame.title:SetPoint("TOP", 0, -5)
    optionsFrame.title:SetText("About")

    optionsFrame.text = optionsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    optionsFrame.text:SetPoint("TOPLEFT", 15, -40)
    optionsFrame.text:SetJustifyH("LEFT")
    optionsFrame.text:SetText(
    "Gasp of Pandaria\n"..
    "Version "..Gasp.version.."\n"..
    "By Hanslex\n\n"..
    "Development Notes :\n"..
    "- Gems are not edible.\n"..
    "- The Gust button doesn’t actually make any wind.\n"..
    "- No pandaren were harmed during development.\n"..
    "- The developer survived three cold coffees.\n"
    )

    optionsFrame:Show()

    -- Exemple : bouton pour fermer
    local closeButton = CreateFrame("Button", nil, optionsFrame, "UIPanelButtonTemplate")
    closeButton:SetSize(80, 25)
    closeButton:SetPoint("BOTTOM", 0, 10)
    closeButton:SetText("Close")
    closeButton:SetScript("OnClick", function()
        optionsFrame:Hide()
    end)

end

-------------------------------------------------
-- fonction qui remet à zéro le record sauvegardé
-------------------------------------------------

function resetGaspGame()
    Gasp.record = 0
    GaspSaved.records[math.floor(Gasp.niveau/2)] = 0
    Gasp.frame.coups:SetText("Moves : 0  Wisdom of level "..math.floor(Gasp.niveau/2).." : "..Gasp.GetRecordText())
    print("Scores have been reset.")
end

--------------------------------------------------
-- Une commande pour la console affiche la fenêtre
--------------------------------------------------

SLASH_GASP1 = "/gaspofpandaria"

SlashCmdList["GASP"] = function(msg)
    if msg == "" then
        -- Pas d’argument → on ouvre la fenêtre principale
        Gasp.frame:Show()
        -- Charger le record du niveau actuel
        Gasp.record = GaspSaved.records and GaspSaved.records[math.floor(Gasp.niveau/2)] or nil
        GaspSaved.record = nil

        if GaspSaved.grille then
            local savedMessages = {
                "A saved game was found.\nYour puzzle awaits.",
                "Your previous game has been recovered.\nShall we continue?",
                "The gems remember you.\nResume your journey?"
            }

            local msg = savedMessages[math.random(#savedMessages)]
            StaticPopupDialogs["SAVED_GAME"].text = msg

            StaticPopup_Show("SAVED_GAME")
        end
        return
    end

    if msg == "reset" then
        resetGaspGame()
        return
    end

    if msg == "about" then
        showGaspAbout()
        return
    end

    print("Available commands:")
    print("/gasp about  - open about")
    print("/gasp reset    - reset the score")
end