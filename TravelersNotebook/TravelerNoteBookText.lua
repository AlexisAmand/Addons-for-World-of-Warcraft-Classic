tb = tb or {}

tb.text = {}

-- interface

tb.text.MY_NOTES = "My Notes :"
tb.text.NO_NOTE_YET = "Aucune note pour l’instant..."
tb.text.WELCOME = "Welcome in Traveler's Notebook !"
tb.text.BUTTON_NEW = "New"
tb.text.BUTTON_SAVE = "Save"
tb.text.BUTTON_DEL = "Delete"
tb.text.BUTTON_ABOUT = "About"
tb.text.RECORD_LVL1 = "Level 1 Wisdom"
tb.text.RECORD_LVL2 = "Level 2 Wisdom"
tb.text.RECORD_LVL3 = "Level 3 Wisdom"

-- création d'une note

tb.text.ENTER_TITLE = "Enter the title"
tb.text.ENTER_CONTENT = "And here the content"

-- messages

tb.text.NO_TITLE = "Unable to save: no title."
tb.text.NO_MSG = "Unable to del: no message."
tb.text.NO_NOTE_DELETE ="No notes to delete."
tb.text.BUTTON_CLOSE = "Close"
tb.text.MSG_TITLE = "Message"
tb.text.SAVE_OK = "The note has been saved successfully!"
tb.text.DEL_OK = "The note has been deleted."

-- the addon

tb.text.ADDON_TITLE = "Traveler's Notebook"
tb.version = C_AddOns.GetAddOnMetadata("TravelersNoteBook", "Version")
tb.text.AUTHOR = C_AddOns.GetAddOnMetadata("TravelersNoteBook", "Author")
tb.text.ICON_TOOLTIP = "Clic to open Traveler's Notebook"
tb.text.ADDON_LOADED = "Traveler's Notebook loaded"