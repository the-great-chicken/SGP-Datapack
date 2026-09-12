#> sgp.mineurs:lootdrop/clear_marker
#
# Clear only the visuals belonging to this drop.

tag @s remove sgp.opened_chest
scoreboard players operation #closed_lootdrop sgp.lootdrop = @s sgp.lootdrop
execute as @e[name=lootdrop_beacon,type=text_display] if score @s sgp.lootdrop = #closed_lootdrop sgp.lootdrop run kill @s
