#> sgp.majeurs:protect/combat/aura_range
# @dummy
# @environment sgp.ci:protect/aura
#
# Only nearby allies gain extra maximum health; leaving the king's radius lets the bonus expire without weakening either king.

function sgp.ci:protect/roster
tp PrRedA ~5.5 ~1 ~0.5
tp PrRedB ~5.6 ~1 ~0.5
tp PrBlueA ~1.5 ~1 ~0.5
tp PrBlueB ~25.5 ~1 ~0.5
tp @s ~1.5 ~1 ~0.5
function sgp.majeurs:protect/running
execute store result score PrRedA sgp.dummy run attribute PrRedA minecraft:max_health get
assert score PrRedA sgp.dummy matches 24
execute store result score PrRedB sgp.dummy run attribute PrRedB minecraft:max_health get
assert score PrRedB sgp.dummy matches 20
execute store result score PrBlueA sgp.dummy run attribute PrBlueA minecraft:max_health get
assert score PrBlueA sgp.dummy matches 20
execute store result score PrBlueB sgp.dummy run attribute PrBlueB minecraft:max_health get
assert score PrBlueB sgp.dummy matches 24
execute store result score @s sgp.dummy run attribute @s minecraft:max_health get
assert score @s sgp.dummy matches 20
execute store result score PrRedKing sgp.dummy run attribute PrRedKing minecraft:max_health get
assert score PrRedKing sgp.dummy matches 40
execute store result score PrBlueKing sgp.dummy run attribute PrBlueKing minecraft:max_health get
assert score PrBlueKing sgp.dummy matches 40

tp PrRedA ~12.5 ~1 ~0.5
tp PrBlueB ~12.5 ~1 ~0.5
function sgp.majeurs:protect/running
await delay 61t
execute store result score PrRedA sgp.dummy run attribute PrRedA minecraft:max_health get
assert score PrRedA sgp.dummy matches 20
execute store result score PrBlueB sgp.dummy run attribute PrBlueB minecraft:max_health get
assert score PrBlueB sgp.dummy matches 20
assert score #protect_phase sgp.dummy matches 2
