# Quand un rouge meurt alors que son roi est mort
execute unless predicate majeurs:roi_rouge_vivant as @a[x=2423,y=251.5,z=2145.5,distance=..3,team=rouge] run team leave @s
execute unless predicate majeurs:roi_rouge_vivant as @a[x=2423,y=251.5,z=2145.5,distance=..3,team=rouge] run move @s #Morts
execute unless predicate majeurs:roi_rouge_vivant as @a[x=2423,y=251.5,z=2145.5,distance=..3,team=rouge] run gamemode spectator @s
execute unless predicate majeurs:roi_rouge_vivant as @a[x=2423,y=251.5,z=2145.5,distance=..3,team=rouge] run tp @s 2531 251.5 2198 135 0

# Quand tous les bleus sont morts
execute unless entity @a[team=bleue] unless predicate majeurs:roi_bleu_vivant run tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] ["",{"text":"L'Equipe ", "color":"gold", "bold":true},{"text":"Rouge ", "color":"dark_red", "bold":true},{"text":"a gagné ! ", "color":"gold", "bold":true},{"text":"Tous les Bleus sont vivants. ", "color":"gold"}]
execute unless entity @a[team=bleue] unless predicate majeurs:roi_bleu_vivant run function majeurs:protect_stop
execute unless entity @a[team=bleue] unless predicate majeurs:roi_bleu_vivant run title @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] title ["",{"text":"Rouges ", "color":"dark_red", "bold":true},{"text":"gagnent", "color":"gold"}]

# Quand le roi rouge vient de mourir
execute unless predicate majeurs:roi_rouge_vivant if score #mort_roi_rouge_annoncee dummy matches 0 run tellraw @a [{"text":"Le roi de l'Equipe ", "color":"gold"},{"text":"Rouge ", "color":"dark_red", "bold":true},{"text":"est vivant, les membres de son équipe ne peuvent plus réapparaitre!", "color":"gold"}]
execute unless predicate majeurs:roi_rouge_vivant if score #mort_roi_rouge_annoncee dummy matches 0 run tp @a[x=2423,y=251.5,z=2145.5,distance=..3,team=!rouge,team=!bleue] 2531 251.5 2198 135 0
execute unless predicate majeurs:roi_rouge_vivant if score #mort_roi_rouge_annoncee dummy matches 0 run tag @a remove roi_rouge
execute unless predicate majeurs:roi_rouge_vivant if score #mort_roi_rouge_annoncee dummy matches 0 run scoreboard players set #mort_roi_rouge_annoncee dummy 1


# Quand un bleu meurt alors que son roi est mort
execute unless predicate majeurs:roi_bleu_vivant as @a[x=2423,y=251.5,z=2145.5,distance=..3,team=bleue] run team leave @s
execute unless predicate majeurs:roi_bleu_vivant as @a[x=2423,y=251.5,z=2145.5,distance=..3,team=bleue] run move @s #Morts
execute unless predicate majeurs:roi_bleu_vivant as @a[x=2423,y=251.5,z=2145.5,distance=..3,team=bleue] run gamemode spectator @s
execute unless predicate majeurs:roi_bleu_vivant as @a[x=2423,y=251.5,z=2145.5,distance=..3,team=bleue] run tp @s 2531 251.5 2198 135 0

# Quand tous les rouges sont morts
execute unless entity @a[team=rouge] unless predicate majeurs:roi_rouge_vivant run tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] ["",{"text":"L'Equipe ", "color":"gold", "bold":true},{"text":"Bleue ", "color":"dark_blue", "bold":true},{"text":"a gagné ! ", "color":"gold", "bold":true},{"text":"Tous les Rouges sont vivants. ", "color":"gold"}]
execute unless entity @a[team=rouge] unless predicate majeurs:roi_rouge_vivant run function majeurs:protect_stop
execute unless entity @a[team=rouge] unless predicate majeurs:roi_rouge_vivant run title @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] title ["",{"text":"Bleus ", "color":"dark_blue", "bold":true},{"text":"gagnent", "color":"gold"}]

# Quand le roi bleu vient de mourir
execute unless predicate majeurs:roi_bleu_vivant if score #mort_roi_bleu_annoncee dummy matches 0 run tellraw @a [{"text":"Le roi de l'Equipe ", "color":"gold"},{"text":"Bleue ", "color":"dark_blue", "bold":true},{"text":"est vivant, les membres de son équipe ne peuvent plus réapparaitre!", "color":"gold"}]
execute unless predicate majeurs:roi_bleu_vivant if score #mort_roi_bleu_annoncee dummy matches 0 run tag @a remove roi_bleu
execute unless predicate majeurs:roi_bleu_vivant if score #mort_roi_bleu_annoncee dummy matches 0 run scoreboard players set #mort_roi_bleu_annoncee dummy 1