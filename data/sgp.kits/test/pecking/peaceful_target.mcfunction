#> sgp.kits:pecking/peaceful_target
# @dummy
# @environment sgp.ci:pecking
#
# A nearby peaceful player cannot sustain the attack or receive damage.

function sgp.ci:pecking/fixture
tag PeckNear add sgp.peaceful
execute at @s run function sgp.kits:abilities/route_tick
function sgp.ci:pecking/expect_stopped
assert entity @a[name=PeckNear,nbt={Health:20.0f}]
assert entity @s[nbt={Health:20.0f}]
