#> sgp.mineurs:lootdrop/show_item/main_macro
# `{item_hover: item text component, item_name: text component or string}`

$tellraw @a [{"selector": "@s", bold:true}, {"text": " vient de trouver ", color:yellow, bold:false}, \
    {"text": "", "color": "aqua", "hover_event": $(item_hover), "extra": [{"text": "["}, $(item_name), {"text": "]"}]}, \
    {"text": " dans un ", color:yellow, bold:false}, {text:"Lootdrop !", color:gold, bold:true} ]