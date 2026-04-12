#> sgp.kits:abilities/main_trigger

execute unless entity @s[tag=sgp.in_game] run return run scoreboard players reset @s sgp.drop_any

tag @n[type=item,tag=!smithed.entity,distance=..4,nbt={Age:0s}] add sgp.dropped

# Gives the item back with /loot give, making it go automatically in the right stack
execute at @e[type=marker,tag=sgp.marker,name="abilities_shulker"] \
    run item replace block ~ ~ ~ container.0 from entity @e[type=item,tag=sgp.dropped,limit=1] contents
execute at @e[type=marker,tag=sgp.marker,name="abilities_shulker"] run loot give @s mine ~ ~ ~
execute at @e[type=marker,tag=sgp.marker,name="abilities_shulker"] run item replace block ~ ~ ~ container.0 with air
kill @e[type=item,tag=sgp.dropped]

execute if score @s sgp.cooldown_ability matches 1.. run tellraw @s [{"text": "Vous êtes encore en cooldown pendant ", "color": "red"}, {"score": {"name": "*", "objective": "sgp.cooldown_ability"}, "color": "gold", "bold": true}, " ticks"]

execute if score @s sgp.cooldown_ability matches ..0 run function sgp.kits:abilities/route_ability

scoreboard players reset @s sgp.drop_any