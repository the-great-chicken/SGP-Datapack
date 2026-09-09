#> sgp.ci:rays/scenarios/damage_range

function sgp.ci:rays/prepare_damage
tp RayNear 8.5 88.0 23.5
tp RayFar 8.5 88.0 25.5
function sgp.ci:rays/update
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 19750
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 20000
