#> sgp.ci:tnt_detonation/scenarios/fuse_dispatch

function sgp.ci:tnt_detonation/fixture
data merge entity @e[tag=sgp.ci.click_tnt_a,limit=1,type=tnt] {fuse:1s}
data merge entity @e[tag=sgp.ci.click_tnt_b,limit=1,type=tnt] {fuse:2s}
function sgp.kits:abilities/tnt/explode_at
execute positioned ~2.5 ~1 ~0.5 run tag @e[tag=sgp.fire_explosion,distance=..8,type=marker] add sgp.ci.detonation_fire
function sgp.ci:tnt_detonation/expect_fire {owner:98101,x:"~2.5"}
execute store result score #ci.detonation.count sgp.dummy if entity @e[tag=sgp.ci.detonation_fire,type=marker]
assert score #ci.detonation.count sgp.dummy matches 1
assert entity @e[tag=sgp.ci.click_b,type=interaction]
