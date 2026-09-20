#> sgp.kits:tnt_tracking/missing_charge
# @dummy
# @environment sgp.ci:tnt_tracking/missing_charge
#
# A missing linked charge never makes the hitbox attach to a different TNT.

function sgp.ci:tnt/interaction_pairs/setup
kill @e[tag=sgp.ci.tnt_charge_a,type=tnt]
tp @e[tag=sgp.ci.tnt_interaction_a,type=interaction] ~20.5 ~1 ~0.5
execute as @e[tag=sgp.ci.tnt_interaction_a,type=interaction] at @s run function sgp.kits:abilities/tnt/follow_interaction
execute positioned ~20.5 ~1 ~0.5 run assert entity @e[tag=sgp.ci.tnt_interaction_a,distance=..0.001,type=interaction]
execute positioned ~1.5 ~1 ~0.5 run assert entity @e[tag=sgp.ci.tnt_interaction_b,distance=..0.001,type=interaction]
