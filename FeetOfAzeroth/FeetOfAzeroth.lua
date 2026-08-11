fa = fa or {}
fa.nbclic = 0
fa.uniteMetrique = true

-------------------------------
-- récupération des sauvegardes
-- et initialisation de l'addon
-------------------------------

local loader = CreateFrame("Frame")

loader:RegisterEvent("ADDON_LOADED")

loader:SetScript("OnEvent", function(self, event, addonName)
    if addonName ~= "FeetOfAzeroth" then
        return
    end

    FASaved = FASaved or {}
    FASaved.FeetOfAzerothDB = FASaved.FeetOfAzerothDB or {}

    fa.distanceSession = 0
    fa.distanceTotal = FASaved.FeetOfAzerothDB.distanceTotal or 0

    fa.creationFenetre()
    fa.demarrerPodometre()
end)
