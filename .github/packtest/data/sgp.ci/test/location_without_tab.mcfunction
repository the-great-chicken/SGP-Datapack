#> Location entry/leave state remains functional without tab integration.
# @dummy

scoreboard objectives add sgp.ci_location dummy
scoreboard objectives add sgp.lieu_ci_a dummy
scoreboard objectives add sgp.lieu_ci_b dummy
scoreboard players operation #before sgp.ci_location = #tab_location_serial sgp.dummy

function sgp.world:lieu/enter {lieu:"ci_a"}
assert score @s sgp.lieu_ci_a > #before sgp.ci_location
scoreboard players operation #first sgp.ci_location = @s sgp.lieu_ci_a
function sgp.world:lieu/enter {lieu:"ci_b"}
assert score @s sgp.lieu_ci_b > #first sgp.ci_location
function sgp.world:lieu/leave {lieu:"ci_a"}
assert score @s sgp.lieu_ci_a matches 1
assert score @s sgp.lieu_ci_b > #first sgp.ci_location
function sgp.world:lieu/enter {lieu:"ci_a"}
assert score @s sgp.lieu_ci_a > @s sgp.lieu_ci_b

scoreboard objectives remove sgp.ci_location
scoreboard objectives remove sgp.lieu_ci_a
scoreboard objectives remove sgp.lieu_ci_b
