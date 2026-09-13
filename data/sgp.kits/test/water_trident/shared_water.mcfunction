#> sgp.kits:water_trident/shared_water
# @dummy
# @environment sgp.ci:water_trident
#
# Temporary water remains while another in-game player occupies it and disappears after the last player leaves.

function sgp.ci:water_trident/fixture
execute at @s align xyz run function sgp.kits:abilities/water_trident/place_water
function sgp.kits:abilities/water_trident/tick
assert block ~ ~1 ~ water
function sgp.ci:water_trident/expect_riptide {present:1}
dummy WaterGuest spawn
tag WaterGuest add sgp.ci.water_actor
tag WaterGuest add sgp.in_game
gamemode creative WaterGuest
tp WaterGuest ~0.5 ~1 ~0.5
tp @s ~10.5 ~1 ~0.5
function sgp.kits:abilities/water_trident/tick
assert block ~ ~1 ~ water
assert entity @e[tag=sgp.marker,name=temp_water,distance=..3,type=marker]
tp WaterGuest ~10.5 ~1 ~2.5
function sgp.kits:abilities/water_trident/tick
assert block ~ ~1 ~ air
assert not entity @e[tag=sgp.marker,name=temp_water,distance=..3,type=marker]
assert block ~4 ~1 ~ water
