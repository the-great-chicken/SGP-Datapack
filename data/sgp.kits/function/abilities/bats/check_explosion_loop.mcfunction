#> sgp.kits:abilities/bats/check_explosion_loop
# At most one follow-up scan is pending. A per-cast +1s wake may move the next loop scan later,
# but the wake itself scans all armed bats, so scan gaps stay bounded by 8 ticks.

function sgp.kits:abilities/bats/scan_for_explosion

execute if entity @e[tag=sgp.bat_grenade,tag=!sgp.bat_detonated,limit=1,type=bat] run schedule function sgp.kits:abilities/bats/check_explosion_loop 8t replace
