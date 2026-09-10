#> sgp.kits:selection_message
# `{kit_name, kit_color, ability_name, ability_hover}`
#
# Confirms a kit selection and exposes the ability description on hover.

$tellraw @s [ \
    {storage:"sgp:text", nbt:"prefix", interpret:true}, \
    {text:"Tu as obtenu le kit ", color:aqua}, \
    {text:"$(kit_name)", color:"$(kit_color)", bold:true}, \
    {text:" avec la capacité ", color:aqua}, \
    {text:"$(ability_name)", color:"$(kit_color)", bold:true, hover_event:{action:show_text,value:$(ability_hover)}}, \
    {text:" ⓘ", color:gray, hover_event:{action:show_text,value:$(ability_hover)}} \
]
