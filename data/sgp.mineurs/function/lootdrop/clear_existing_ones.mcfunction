#> sgp.mineurs:lootdrop/clear_existing_ones
#
# Remove the current drops and stop their proximity and close-detection work.

schedule clear sgp.mineurs:lootdrop/check_for_players_around_chest
function #bs.schedule:cancel_all {with:{id:"close_detection"}}
execute as @e[tag=sgp.marker,name="Lootdrop",type=marker] at @s run setblock ~ ~ ~ air
tag @e[tag=sgp.marker,name="Lootdrop",type=marker] remove sgp.opened_chest
tag @a remove sgp.container_open
kill @e[name=lootdrop_beacon,type=text_display]
kill @e[name=lootdrop_glowing_chest,type=block_display]
