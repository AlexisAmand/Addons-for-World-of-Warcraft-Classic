-- popup rules

StaticPopupDialogs["GASP_REGLES"] = {
    text = "Ah, young adventurer… Tea will come later.\nFor now, observe.\nClick on a gem to flip the ones around it.\nYour goal is to flip every gem.\nDo not rush. Patience is a strength.",
    button1 = "OK",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,

    OnShow = function(self)
        self:ClearAllPoints()
        self:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    end,
}

-- popup si on a gagné !

StaticPopupDialogs["GASP_VICTOIRE"] = {
    text = "", -- sera remplacé dans OnShow
    button1 = "OK",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,

    OnAccept = function()

        -- mise à jour du record
        if not Gasp.record or Gasp.nbCoups < Gasp.record then
            Gasp.record = Gasp.nbCoups
            GaspSaved.record = Gasp.record
        end

        Gasp.CreerGrille()      -- recrée la grille
        Gasp.nbCoups = 0        -- remet le compteur à zéro
        Gasp.frame.coups:SetText("Moves : 0  Record : "..Gasp.GetRecordText())  -- met à jour l'affichage
        
        -- Et si tu veux, tu peux aussi rafraîchir les boutons :
        for y = 0, 3 do
            for x = 0, 3 do
                Gasp.UpdateButton(x, y)
            end
        end

    end,

    OnShow = function(self)
        if Gasp.nbCoups <= 10 then
            self.Text:SetText("Swift as a breeze, young adventurer! Only "..Gasp.nbCoups.." moves ! The tea barely had time to steep.")
        elseif Gasp.nbCoups <= 20 then
            self.Text:SetText("Good work, young adventurer! "..Gasp.nbCoups.."  moves. The tea is warm… unlike your thinking.")
        else
            self.Text:SetText("A long journey, young adventurer… "..Gasp.nbCoups.."  moves. Fortunately, tea tastes better when it waits.")
        end

        self:ClearAllPoints()
        self:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    end,
}