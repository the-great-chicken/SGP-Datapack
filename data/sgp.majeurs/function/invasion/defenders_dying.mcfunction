#> sgp.majeurs:invasion/defenders_dying
# 
# When defenders die

execute at @e[type=marker,tag=sgp.marker,name="kits",limit=1] as @a[distance=..3,team=sgp.Defenseur] run function sgp.majeurs:invasion/defender_dead

# Quand tous les défenseurs sont morts
execute unless entity @a[tag=sgp.in_game,team=sgp.Defenseur] run tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Les Attaquants ont gagné ! Ils ont tué tous les Défenseurs.", "color":"red", "bold":true}]
execute unless entity @a[tag=sgp.in_game,team=sgp.Defenseur] run title @a[tag=sgp.in_game] title [{"text":"Attaquants Vainqueurs","color":"red","bold":true}]
execute unless entity @a[tag=sgp.in_game,team=sgp.Defenseur] run function sgp.majeurs:invasion/_stop