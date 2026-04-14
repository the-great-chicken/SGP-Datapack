#> sgp.kits:abilities/main_trigger

execute unless entity @s[tag=sgp.in_game] run return run scoreboard players reset @s sgp.drop_any

tag @n[tag=!smithed.entity,distance=..4,nbt={Age:0s},type=item] add sgp.dropped
execute at @e[tag=sgp.marker,name="abilities_shulker",limit=1,type=marker] run function sgp.kits:abilities/give_back_item
kill @n[tag=sgp.dropped,distance=..4,type=item]

execute if score @s sgp.cooldown_ability matches 1.. run tellraw @s [{"text": "Vous êtes encore en cooldown pendant ", "color": "red"}, {"score": {"name": "*", "objective": "sgp.cooldown_ability"}, "color": "gold", "bold": true}, " ticks"]

execute if score @s sgp.cooldown_ability matches ..0 run function sgp.kits:abilities/route_ability

scoreboard players reset @s sgp.drop_any