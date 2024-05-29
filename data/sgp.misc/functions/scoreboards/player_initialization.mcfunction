#> sgp.misc:scoreboards/player_initialization
# 
# Set at 0 the player's scoreboard values, as they cannot
# be compared when they are not set to a value

execute unless score @s sgp.plus_grande_streak matches 0.. run scoreboard players set @s sgp.plus_grande_streak 0

execute unless score @s sgp.pyromane_found matches 0.. run scoreboard players set @s sgp.pyromane_found 0
execute unless score @s sgp.cancer_found matches 0.. run scoreboard players set @s sgp.cancer_found 0
execute unless score @s sgp.roi_found matches 0.. run scoreboard players set @s sgp.roi_found 0
execute unless score @s sgp.pigeon_found matches 0.. run scoreboard players set @s sgp.pigeon_found 0
execute unless score @s sgp.tank_found matches 0.. run scoreboard players set @s sgp.tank_found 0
execute unless score @s sgp.enderman_found matches 0.. run scoreboard players set @s sgp.enderman_found 0
execute unless score @s sgp.alchimiste_found matches 0.. run scoreboard players set @s sgp.alchimiste_found 0
execute unless score @s sgp.poseidon_found matches 0.. run scoreboard players set @s sgp.poseidon_found 0
execute unless score @s sgp.eclaireur_found matches 0.. run scoreboard players set @s sgp.eclaireur_found 0

execute unless score @s sgp.UUID matches 0.. unless score @s sgp.UUID matches ..0 store result score @s sgp.UUID run data get entity @s UUID[1]

execute unless score @s sgp.lieu_autel matches 0.. run scoreboard players set @s sgp.lieu_autel 0
execute unless score @s sgp.lieu_bunker matches 0.. run scoreboard players set @s sgp.lieu_bunker 0
execute unless score @s sgp.lieu_chercheurDevantLeternel matches 0.. run scoreboard players set @s sgp.lieu_chercheurDevantLeternel 0
execute unless score @s sgp.lieu_dedale matches 0.. run scoreboard players set @s sgp.lieu_dedale 0
execute unless score @s sgp.lieu_fun matches 0.. run scoreboard players set @s sgp.lieu_fun 0
execute unless score @s sgp.lieu_galerie matches 0.. run scoreboard players set @s sgp.lieu_galerie 0
execute unless score @s sgp.lieu_garde matches 0.. run scoreboard players set @s sgp.lieu_garde 0
execute unless score @s sgp.lieu_grandeSalle matches 0.. run scoreboard players set @s sgp.lieu_grandeSalle 0
execute unless score @s sgp.lieu_grange matches 0.. run scoreboard players set @s sgp.lieu_grange 0
execute unless score @s sgp.lieu_kotl matches 0.. run scoreboard players set @s sgp.lieu_kotl 0
execute unless score @s sgp.lieu_laby matches 0.. run scoreboard players set @s sgp.lieu_laby 0
execute unless score @s sgp.lieu_lave matches 0.. run scoreboard players set @s sgp.lieu_lave 0
execute unless score @s sgp.lieu_machicoulis matches 0.. run scoreboard players set @s sgp.lieu_machicoulis 0
execute unless score @s sgp.lieu_moules matches 0.. run scoreboard players set @s sgp.lieu_moules 0
execute unless score @s sgp.lieu_observatoire matches 0.. run scoreboard players set @s sgp.lieu_observatoire 0
execute unless score @s sgp.lieu_pavillon matches 0.. run scoreboard players set @s sgp.lieu_pavillon 0
execute unless score @s sgp.lieu_pigeonnier matches 0.. run scoreboard players set @s sgp.lieu_pigeonnier 0
execute unless score @s sgp.lieu_pyramide matches 0.. run scoreboard players set @s sgp.lieu_pyramide 0
execute unless score @s sgp.lieu_dortoir matches 0.. run scoreboard players set @s sgp.lieu_dortoir 0
execute unless score @s sgp.lieu_reunion matches 0.. run scoreboard players set @s sgp.lieu_reunion 0
execute unless score @s sgp.lieu_snek matches 0.. run scoreboard players set @s sgp.lieu_snek 0
execute unless score @s sgp.lieu_sousToit matches 0.. run scoreboard players set @s sgp.lieu_sousToit 0
execute unless score @s sgp.lieu_sumo matches 0.. run scoreboard players set @s sgp.lieu_sumo 0
execute unless score @s sgp.lieu_taijitu matches 0.. run scoreboard players set @s sgp.lieu_taijitu 0
execute unless score @s sgp.lieu_temple matches 0.. run scoreboard players set @s sgp.lieu_temple 0
execute unless score @s sgp.lieu_toit matches 0.. run scoreboard players set @s sgp.lieu_toit 0
execute unless score @s sgp.lieu_vallons matches 0.. run scoreboard players set @s sgp.lieu_vallons 0
execute unless score @s sgp.lieu_zoneNoire matches 0.. run scoreboard players set @s sgp.lieu_zoneNoire 0
execute unless score @s sgp.lieu_maison matches 0.. run scoreboard players set @s sgp.lieu_maison 0
execute unless score @s sgp.lieu_abri matches 0.. run scoreboard players set @s sgp.lieu_abri 0
execute unless score @s sgp.lieu_piliers matches 0.. run scoreboard players set @s sgp.lieu_piliers 0
execute unless score @s sgp.lieu_jumpEst matches 0.. run scoreboard players set @s sgp.lieu_jumpEst 0
execute unless score @s sgp.lieu_jumpOuest matches 0.. run scoreboard players set @s sgp.lieu_jumpOuest 0

execute unless score @s sgp.laby_fin matches 0.. run scoreboard players set @s sgp.laby_fin 0
execute unless score @s sgp.jump_hardest_done matches 0.. run scoreboard players set @s sgp.jump_hardest_done 0
execute unless score @s sgp.jump_diff_2_done matches 0.. run scoreboard players set @s sgp.jump_diff_2_done 0

execute unless score @s sgp.teleporteur matches 0.. run scoreboard players set @s sgp.teleporteur 0

bossbar set sgp:lgp players @a
