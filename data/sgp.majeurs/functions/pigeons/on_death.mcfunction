execute at @e[type=marker,tag=sgp.marker,name="kits",limit=1] as @a[distance=..3] run tp @s @e[type=marker,tag=sgp.marker,name="sgp.devenir_chasseur",limit=1]
execute at @e[type=marker,tag=sgp.marker,name="kits",limit=1] as @a[distance=..3] run scoreboard players enable @s sgp.devenir_chasseur
execute at @e[type=marker,tag=sgp.marker,name="kits",limit=1] as @a[distance=..3] run removeglow @s
