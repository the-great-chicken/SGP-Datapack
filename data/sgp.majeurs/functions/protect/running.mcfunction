# Quand un rouge meurt alors que son roi est mort
execute unless predicate sgp.majeurs:roi_rouge_vivant at @e[type=marker,tag=sgp.marker,name="kits",limit=1] as @a[distance=..3,team=sgp.rouge] run function sgp.majeurs:protect/player_dead

# Quand tous les bleus sont morts
execute unless entity @a[team=sgp.bleue] unless predicate sgp.majeurs:roi_bleu_vivant run tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] [{"text":"L'Equipe ", "color":"gold", "bold":true}, {"text":"Rouge ", "color":"dark_red"}, "a gagné ! ", {"text":"Tous les Bleus sont vivants. ","bold":false}]
execute unless entity @a[team=sgp.bleue] unless predicate sgp.majeurs:roi_bleu_vivant run function sgp.majeurs:protect/_stop
execute unless entity @a[team=sgp.bleue] unless predicate sgp.majeurs:roi_bleu_vivant run title @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] title ["",{"text":"Rouges ", "color":"dark_red", "bold":true},{"text":"gagnent", "color":"gold"}]

# Quand le roi rouge vient de mourir
execute unless predicate sgp.majeurs:roi_rouge_vivant if score #mort_roi_rouge_annoncee sgp.dummy matches 0 run tellraw @a [{"text":"Le roi de l'Equipe ", "color":"gold"},{"text":"Rouge ", "color":"dark_red", "bold":true}, "est vivant, les membres de son équipe ne peuvent plus réapparaitre!"]
execute unless predicate sgp.majeurs:roi_rouge_vivant if score #mort_roi_rouge_annoncee sgp.dummy matches 0 run tp @a[x=2423,y=251.5,z=2145.5,distance=..3,team=!rouge,team=!bleue] 2531 251.5 2198 135 0
execute unless predicate sgp.majeurs:roi_rouge_vivant if score #mort_roi_rouge_annoncee sgp.dummy matches 0 run tag @a remove roi_rouge
execute unless predicate sgp.majeurs:roi_rouge_vivant if score #mort_roi_rouge_annoncee sgp.dummy matches 0 run scoreboard players set #mort_roi_rouge_annoncee sgp.dummy 1


# Quand un bleu meurt alors que son roi est mort
execute unless predicate sgp.majeurs:roi_bleu_vivant at @e[type=marker,tag=sgp.marker,name="kits",limit=1] as @a[distance=..3,team=sgp.bleue] run function sgp.majeurs:protect/player_dead

# Quand tous les rouges sont morts
execute unless entity @a[team=sgp.rouge] unless predicate sgp.majeurs:roi_rouge_vivant run tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] [{"text":"L'Equipe ", "color":"gold", "bold":true}, {"text":"Bleu ", "color":"dark_blue"}, "a gagné ! ", {"text":"Tous les Rouges sont vivants. ","bold":false}]
execute unless entity @a[team=sgp.rouge] unless predicate sgp.majeurs:roi_rouge_vivant run function sgp.majeurs:protect/_stop
execute unless entity @a[team=sgp.rouge] unless predicate sgp.majeurs:roi_rouge_vivant run title @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] title ["",{"text":"Bleus ", "color":"dark_blue", "bold":true},{"text":"gagnent", "color":"gold"}]

# Quand le roi bleu vient de mourir
execute unless predicate sgp.majeurs:roi_bleu_vivant if score #mort_roi_bleu_annoncee sgp.dummy matches 0 run tellraw @a [{"text":"Le roi de l'Equipe ", "color":"gold"},{"text":"Bleue ", "color":"dark_blue", "bold":true},"est vivant, les membres de son équipe ne peuvent plus réapparaitre!"]
execute unless predicate sgp.majeurs:roi_bleu_vivant if score #mort_roi_bleu_annoncee sgp.dummy matches 0 run tp @a[x=2423,y=251.5,z=2145.5,distance=..3,team=!rouge,team=!bleue] 2531 251.5 2198 135 0
execute unless predicate sgp.majeurs:roi_bleu_vivant if score #mort_roi_bleu_annoncee sgp.dummy matches 0 run tag @a remove roi_bleu
execute unless predicate sgp.majeurs:roi_bleu_vivant if score #mort_roi_bleu_annoncee sgp.dummy matches 0 run scoreboard players set #mort_roi_bleu_annoncee sgp.dummy 1