REAGENT_TO_PROF = {}

local modules = {
    REAGENT_TO_PROF_ALCH,
    REAGENT_TO_PROF_BS,
    REAGENT_TO_PROF_TAIL,
    REAGENT_TO_PROF_LW,
    REAGENT_TO_PROF_ENG,
    REAGENT_TO_PROF_INS,
    REAGENT_TO_PROF_JC,
    REAGENT_TO_PROF_ENCH,
    REAGENT_TO_PROF_COOK,
}

for _,mod in ipairs(modules) do
    for itemID, prof in pairs(mod) do
        REAGENT_TO_PROF[itemID] = prof
    end
end
