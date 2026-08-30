#> sgp.majeurs:protect/participant_exit
# `{team, name, name_ennemies, color_ennemies}`

tag @s remove sgp.roi_rouge
tag @s remove sgp.roi_bleu
function sgp.majeurs:common/eliminate_exit
$function sgp.majeurs:protect/check_team_eliminated {team:$(team),name:$(name),name_ennemies:$(name_ennemies),color_ennemies:$(color_ennemies)}
