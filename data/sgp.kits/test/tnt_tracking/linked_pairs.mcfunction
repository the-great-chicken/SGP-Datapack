#> sgp.kits:tnt_tracking/linked_pairs
# @dummy
# @environment sgp.ci:tnt_tracking/linked_pairs
#
# Each hitbox follows its linked charge even when the other charge is much closer.

function sgp.ci:tnt/interaction_pairs/setup
tp @e[tag=sgp.ci.tnt_interaction_a,type=interaction] ~1.55 ~1 ~0.5
tp @e[tag=sgp.ci.tnt_interaction_b,type=interaction] ~2.45 ~1 ~0.5
execute as @e[tag=sgp.tnt_interaction,type=interaction] at @s run function sgp.kits:abilities/tnt/follow_interaction
execute positioned ~2.5 ~1 ~0.5 run assert entity @e[tag=sgp.ci.tnt_interaction_a,distance=..0.001,type=interaction]
execute positioned ~1.5 ~1 ~0.5 run assert entity @e[tag=sgp.ci.tnt_interaction_b,distance=..0.001,type=interaction]
