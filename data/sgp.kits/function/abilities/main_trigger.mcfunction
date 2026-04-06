execute unless entity @s[tag=sgp.in_game] run return run scoreboard players reset @s sgp.drop_any

tag @e[type=item,tag=!global.ignore,distance=..4,nbt={Age:0s},limit=1] add sgp.dropped
execute at @e[type=marker,tag=sgp.marker,name="abilities_shulker"] \
    run item replace block ~ ~ ~ container.0 from entity @e[type=item,tag=sgp.dropped,limit=1] contents
execute at @e[type=marker,tag=sgp.marker,name="abilities_shulker"] run loot give @s mine ~ ~ ~
execute at @e[type=marker,tag=sgp.marker,name="abilities_shulker"] run item replace block ~ ~ ~ container.0 with air
kill @e[type=item,tag=sgp.dropped,limit=1]

execute if entity @s[tag=sgp.archer] if score @s sgp.cooldown_repulsion matches ..0 run function sgp.kits:abilities/trigger_repulsion

scoreboard players reset @s sgp.drop_any