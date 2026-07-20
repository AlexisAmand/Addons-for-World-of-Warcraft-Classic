-----------------------------------------
-- fonction qui affiche une fenêtre about
-----------------------------------------

function showAbout()

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
    "- Les gemmes ne sont pas comestibles.\n"..
    "- The Gust button doesn’t actually make any wind.\n"..
    "- No pandaren were harmed during development.\n"..
    "- The developer survived three cold coffees.\n"
    )

    optionsFrame:Show()

    -- Exemple : bouton pour fermer
    local closeButton = CreateFrame("Button", nil, optionsFrame, "UIPanelButtonTemplate")
    closeButton:SetSize(80, 25)
    closeButton:SetPoint("BOTTOM", 0, 10)
    closeButton:SetText("Fermer")
    closeButton:SetScript("OnClick", function()
        optionsFrame:Hide()
    end)

end

-------------------------------------------------
-- fonction qui remet à zéro le record sauvegardé
-------------------------------------------------

function resetGame()
    Gasp.record = 0
    GaspSaved.record = 0
    Gasp.frame.coups:SetText("Moves : "..Gasp.nbCoups.."   Record : "..Gasp.GetRecordText())
    print("Scores réinitialisés.")
end

--------------------------------------------------
-- Une commande pour la console affiche la fenêtre
--------------------------------------------------

SLASH_GASP1 = "/gaspofpandaria"

SlashCmdList["GASP"] = function(msg)
    if msg == "" then
        -- Pas d’argument → on ouvre la fenêtre principale
        Gasp.frame:Show()
        return
    end

    if msg == "reset" then
        resetGame()
        return
    end

    if msg == "about" then
        showAbout()
        return
    end

    print(“Available commands:”)
    print(“/gasp about  - open about”)
    print(“/gasp reset    - reset the score”)
end