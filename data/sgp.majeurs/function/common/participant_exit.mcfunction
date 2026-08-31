#> sgp.majeurs:common/participant_exit
#
# Route an exiting participant while their event team is still available.

function #sgp.majeurs:events/participant_exit
execute unless entity @s[tag=sgp.major_participant] run return 1

execute if entity @s[team=sgp.hider] run return run function sgp.majeurs:hide_and_seek/participant_exit
execute if entity @s[team=sgp.seeker] run return run function sgp.majeurs:hide_and_seek/participant_exit
function sgp.majeurs:common/eliminate_exit
