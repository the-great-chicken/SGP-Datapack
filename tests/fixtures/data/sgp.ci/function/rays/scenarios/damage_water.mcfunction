#> sgp.ci:rays/scenarios/damage_water

function sgp.ci:rays/prepare_damage
fill 8 88 9 8 88 11 water strict
setblock 8 88 12 stone
function sgp.ci:rays/update
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 19750
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 20000
