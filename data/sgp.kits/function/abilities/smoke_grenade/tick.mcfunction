#> sgp.kits:abilities/smoke_grenade/tick
#
# Detect when a smoke grenade hits the ground

tag @e[tag=sgp.smoke_visual,type=item_display] remove sgp.is_riding
execute as @e[tag=sgp.smoke_grenade,type=snowball] at @s run tag @n[tag=sgp.smoke_visual,distance=..0.5,type=item_display] add sgp.is_riding
execute as @e[tag=sgp.smoke_visual,tag=!sgp.is_riding,type=item_display] at @s run function sgp.kits:abilities/smoke_grenade/on_ground