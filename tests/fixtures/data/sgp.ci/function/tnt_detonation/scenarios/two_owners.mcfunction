#> sgp.ci:tnt_detonation/scenarios/two_owners

function sgp.ci:tnt_detonation/fixture
function sgp.ci:tnt_detonation/detonate {target:a}
function sgp.ci:tnt_detonation/detonate {target:b}
function sgp.ci:tnt_detonation/expect_fire {owner:98101,x:"~2.5"}
function sgp.ci:tnt_detonation/expect_fire {owner:98102,x:"~1.5"}
assert not entity @e[tag=sgp.ci.click_a,type=interaction]
assert not entity @e[tag=sgp.ci.click_b,type=interaction]
execute store result score #ci.detonation.count sgp.dummy if entity @e[tag=sgp.ci.detonation_fire,type=marker]
assert score #ci.detonation.count sgp.dummy matches 2
