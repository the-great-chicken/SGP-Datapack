#> sgp.majeurs:common/participant_exit
#
# Route an exiting participant while their event team is still available.

function #sgp.majeurs:events/participant_exit
execute unless entity @s[tag=sgp.major_participant] run return 1

execute if entity @s[team=sgp.Poule] run return run function sgp.majeurs:pco/participant_exit {team:Poule,name_ennemies:Oies,color_ennemies:yellow}
execute if entity @s[team=sgp.Canard] run return run function sgp.majeurs:pco/participant_exit {team:Canard,name_ennemies:Poules,color_ennemies:red}
execute if entity @s[team=sgp.Oie] run return run function sgp.majeurs:pco/participant_exit {team:Oie,name_ennemies:Canards,color_ennemies:green}

execute if entity @s[team=sgp.hider] run return run function sgp.majeurs:hide_and_seek/participant_exit
execute if entity @s[team=sgp.seeker] run return run function sgp.majeurs:hide_and_seek/participant_exit
function sgp.majeurs:common/eliminate_exit
