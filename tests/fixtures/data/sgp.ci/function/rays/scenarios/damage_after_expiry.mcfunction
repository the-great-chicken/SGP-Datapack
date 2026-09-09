#> sgp.ci:rays/scenarios/damage_after_expiry

function sgp.ci:rays/prepare_damage
scoreboard players set @s sgp.duration_ability 1
function sgp.ci:rays/update
function sgp.ci:rays/count {count:0}
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 20000
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 20000
