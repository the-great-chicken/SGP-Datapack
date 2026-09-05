#> sgp.majeurs:hide_and_seek/participant_exit

execute unless entity @s[team=sgp.hider] unless entity @s[team=sgp.seeker] run return 0
function sgp.majeurs:hide_and_seek/actionbar/clear
execute if entity @s[team=sgp.hider] run return run function sgp.majeurs:hide_and_seek/hider_exit
function sgp.majeurs:hide_and_seek/reset_player
function sgp.majeurs:common/eliminate_exit
