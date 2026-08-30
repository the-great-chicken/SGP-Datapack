#> sgp.majeurs:protect/if_king_dead
# `{team, name, color, name_ennemies, color_ennemies}`
#
# Things that can happen in a team while their king is dead

# Quand un roi vient de mourir
$execute if score #mort_roi_$(team)_annoncee sgp.dummy matches 0 \
        run function sgp.majeurs:protect/king_dies {team:$(team), name:$(name), color:$(color)}

# Quand un joueur meurt alors que son roi est mort
$execute at @e[type=marker,tag=sgp.marker,name="respawn",limit=1] as @a[distance=..3,team=sgp.$(team)] run function sgp.majeurs:common/eliminate

# Quand tous les gens de l'équipe sont morts
$function sgp.majeurs:protect/check_team_eliminated {team:$(team),name:$(name),name_ennemies:$(name_ennemies),color_ennemies:$(color_ennemies)}
