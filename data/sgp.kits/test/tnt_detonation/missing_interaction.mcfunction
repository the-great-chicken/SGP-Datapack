#> sgp.kits:tnt_detonation/missing_interaction
# @dummy
# @environment sgp.ci:tnt_detonation/missing_interaction
#
# A charge without its own interaction does not remove another charge's target.

function sgp.ci:tnt_detonation/fixture
kill @e[tag=sgp.ci.click_a,type=interaction]
function sgp.ci:tnt_detonation/detonate {target:a}
function sgp.ci:tnt_detonation/expect_fire {owner:98101,x:"~2.5"}
assert entity @e[tag=sgp.ci.click_b,type=interaction]
