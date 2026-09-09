#> sgp.kits:abilities/smoke_grenade/tick
#
# Detect when a smoke grenade hits the ground

tag @e[tag=sgp.smoke_visual,type=item_display] remove sgp.is_riding
execute as @e[tag=sgp.smoke_grenade,type=snowball] on passengers if entity @s[tag=sgp.smoke_visual,type=item_display] run tag @s add sgp.is_riding
execute as @e[tag=sgp.smoke_visual,tag=!sgp.is_riding,type=item_display] at @s run function sgp.kits:abilities/smoke_grenade/on_ground
