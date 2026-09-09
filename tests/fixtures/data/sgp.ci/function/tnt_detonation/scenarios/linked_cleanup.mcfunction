#> sgp.ci:tnt_detonation/scenarios/linked_cleanup

function sgp.ci:tnt_detonation/fixture
execute positioned ~2.5 ~1 ~0.5 run tp @e[tag=sgp.ci.click_b,type=interaction] ~ ~ ~
execute positioned ~2.8 ~1 ~0.5 run tp @e[tag=sgp.ci.click_a,type=interaction] ~ ~ ~
function sgp.ci:tnt_detonation/detonate {target:a}
function sgp.ci:tnt_detonation/expect_fire {owner:98101,x:"~2.5"}
assert not entity @e[tag=sgp.ci.click_a,type=interaction]
assert entity @e[tag=sgp.ci.click_b,type=interaction]
assert entity @e[tag=sgp.ci.click_tnt_b,nbt={fuse:100s},type=tnt]
