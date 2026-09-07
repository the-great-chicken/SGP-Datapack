#> sgp.kits:water_trident/replaced_block
# @dummy
# @environment sgp.ci:water_trident
#
# A block placed over temporary water belongs to the world; cleanup removes its tracking marker without erasing the replacement.

function sgp.ci:water_trident/fixture
execute positioned ~8 ~1 ~ run function sgp.kits:abilities/water_trident/place_water
assert block ~8 ~1 ~ water
assert entity @e[tag=sgp.marker,name=temp_water,distance=..24,type=marker]
setblock ~8 ~1 ~ stone
function sgp.kits:abilities/water_trident/tick
assert block ~8 ~1 ~ stone
assert not entity @e[tag=sgp.marker,name=temp_water,distance=..24,type=marker]
function sgp.kits:abilities/water_trident/tick
assert block ~8 ~1 ~ stone
