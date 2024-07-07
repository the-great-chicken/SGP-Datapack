execute at @n[type=marker,tag=sgp.marker,name="kits"] as @a[distance=..3] run tp @s @n[type=marker,tag=sgp.marker,name="sgp.devenir_chasseur"]
execute at @n[type=marker,tag=sgp.marker,name="kits"] as @a[distance=..3] run scoreboard players enable @s sgp.devenir_chasseur
execute at @n[type=marker,tag=sgp.marker,name="kits"] as @a[distance=..3] run removeglow @s
