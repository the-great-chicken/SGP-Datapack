#> sgp.kits:abilities/assassinate/check_tp_position
#
# Check the lane behind the attacker/target and summon the pearl at the best safe position.
# Priority:
#   1. 2 blocks behind, if the whole lane to it is usable at the same height
#   2. 1 block behind
#   3. very close behind as a last resort

execute if function sgp.kits:abilities/assassinate/try_summon_2_behind run return 1
execute if function sgp.kits:abilities/assassinate/try_summon_1_behind run return 1

execute positioned ^ ^ ^-0.2 run return run function sgp.kits:abilities/assassinate/summon_pearl
