execute as @s run function cosm:enable_triggers_cosm
clear @s
scoreboard players enable @s sort_cosm
tp @s @e[type=minecraft:marker,name="salle_cosm",limit=1]
scoreboard players set @s entre_cosm 0
