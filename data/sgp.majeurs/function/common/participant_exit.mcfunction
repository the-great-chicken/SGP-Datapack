#> sgp.majeurs:common/participant_exit
#
# Route an exiting participant while their event team is still available.

execute if entity @s[team=sgp.rouge] run return run function sgp.majeurs:protect/participant_exit {team:rouge,name:Rouge,name_ennemies:Bleu,color_ennemies:dark_blue}
execute if entity @s[team=sgp.bleue] run return run function sgp.majeurs:protect/participant_exit {team:bleue,name:Bleu,name_ennemies:Rouge,color_ennemies:dark_red}

execute if entity @s[team=sgp.Poule] run return run function sgp.majeurs:pco/participant_exit {team:Poule,name_ennemies:Oies,color_ennemies:yellow}
execute if entity @s[team=sgp.Canard] run return run function sgp.majeurs:pco/participant_exit {team:Canard,name_ennemies:Poules,color_ennemies:red}
execute if entity @s[team=sgp.Oie] run return run function sgp.majeurs:pco/participant_exit {team:Oie,name_ennemies:Canards,color_ennemies:green}

execute if entity @s[team=sgp.hider] run return run function sgp.majeurs:hide_and_seek/participant_exit
execute if entity @s[team=sgp.seeker] run return run function sgp.majeurs:hide_and_seek/participant_exit
function sgp.majeurs:common/eliminate_exit
