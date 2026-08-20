fa = fa or {}
fa.nbclic = 3
fa.taux = 0.9144

SLASH_FATEST1 = "/fatest"

SlashCmdList["FATEST"] = function()
    fa.distanceTotal = 1000
    fa.validationAchievements()
end

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
    FASaved.FeetOfAzerothDB.achievements = FASaved.FeetOfAzerothDB.achievements or {}
    
    fa.distanceSession = 0
    fa.distanceTotal = FASaved.FeetOfAzerothDB.distanceTotal or 0
    fa.restAFK = FASaved.FeetOfAzerothDB.restAFK or 0
    fa.ghostTime = FASaved.FeetOfAzerothDB.ghostTime or 0
    fa.recordVitesse = FASaved.FeetOfAzerothDB.recordVitesse or 0
    
    if FASaved.FeetOfAzerothDB.uniteMetrique == nil then
        fa.uniteMetrique = true
    else
        fa.uniteMetrique = FASaved.FeetOfAzerothDB.uniteMetrique
    end

    for _, achievement in ipairs(fa.achievements) do
        if FASaved.FeetOfAzerothDB.achievements[achievement.id] == nil then
            FASaved.FeetOfAzerothDB.achievements[achievement.id] = false
        end
    end

    fa.creationFenetre()
    fa.demarrerPodometre()
end)

print("|cff00ff00"..fa.ADDON_TITLE.." :|r "..fa.CSL_READY)