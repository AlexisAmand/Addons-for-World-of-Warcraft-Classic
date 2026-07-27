GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
    local _, link = tooltip:GetItem()
    if not link then return end

    local itemID = tonumber(link:match("item:(%d+)"))
    if not itemID then return end

    local prof = Classifier.Classify(itemID)
    if not prof then return end

    tooltip:AddLine("|cffffd100" .. prof .. "|r")
end)
