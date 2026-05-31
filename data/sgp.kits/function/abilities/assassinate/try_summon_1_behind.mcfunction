#> sgp.kits:abilities/assassinate/try_summon_1_behind
#
# Try to summon 1 block behind at the same accepted Y offsets as the 2-block check.

execute positioned ^ ^ ^-1 if function sgp.kits:abilities/assassinate/can_stand_here run return run function sgp.kits:abilities/assassinate/summon_pearl
execute positioned ~ ~0.5 ~ positioned ^ ^ ^-1 if function sgp.kits:abilities/assassinate/can_stand_here run return run function sgp.kits:abilities/assassinate/summon_pearl
execute positioned ~ ~1 ~ positioned ^ ^ ^-1 if function sgp.kits:abilities/assassinate/can_stand_here run return run function sgp.kits:abilities/assassinate/summon_pearl
execute positioned ~ ~1.5 ~ positioned ^ ^ ^-1 if function sgp.kits:abilities/assassinate/can_stand_here run return run function sgp.kits:abilities/assassinate/summon_pearl

return 0