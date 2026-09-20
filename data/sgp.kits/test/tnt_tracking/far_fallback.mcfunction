#> sgp.kits:tnt_tracking/far_fallback
# @dummy
# @environment sgp.ci:tnt_tracking/far_fallback
#
# A hitbox still finds the exact linked charge if it is displaced beyond the local fast-path box.

function sgp.ci:tnt/interaction_pairs/setup
tp @e[tag=sgp.ci.tnt_interaction_a,type=interaction] ~20.5 ~1 ~0.5
execute as @e[tag=sgp.ci.tnt_interaction_a,type=interaction] at @s run function sgp.kits:abilities/tnt/follow_interaction
execute positioned ~2.5 ~1 ~0.5 run assert entity @e[tag=sgp.ci.tnt_interaction_a,distance=..0.001,type=interaction]
execute positioned ~1.5 ~1 ~0.5 run assert entity @e[tag=sgp.ci.tnt_interaction_b,distance=..0.001,type=interaction]
