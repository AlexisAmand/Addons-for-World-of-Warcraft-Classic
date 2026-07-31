tb = tb or {}

tb.text = {}

-- divers

tb.text.NO_TITLE_01 = "no-title"

-- interface

tb.text.MY_NOTES = "My Notes :"
tb.text.NO_NOTE_YET = "Aucune note pour l’instant..."
tb.text.WELCOME = "Welcome in Traveler's Notebook !"
tb.text.BUTTON_NEW = "New"
tb.text.BUTTON_NEW_HELP = "Create a new note"
tb.text.BUTTON_SAVE = "Save"
tb.text.BUTTON_SAVE_HELP = "Save current note"
tb.text.BUTTON_DEL = "Delete"
tb.text.BUTTON_DEL_HELP = "Delete this note" 
tb.text.BUTTON_ABOUT = "About"
tb.text.BUTTON_ABOUT_HELP = "About this addon"
tb.text.BUTTON_INSERT = "Insert"
tb.text.BUTTON_INSERT_HELP = "Afficher le sous menu"
tb.text.BUTTON_HIDE = "Hide"
tb.text.BUTTON_HIDE_HELP = "Hide this windows"
tb.text.BUTTON_RETURN = "Return"
tb.text.BUTTON_RETURN_HELP = "Close this note"
tb.text.BUTTON_PIN = "Pin"
tb.text.BUTTON_PIN_HELP = "Pin current note"
tb.text.BUTTON_UNPIN = "Unpin"
tb.text.BUTTON_UNPIN_HELP = "Unpin current note"
tb.text.BUTTON_GPS ="GPS"
tb.text.BUTTON_GPS_HELP ="Insert la position X,Y du joueur"
tb.text.BUTTON_TIME ="Time"
tb.text.BUTTON_TIME_HELP ="Insert l'heure courante"
tb.text.BUTTON_DATE ="Date"
tb.text.BUTTON_DATE_HELP ="Insert la date courante"
tb.text.BUTTON_ZONE ="Zone"
tb.text.BUTTON_ZONE_HELP ="Insert le nom de la position du joueur"
tb.text.BUTTON_LINE ="Line"
tb.text.BUTTON_LINE_HELP ="Insert une ligne horizontale"
tb.text.BUTTON_PNJ ="PNJ"
tb.text.BUTTON_PNJ_HELP ="Insert le nom du PNJ selection"

-- logs dans le console

tb.text.CONSOLE_HELLO = "Hello there !"
tb.text.CONSOLE_HIDE_01 = "Until next time, adventurer!"
tb.text.CONSOLE_HIDE_02 = "See you later !"
tb.text.CONSOLE_SHOW_01 = "A new adventure begins!"
tb.text.CONSOLE_SHOW_02 = "A new journey begins!"
tb.text.CONSOLE_SAVE_01 = "Notes saved."
tb.text.CONSOLE_DELETE = "This page has been removed."
tb.text.CONSOLE_PIN = "A page worth remembering!"
tb.text.CONSOLE_UNPIN = "This page is no longer marked."
tb.text.CONSOLE_NOTARGET = "No target selected"

-- création d'une note

tb.text.ENTER_TITLE = "Enter the title here"
tb.text.ENTER_CONTENT = "And here the content"

-- messages

tb.text.NO_TITLE = "Unable to save: no title."
tb.text.NO_MSG = "Unable to del: no message."
tb.text.NO_PNJ = "Oups. Pas de PNJ selectionné !"
tb.text.NO_NOTE_DELETE ="No notes to delete."
tb.text.BUTTON_CLOSE = "Close"
tb.text.MSG_TITLE = "Message"
tb.text.SAVE_OK = "The note has been saved successfully!"
tb.text.DEL_OK = "The note has been deleted."

-- the addon

tb.text.ADDON_TITLE = "Traveler's Notebook"
tb.version = C_AddOns.GetAddOnMetadata("TravelersNoteBook", "Version")
tb.text.AUTHOR = C_AddOns.GetAddOnMetadata("TravelersNoteBook", "Author")
tb.text.ICON_TOOLTIP = "Clic to open "..tb.text.ADDON_TITLE
tb.text.ADDON_LOADED = tb.text.ADDON_TITLE.." loaded"