#> sgp.majeurs:protect/participant_exit
# `{side, team, name, color, name_ennemies, color_ennemies}`

$execute if score #protect_phase sgp.dummy matches 1 \
    if entity @s[tag=sgp.roi_$(side)] \
        run scoreboard players set #king_$(side)_chosen sgp.dummy 0

$execute if score #protect_phase sgp.dummy matches 1 \
    if entity @s[tag=sgp.roi_$(side)] \
        as @e[tag=sgp.marker,name="devenir_roi_$(side)",limit=1,type=marker] at @s \
            run function sgp.majeurs:protect/setup_king_selector {side:$(side),team:$(team),name:$(name),color:$(color)}

tag @s remove sgp.roi_rouge
tag @s remove sgp.roi_bleu
function sgp.majeurs:common/eliminate_exit
$function sgp.majeurs:protect/check_team_eliminated {team:$(team),name:$(name),name_ennemies:$(name_ennemies),color_ennemies:$(color_ennemies)}
