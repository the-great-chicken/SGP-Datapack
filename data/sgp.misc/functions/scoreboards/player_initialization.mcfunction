#> sgp.misc:scoreboards/player_initialization
# 
# Set at 0 the player's scoreboard values, as they cannot
# be compared when they are not set to a value

execute unless score @s sgp.plus_grande_streak >= 0 sgp.dummy run scoreboard players set @s sgp.plus_grande_streak 0

execute unless score @s sgp.pyromane_found >= 0 sgp.dummy run scoreboard players set @s sgp.pyromane_found 0
execute unless score @s sgp.cancer_found >= 0 sgp.dummy run scoreboard players set @s sgp.cancer_found 0
execute unless score @s sgp.roi_found >= 0 sgp.dummy run scoreboard players set @s sgp.roi_found 0
execute unless score @s sgp.pigeon_found >= 0 sgp.dummy run scoreboard players set @s sgp.pigeon_found 0
execute unless score @s sgp.tank_found >= 0 sgp.dummy run scoreboard players set @s sgp.tank_found 0
execute unless score @s sgp.enderman_found >= 0 sgp.dummy run scoreboard players set @s sgp.enderman_found 0
execute unless score @s sgp.alchimiste_found >= 0 sgp.dummy run scoreboard players set @s sgp.alchimiste_found 0
execute unless score @s sgp.poseidon_found >= 0 sgp.dummy run scoreboard players set @s sgp.poseidon_found 0
execute unless score @s sgp.eclaireur_found >= 0 sgp.dummy run scoreboard players set @s sgp.eclaireur_found 0

execute unless score @s sgp.UUID >= 0 sgp.dummy unless score @s sgp.UUID <= 0 sgp.dummy store result score @s sgp.UUID run data get entity @s UUID[1]

execute unless score @s sgp.lieu_autel >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_autel 0
execute unless score @s sgp.lieu_bunker >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_bunker 0
execute unless score @s sgp.lieu_chercheurDevantLeternel >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_chercheurDevantLeternel 0
execute unless score @s sgp.lieu_dedale >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_dedale 0
execute unless score @s sgp.lieu_fun >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_fun 0
execute unless score @s sgp.lieu_galerie >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_galerie 0
execute unless score @s sgp.lieu_garde >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_garde 0
execute unless score @s sgp.lieu_grandeSalle >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_grandeSalle 0
execute unless score @s sgp.lieu_grange >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_grange 0
execute unless score @s sgp.lieu_kotl >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_kotl 0
execute unless score @s sgp.lieu_laby >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_laby 0
execute unless score @s sgp.lieu_lave >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_lave 0
execute unless score @s sgp.lieu_machicoulis >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_machicoulis 0
execute unless score @s sgp.lieu_moules >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_moules 0
execute unless score @s sgp.lieu_observatoire >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_observatoire 0
execute unless score @s sgp.lieu_pavillon >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_pavillon 0
execute unless score @s sgp.lieu_pigeonnier >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_pigeonnier 0
execute unless score @s sgp.lieu_pyramide >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_pyramide 0
execute unless score @s sgp.lieu_dortoir >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_dortoir 0
execute unless score @s sgp.lieu_reunion >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_reunion 0
execute unless score @s sgp.lieu_snek >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_snek 0
execute unless score @s sgp.lieu_sousToit >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_sousToit 0
execute unless score @s sgp.lieu_sumo >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_sumo 0
execute unless score @s sgp.lieu_taijitu >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_taijitu 0
execute unless score @s sgp.lieu_temple >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_temple 0
execute unless score @s sgp.lieu_toit >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_toit 0
execute unless score @s sgp.lieu_vallons >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_vallons 0
execute unless score @s sgp.lieu_zoneNoire >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_zoneNoire 0
execute unless score @s sgp.lieu_maison >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_maison 0
execute unless score @s sgp.lieu_abri >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_abri 0
execute unless score @s sgp.lieu_piliers >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_piliers 0
execute unless score @s sgp.lieu_jumpEst >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_jumpEst 0
execute unless score @s sgp.lieu_jumpOuest >= 0 sgp.dummy run scoreboard players set @s sgp.lieu_jumpOuest 0

execute unless score @s sgp.laby_fin >= 0 sgp.dummy run scoreboard players set @s sgp.laby_fin 0
execute unless score @s sgp.jump_hardest_done >= 0 sgp.dummy run scoreboard players set @s sgp.jump_hardest_done 0
execute unless score @s sgp.jump_diff_2_done >= 0 sgp.dummy run scoreboard players set @s sgp.jump_diff_2_done 0

execute unless score @s sgp.teleporteur >= 0 sgp.dummy run scoreboard players set @s sgp.teleporteur 0

bossbar set sgp:lgp players @a
