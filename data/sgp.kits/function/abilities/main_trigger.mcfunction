#> sgp.kits:abilities/main_trigger

execute unless entity @s[tag=sgp.in_game] run return run scoreboard players reset @s sgp.drop_any

function sgp.kits:abilities/tag_dropped_item with entity @s
execute at @e[tag=sgp.marker,name="abilities_shulker",limit=1,type=marker] run function sgp.kits:abilities/give_back_item
kill @n[tag=sgp.dropped,distance=..4,type=item]

execute if score @s sgp.cooldown_ability matches 1.. run function sgp.kits:abilities/display_cooldown {type:cooldown_ability, every:1}

execute if score @s sgp.cooldown_ability matches ..0 run function sgp.kits:abilities/route_ability

scoreboard players reset @s sgp.drop_any