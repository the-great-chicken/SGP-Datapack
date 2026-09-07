#> sgp.majeurs:protect/combat/blue_victory
# @dummy
# @environment sgp.ci:protect
#
# Eliminating the red king alone is insufficient; the last red defender's elimination awards blue and ends the round once.

function sgp.ci:protect/roster
tp PrRedKing ~30.5 ~1 ~0.5
tp PrRedA ~30.5 ~1 ~0.5
function sgp.majeurs:protect/running
assert score #protect_phase sgp.dummy matches 2
assert not chat ".*a gagné.*" @s
tp PrRedB ~30.5 ~1 ~0.5
function sgp.majeurs:protect/running
assert chat ".*Bleu a gagné.*" @s
assert not chat ".*Rouge a gagné.*" @s
function sgp.ci:protect/expect_finished
execute store result score PrBlueKing sgp.dummy run attribute PrBlueKing minecraft:max_health get
assert score PrBlueKing sgp.dummy matches 20
