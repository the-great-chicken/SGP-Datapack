#> sgp.majeurs:protect/running
#
# Apply king effects and resolve permanent deaths while the combat phase is active.

execute unless score #protect_phase sgp.dummy matches 2 run return 0

execute at @e[tag=sgp.marker,name="respawn",limit=1,type=marker] as @a[distance=..3,tag=sgp.roi_rouge] run tag @s remove sgp.roi_rouge
execute at @e[tag=sgp.marker,name="respawn",limit=1,type=marker] as @a[distance=..3,tag=sgp.roi_bleu] run tag @s remove sgp.roi_bleu

execute as @a[tag=sgp.roi_rouge] run function sgp.majeurs:protect/king_effect {team:rouge,color:"[1.0,0.0,0.0]"}
execute as @a[tag=sgp.roi_bleu] run function sgp.majeurs:protect/king_effect {team:bleue,color:"[0.0,0.0,1.0]"}

execute unless entity @a[tag=sgp.roi_rouge] run function sgp.majeurs:protect/if_king_dead {team:rouge,name:Rouge,name_ennemies:Bleu,color:dark_red,color_ennemies:dark_blue}
execute unless entity @a[team=sgp.rouge] run return 1
execute unless entity @a[tag=sgp.roi_bleu] run function sgp.majeurs:protect/if_king_dead {team:bleue,name:Bleu,name_ennemies:Rouge,color:dark_blue,color_ennemies:dark_red}
