#> sgp.majeurs:protect/combat/red_victory
# @dummy
# @environment sgp.ci:protect/combat/red_victory
#
# The mirrored blue-team elimination awards red, including when king and defenders reach respawn together.

function sgp.ci:protect/roster
tp PrBlueKing ~30.5 ~1 ~0.5
tp PrBlueA ~30.5 ~1 ~0.5
tp PrBlueB ~30.5 ~1 ~0.5
function sgp.majeurs:protect/running
assert chat ".*Rouge a gagné.*" @s
assert not chat ".*Bleu a gagné.*" @s
function sgp.ci:protect/expect_finished
execute store result score PrRedKing sgp.dummy run attribute PrRedKing minecraft:max_health get
assert score PrRedKing sgp.dummy matches 20
