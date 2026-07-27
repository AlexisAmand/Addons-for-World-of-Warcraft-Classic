local Classifier = {}

function Classifier.Classify(itemID)
    return REAGENT_TO_PROF[itemID]
end

_G["Classifier"] = Classifier
