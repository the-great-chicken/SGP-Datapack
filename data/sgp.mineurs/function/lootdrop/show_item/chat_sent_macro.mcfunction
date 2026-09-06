#> sgp.mineurs:lootdrop/show_item/main_macro
# `{item_hover: item hover event}`
# Read the name as a text component from storage, preserving strings and formatting.

$tellraw @a[tag=sgp.in_game] [{"selector": "@s", bold:true}, {"text": " vient de trouver ", color:yellow, bold:false}, \
    {"text": "", "color": "aqua", "hover_event": $(item_hover), "extra": [{"text": "["}, {storage:"sgp:macro",nbt:"item_name",interpret:true}, {"text": "]"}]}, \
    {"text": " dans un ", color:yellow, bold:false}, {text:"Lootdrop !", color:gold, bold:true} ]
