fa = fa or {}
fa.nbclic = 0
fa.uniteMetrique = true

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

    for _, achievement in ipairs(fa.achievements) do
        if FASaved.FeetOfAzerothDB.achievements[achievement.id] == nil then
            FASaved.FeetOfAzerothDB.achievements[achievement.id] = false
        end
    end

    fa.creationFenetre()
    fa.demarrerPodometre()
end)
