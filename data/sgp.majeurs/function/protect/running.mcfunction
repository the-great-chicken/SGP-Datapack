# Quand un rouge meurt alors que son roi est mort
execute unless predicate sgp.majeurs:protect/roi_rouge_vivant at @e[type=marker,tag=sgp.marker,name="kits",limit=1] as @a[distance=..3,team=sgp.rouge] run function sgp.majeurs:protect/player_dead

# Quand tous les bleus sont morts
execute unless entity @a[team=sgp.bleue] unless predicate sgp.majeurs:protect/roi_bleu_vivant run tellraw @a[tag=sgp.in_game] [{"text":"L'Equipe ", "color":"gold", "bold":true}, {"text":"Rouge ", "color":"dark_red"}, "a gagné ! ", {"text":"Tous les Bleus sont vivants. ","bold":false}]
execute unless entity @a[team=sgp.bleue] unless predicate sgp.majeurs:protect/roi_bleu_vivant run function sgp.majeurs:protect/_stop
execute unless entity @a[team=sgp.bleue] unless predicate sgp.majeurs:protect/roi_bleu_vivant run title @a[tag=sgp.in_game] title ["",{"text":"Rouges ", "color":"dark_red", "bold":true},{"text":"gagnent", "color":"gold"}]

# Quand le roi rouge vient de mourir
execute unless predicate sgp.majeurs:protect/roi_rouge_vivant \
    if score #mort_roi_rouge_annoncee sgp.dummy matches 0 \
        run function sgp.majeurs:protect/king_dies {team:rouge, color:dark_red}


# Quand un bleu meurt alors que son roi est mort
execute unless predicate sgp.majeurs:protect/roi_bleu_vivant at @e[type=marker,tag=sgp.marker,name="kits",limit=1] as @a[distance=..3,team=sgp.bleue] run function sgp.majeurs:protect/player_dead

# Quand tous les rouges sont morts
execute unless entity @a[team=sgp.rouge] unless predicate sgp.majeurs:protect/roi_rouge_vivant run tellraw @a[tag=sgp.in_game] [{"text":"L'Equipe ", "color":"gold", "bold":true}, {"text":"Bleu ", "color":"dark_blue"}, "a gagné ! ", {"text":"Tous les Rouges sont vivants. ","bold":false}]
execute unless entity @a[team=sgp.rouge] unless predicate sgp.majeurs:protect/roi_rouge_vivant run function sgp.majeurs:protect/_stop
execute unless entity @a[team=sgp.rouge] unless predicate sgp.majeurs:protect/roi_rouge_vivant run title @a[tag=sgp.in_game] title ["",{"text":"Bleus ", "color":"dark_blue", "bold":true},{"text":"gagnent", "color":"gold"}]

# Quand le roi bleu vient de mourir
execute unless predicate sgp.majeurs:protect/roi_bleu_vivant \
    if score #mort_roi_bleu_annoncee sgp.dummy matches 0 \
        run function sgp.majeurs:protect/king_dies {team:bleu, color:dark_blue}


execute as @a[tag=sgp.roi_bleu] run function sgp.majeurs:protect/king_effect {team:bleue, color:"[0.0,0.0,1.0]"}
execute as @a[tag=sgp.roi_rouge] run function sgp.majeurs:protect/king_effect {team:rouge, color:"[1.0,0.0,0.0]"}