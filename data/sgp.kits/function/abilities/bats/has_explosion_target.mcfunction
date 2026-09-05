#> sgp.kits:abilities/bats/has_explosion_target
#
# Executed as and at a grenade bat.
# Returns whether a valid player or an Alchemist illusion is close enough to
# detonate the bat. Checking the targets in one function prevents a bat from
# detonating twice when both are nearby.

execute if entity @a[tag=sgp.in_game,tag=!sgp.cancer,tag=!sgp.peaceful,distance=..2.5] run return 1
execute if entity @e[tag=sgp.illusion,distance=..2.5,type=mannequin] run return 1

return 0
