# Quand un défenseur meurt
execute at @e[tag=sgp.marker,name="kits",limit=1] as @a[distance=..3,team=sgp.Defenseur] run team leave @s
execute at @e[tag=sgp.marker,name="kits",limit=1] as @a[distance=..3,team=sgp.Defenseur] run move @s #Morts
execute at @e[tag=sgp.marker,name="kits",limit=1] as @a[distance=..3,team=sgp.Defenseur] run gamemode spectator @s
execute at @e[tag=sgp.marker,name="kits",limit=1] as @a[distance=..3,team=sgp.Defenseur] run tp @s 2531 251.5 2198 135 0

# Quand tous les défenseurs sont morts
execute unless entity @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72,team=sgp.Defenseur] run tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] [{"text":"Les sgp.Attaquants ont gagné ! Ils ont tué tous les Défenseurs.","color":"red","bold":true}]
execute unless entity @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72,team=sgp.Defenseur] run title @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] title [{"text":"Attaquants Vainqueurs","color":"red","bold":true}]
execute unless entity @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72,team=sgp.Defenseur] run function sgp.majeurs:invasion/_stop