#> sgp.ci:rays/damage_diagnostics
# Failure-only snapshot; ordinary assertions remain authoritative.

data modify storage sgp.ci:rays diagnostic set value {beams:[]}
data modify storage sgp.ci:rays diagnostic.caster set from entity @s Pos
data modify storage sgp.ci:rays diagnostic.near_pos set from entity RayNear Pos
data modify storage sgp.ci:rays diagnostic.far_pos set from entity RayFar Pos
data modify storage sgp.ci:rays diagnostic.near_health set from entity RayNear Health
data modify storage sgp.ci:rays diagnostic.far_health set from entity RayFar Health
execute as @e[tag=sgp.ray,type=item_display] run function sgp.ci:rays/diagnostic_beam
function sgp.ci:rays/say_damage_diagnostics with storage sgp.ci:rays diagnostic
