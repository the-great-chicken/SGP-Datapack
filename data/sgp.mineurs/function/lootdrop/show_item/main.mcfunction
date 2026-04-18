#> sgp.mineurs:lootdrop/show_item/main
#
# Puts the player's held item in the chat, for everyone to see
# We use bookshelf to show the actual translated item name if it's a vanilla one

scoreboard players reset @a[scores={sgp.share_item=1..}] sgp.share_item

data remove storage sgp:macro item_hover
data remove storage sgp:macro item_name
data remove storage sgp:macro item_id_dot

data modify storage sgp:macro item_hover set from entity @s SelectedItem

# Utiliser Bookshelf pour remplacer le ":" par un "." dans l'ID
data modify storage bs:in string.replace.str set from storage sgp:macro item_hover.id
data modify storage bs:in string.replace.old set value ":"
data modify storage bs:in string.replace.new set value "."
data modify storage bs:in string.replace.maxreplace set value 1
function #bs.string:replace

# Récupérer le résultat (ex: "minecraft.diamond_sword") et construire le nom de base
data modify storage sgp:macro item_id_dot set from storage bs:out string.replace
execute if data storage sgp:macro item_id_dot run function sgp.mineurs:lootdrop/show_item/build_fallback_name with storage sgp:macro

# Écraser avec item_name explicite si présent (géré par le jeu)
execute if data storage sgp:macro item_hover.components."minecraft:item_name" run data modify storage sgp:macro item_name set from storage sgp:macro item_hover.components."minecraft:item_name"

# Écraser avec custom_name si l'item a été renommé dans une enclume (priorité absolue)
execute if data storage sgp:macro item_hover.components."minecraft:custom_name" run data modify storage sgp:macro item_name set from storage sgp:macro item_hover.components."minecraft:custom_name"

execute if data storage sgp:macro item_hover run data modify storage sgp:macro item_hover.action set value "show_item"
execute if data storage sgp:macro item_hover run function sgp.mineurs:lootdrop/show_item/chat_sent_macro with storage sgp:macro

execute unless data storage sgp:macro item_hover run tellraw @s {"text": "Tu n'es pas en train de tenir un item !", "color": "red"}