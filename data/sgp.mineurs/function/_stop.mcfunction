tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Désactivation des Événements Mineurs", "color":"red", "bold":true}]

scoreboard players set #events_mineurs_actifs sgp.dummy 0

execute unless score #confines_secondes sgp.dummy matches 0 unless score #confines_tick sgp.dummy matches 0 run scoreboard players set #confines_secondes sgp.timer 5
scoreboard players set #confines_secondes sgp.timer 0

execute at @e[type=marker,tag=sgp.marker,name="Lootdrop"] run setblock ~ ~ ~ air

execute as @a[tag=sgp.in_game] \
    run attribute @s minecraft:generic.scale modifier remove sgp.smol

experience set @a[tag=sgp.in_game] 0 levels
experience set @a[tag=sgp.in_game] 0 points

schedule clear sgp.mineurs:smol/running