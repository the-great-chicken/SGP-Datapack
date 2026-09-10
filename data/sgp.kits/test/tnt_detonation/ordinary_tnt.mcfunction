#> sgp.kits:tnt_detonation/ordinary_tnt
# @dummy
# @environment sgp.ci:tnt_detonation/ordinary_tnt
#
# Ordinary TNT does not create Pyromane fire or remove ability interactions.

function sgp.ci:tnt_detonation/fixture
tag @e[tag=sgp.ci.click_tnt_a,type=tnt] remove sgp.tnt
data merge entity @e[tag=sgp.ci.click_tnt_a,limit=1,type=tnt] {fuse:1s}
function sgp.kits:abilities/tnt/explode_at
execute positioned ~2.5 ~1 ~0.5 run assert not entity @e[tag=sgp.fire_explosion,distance=..8,type=marker]
assert entity @e[tag=sgp.ci.click_a,type=interaction]
assert entity @e[tag=sgp.ci.click_b,type=interaction]
