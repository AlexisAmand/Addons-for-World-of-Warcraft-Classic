    -------------------
    -- Proverbes gnomes 
    -------------------

WOW_QUOTES_GNOME = {
    "Un gnome ne tombe jamais… il teste la gravité. (proverbe Gnome)",
    "Si ça explose, c’est que ça fonctionne. (proverbe Gnome)",
    "La taille n’a pas d’importance, sauf quand il faut atteindre une étagère. (proverbe Gnome)",
    "Les Titans ont créé les gnomes. Les gnomes ont créé les problèmes. (proverbe Gnome)",
    "Un gnome, c'est un nain qui a eu l'idée de se raser. (proverbe Gnome)",
    "Gnome qui roule n'amasse pas mousse. (proverbe Gnome)",
}

    ----------------------
    -- Proverbes pandarens 
    ----------------------

WOW_QUOTES_PANDAREN = {
    "la sagesse commence toujours par un bon repas. (proverbe Pandaren)",
    "Quand le ventre parle, l'esprit écoute. (proverbe Pandaren)",
    "Le chemin vers l'équilibre passe souvent par la cuisine. (proverbe Pandaren)",
    "Un pandaren affamé n'est sage qu'à moitié. (proverbe Pandaren)",
    "La bave du gnome n'atteint pas le pandaren. (proverbe Pandaren)",
}

    -----------------
    -- Proverbes elfs 
    -----------------

WOW_QUOTES_ELF = {
    "Nous vivons très longtemps, sauf accident. (proverbe elfique)",
}

    -------------------
    -- Proverbes trolls
    -------------------

WOW_QUOTES_TROLL = {
    "Traitre qui parlemente, est bien près de se faire fendre. (proverbe Troll)",
}

    -----------------
    -- Proverbes orcs 
    -----------------

WOW_QUOTES_ORC = {
    "Nous être accident ! (proverbe orc)",
    "Entre la hache et le bouclier, il ne faut pas mettre le doigt. (proverbe orc)",
    "De la parole à l'action, le chemin est long, c'est pourquoi nous tapons,et ensuite posons les questions. (proverbe orc)",
    "On ne meurt que deux fois. (proverbe mort-vivant)",
}

    --------------------------
    -- Proverbes morts-vivants 
    --------------------------

WOW_QUOTES_UNDEAD = {
    "Si vous n'avez pas peur, vous êtes déjà mort. (proverbe mort-vivant)",
}

    ------------------
    -- Proverbes nains
    ------------------

WOW_QUOTES_DWARF = {
    "Coffre ouvert, rend le nain pervers. (proverbe nain)",
    "Mieux vaux être mal connu qu'être un nain connu. (proverbe nain)",
    "Ne te demandes pas ce que ton peuple peut faire pour toi mais plutôt ce que les nains peuvent faire pour ton peuple. (proverbe nain)",
}

    --------------------------------------------------------------------
    -- Fusionner tous les proverbes dans une seule table
    --------------------------------------------------------------------

WOW_QUOTES = {}

for name, tab in pairs(_G) do
    if name:match("^WOW_QUOTES_") then
        for _, q in ipairs(tab) do
            table.insert(WOW_QUOTES, q)
        end
    end
end









