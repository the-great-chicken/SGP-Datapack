
#> sgp.ci:bats_detonation/cleanup

schedule clear sgp.kits:abilities/bats/check_for_explosion
kill @e[tag=sgp.ci.bat_guard,type=bat]
kill @e[tag=sgp.ci.bat_guard_tnt,type=tnt]
function sgp.ci:players/cleanup
