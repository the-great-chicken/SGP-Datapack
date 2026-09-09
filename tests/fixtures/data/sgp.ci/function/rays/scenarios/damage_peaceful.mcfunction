#> sgp.ci:rays/scenarios/damage_peaceful

function sgp.ci:rays/prepare_damage
tag RayNear add sgp.peaceful
function sgp.ci:rays/update
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 20000
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 19750
assert entity @s[nbt={Health:20.0f}]
