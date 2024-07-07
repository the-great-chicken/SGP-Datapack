#> sgp.majeurs:invasion/defenders_dying
# 
# When defenders die

execute at @n[type=marker,tag=sgp.marker,name="kits"] as @a[distance=..3,team=sgp.Defenseur] run function sgp.majeurs:invasion/defender_dead

# Quand tous les défenseurs sont morts
execute unless entity @a[tag=sgp.in_game,team=sgp.Defenseur] run tellraw @a[tag=sgp.in_game] [{"text":"Les sgp.Attaquants ont gagné ! Ils ont tué tous les Défenseurs.","color":"red","bold":true}]
execute unless entity @a[tag=sgp.in_game,team=sgp.Defenseur] run title @a[tag=sgp.in_game] title [{"text":"Attaquants Vainqueurs","color":"red","bold":true}]
execute unless entity @a[tag=sgp.in_game,team=sgp.Defenseur] run function sgp.majeurs:invasion/_stop