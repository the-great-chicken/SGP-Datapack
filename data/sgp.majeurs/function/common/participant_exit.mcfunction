#> sgp.majeurs:common/participant_exit
#
# Route an exiting participant while their event team is still available.

function #sgp.majeurs:events/participant_exit
execute unless entity @s[tag=sgp.major_participant] run return 1

function sgp.majeurs:common/eliminate_exit
