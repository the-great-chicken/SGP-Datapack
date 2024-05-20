execute unless score @s plus_grande_streak >= 0 dummy run scoreboard players set @s plus_grande_streak 0

execute unless score @s pyromane_found >= 0 dummy run scoreboard players set @s pyromane_found 0
execute unless score @s cancer_found >= 0 dummy run scoreboard players set @s cancer_found 0
execute unless score @s roi_found >= 0 dummy run scoreboard players set @s roi_found 0
execute unless score @s pigeon_found >= 0 dummy run scoreboard players set @s pigeon_found 0
execute unless score @s tank_found >= 0 dummy run scoreboard players set @s tank_found 0
execute unless score @s enderman_found >= 0 dummy run scoreboard players set @s enderman_found 0
execute unless score @s alchimiste_found >= 0 dummy run scoreboard players set @s alchimiste_found 0
execute unless score @s poseidon_found >= 0 dummy run scoreboard players set @s poseidon_found 0
execute unless score @s eclaireur_found >= 0 dummy run scoreboard players set @s eclaireur_found 0

execute unless score @s UUID >= 0 dummy unless score @s UUID <= 0 dummy store result score @s UUID run data get entity @s UUID[1]

execute unless score @s lieu_autel >= 0 dummy run scoreboard players set @s lieu_autel 0
execute unless score @s lieu_bunker >= 0 dummy run scoreboard players set @s lieu_bunker 0
execute unless score @s lieu_chercheurDevantLeternel >= 0 dummy run scoreboard players set @s lieu_chercheurDevantLeternel 0
execute unless score @s lieu_dedale >= 0 dummy run scoreboard players set @s lieu_dedale 0
execute unless score @s lieu_fun >= 0 dummy run scoreboard players set @s lieu_fun 0
execute unless score @s lieu_gallerie >= 0 dummy run scoreboard players set @s lieu_galerie 0
execute unless score @s lieu_garde >= 0 dummy run scoreboard players set @s lieu_garde 0
execute unless score @s lieu_grandeSalle >= 0 dummy run scoreboard players set @s lieu_grandeSalle 0
execute unless score @s lieu_grange >= 0 dummy run scoreboard players set @s lieu_grange 0
execute unless score @s lieu_kotl >= 0 dummy run scoreboard players set @s lieu_kotl 0
execute unless score @s lieu_laby >= 0 dummy run scoreboard players set @s lieu_laby 0
execute unless score @s lieu_lave >= 0 dummy run scoreboard players set @s lieu_lave 0
execute unless score @s lieu_machicoulis >= 0 dummy run scoreboard players set @s lieu_machicoulis 0
execute unless score @s lieu_moules >= 0 dummy run scoreboard players set @s lieu_moules 0
execute unless score @s lieu_observatoire >= 0 dummy run scoreboard players set @s lieu_observatoire 0
execute unless score @s lieu_pavillon >= 0 dummy run scoreboard players set @s lieu_pavillon 0
execute unless score @s lieu_pigeonnier >= 0 dummy run scoreboard players set @s lieu_pigeonnier 0
execute unless score @s lieu_pyramide >= 0 dummy run scoreboard players set @s lieu_pyramide 0
execute unless score @s lieu_repos >= 0 dummy run scoreboard players set @s lieu_repos 0
execute unless score @s lieu_reunion >= 0 dummy run scoreboard players set @s lieu_reunion 0
execute unless score @s lieu_snek >= 0 dummy run scoreboard players set @s lieu_snek 0
execute unless score @s lieu_sousToit >= 0 dummy run scoreboard players set @s lieu_sousToit 0
execute unless score @s lieu_sumo >= 0 dummy run scoreboard players set @s lieu_sumo 0
execute unless score @s lieu_taijitu >= 0 dummy run scoreboard players set @s lieu_taijitu 0
execute unless score @s lieu_temple >= 0 dummy run scoreboard players set @s lieu_temple 0
execute unless score @s lieu_toit >= 0 dummy run scoreboard players set @s lieu_toit 0
execute unless score @s lieu_vallons >= 0 dummy run scoreboard players set @s lieu_vallons 0
execute unless score @s lieu_zoneNoire >= 0 dummy run scoreboard players set @s lieu_zoneNoire 0
execute unless score @s lieu_maison >= 0 dummy run scoreboard players set @s lieu_maison 0
execute unless score @s lieu_abri >= 0 dummy run scoreboard players set @s lieu_abri 0
execute unless score @s lieu_piliers >= 0 dummy run scoreboard players set @s lieu_piliers 0
execute unless score @s lieu_jumpEst >= 0 dummy run scoreboard players set @s lieu_jumpEst 0
execute unless score @s lieu_jumpOuest >= 0 dummy run scoreboard players set @s lieu_jumpOuest 0

execute unless score @s laby_fin >= 0 dummy run scoreboard players set @s laby_fin 0
execute unless score @s jump_hardest_done >= 0 dummy run scoreboard players set @s jump_hardest_done 0
execute unless score @s jump_diff_2_done >= 0 dummy run scoreboard players set @s jump_diff_2_done 0

bossbar set minecraft:1 players @a
