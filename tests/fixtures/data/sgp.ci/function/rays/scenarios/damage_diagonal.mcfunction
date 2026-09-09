#> sgp.ci:rays/scenarios/damage_diagonal

function sgp.ci:rays/prepare_damage
tp RayNear 12.5 88.0 12.5
tp RayFar 10.5 88.0 14.5
function sgp.ci:rays/update
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 19750
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 20000
