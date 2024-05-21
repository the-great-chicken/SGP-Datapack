execute at @e[type=marker,name="kits",limit=1] as @a[distance=..3] run tp @s @e[type=marker,name="devenir_chasseur",limit=1]
execute at @e[type=marker,name="kits",limit=1] as @a[distance=..3] run scoreboard players enable @s devenir_chasseur
execute at @e[type=marker,name="kits",limit=1] as @a[distance=..3] run removeglow @s
