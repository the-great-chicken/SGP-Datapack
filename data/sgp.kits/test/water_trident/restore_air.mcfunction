#> sgp.kits:water_trident/restore_air
# @dummy
# @environment sgp.ci:water_trident
#
# Cleanup restores each replaced air variant and leaves unrelated natural water intact.

function sgp.ci:water_trident/fixture
setblock ~8 ~1 ~ cave_air strict
setblock ~12 ~1 ~ void_air strict
execute positioned ~6 ~1 ~ run function sgp.kits:abilities/water_trident/place_water
execute positioned ~8 ~1 ~ run function sgp.kits:abilities/water_trident/place_water
execute positioned ~12 ~1 ~ run function sgp.kits:abilities/water_trident/place_water
assert block ~6 ~1 ~ water
assert block ~8 ~1 ~ water
assert block ~12 ~1 ~ water
function sgp.kits:abilities/water_trident/tick
assert block ~6 ~1 ~ air
assert block ~8 ~1 ~ cave_air
assert block ~12 ~1 ~ void_air
assert block ~4 ~1 ~ water
assert not entity @e[tag=sgp.marker,name=temp_water,distance=..24,type=marker]
