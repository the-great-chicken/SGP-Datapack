execute at @e[tag=sgp.marker,name="kits",limit=1] as @a[distance=..3] run tp @s @e[tag=sgp.marker,name="sgp.devenir_chasseur",limit=1]
execute at @e[tag=sgp.marker,name="kits",limit=1] as @a[distance=..3] run scoreboard players enable @s sgp.devenir_chasseur
execute at @e[tag=sgp.marker,name="kits",limit=1] as @a[distance=..3] run removeglow @s
