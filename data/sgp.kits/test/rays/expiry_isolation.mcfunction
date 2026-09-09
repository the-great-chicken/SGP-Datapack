#> sgp.kits:rays/expiry_isolation
# @dummy
# @environment sgp.ci:rays/expiry_isolation
#
# Expiring one caster removes their beams and leaves another caster and unrelated displays intact.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/scenarios/expiry_isolation
