#> sgp.kits:abilities/bats/check_for_explosion
#
# Per-cast +1s wake. It preserves each cast's exact minimum fuse while all subsequent retries share one replace-scheduled loop.

function sgp.kits:abilities/bats/scan_for_explosion

execute if entity @e[tag=sgp.bat_grenade,tag=!sgp.bat_detonated,limit=1,type=bat] run schedule function sgp.kits:abilities/bats/check_explosion_loop 8t replace
