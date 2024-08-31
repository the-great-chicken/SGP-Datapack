#> sgp.majeurs:protect/running
#
# Things that are executed all the time when the event is running
# Like checking if ppl die, if a team wins,...

execute at @e[type=marker,tag=sgp.marker,name="kits",limit=1] \
    as @a[distance=..3,tag=sgp.roi_rouge] \
        run tag @s remove sgp.roi_rouge

execute at @e[type=marker,tag=sgp.marker,name="kits",limit=1] \
    as @a[distance=..3,tag=sgp.roi_rouge] \
        run tag @s remove sgp.roi_bleu

execute if score #kings_chosen sgp.dummy matches 0 \
    if entity @a[predicate=sgp.majeurs:protect/roi_bleu_vivant] \
    if entity @a[predicate=sgp.majeurs:protect/roi_rouge_vivant] \
        run scoreboard players set #kings_chosen sgp.dummy 1

execute if score #kings_chosen sgp.dummy matches 1 \
    unless entity @a[predicate=sgp.majeurs:protect/roi_rouge_vivant] \
        run function sgp.majeurs:protect/if_king_dead {team:rouge, name:Rouge, team_ennemies:bleue, name_ennemies:Bleu, color:dark_red, color_ennemies:dark_blue}

execute if score #kings_chosen sgp.dummy matches 1 \
    unless entity @a[predicate=sgp.majeurs:protect/roi_bleu_vivant] \
        run function sgp.majeurs:protect/if_king_dead {team:bleue, name:Bleu, team_ennemies:rouge, name_ennemies:Rouge, color:dark_blue, color_ennemies:dark_red}

execute as @a[tag=sgp.roi_bleu] run function sgp.majeurs:protect/king_effect {team:bleue, color:"[0.0,0.0,1.0]"}
execute as @a[tag=sgp.roi_rouge] run function sgp.majeurs:protect/king_effect {team:rouge, color:"[1.0,0.0,0.0]"}