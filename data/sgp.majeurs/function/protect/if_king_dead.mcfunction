# Quand un joueur meurt alors que son roi est mort
$execute at @e[type=marker,tag=sgp.marker,name="kits",limit=1] as @a[distance=..3,team=sgp.$(team)] run function sgp.majeurs:protect/player_dead

# Quand un roi vient de mourir
$execute if score #mort_roi_$(team)_annoncee sgp.dummy matches 0 \
        run function sgp.majeurs:protect/king_dies {team:$(team), color:$(color)}

# Quand tous les gens de l'équipe sont morts
$execute unless entity @a[team=sgp.$(team)] run tellraw @a[tag=sgp.in_game] [{"text":"L'Equipe ", "color":"gold", "bold":true}, {"text":"$(name_ennemies) ", "color":"$(color_ennemies)"}, "a gagné ! ", {"text":"Tous les $(name)s sont morts. ","bold":false}]
$execute unless entity @a[team=sgp.$(team)] run title @a[tag=sgp.in_game] title ["",{"text":"$(name_ennemies)s ", "color":"$(color_ennemies)", "bold":true},{"text":"gagnent", "color":"gold"}]
$execute unless entity @a[team=sgp.$(team)] run function sgp.majeurs:protect/_stop