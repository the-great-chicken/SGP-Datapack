#> sgp.kits:pecking/out_of_range
# @dummy
# @environment sgp.ci:pecking
#
# An opponent beyond reach cannot sustain the attack.

function sgp.ci:pecking/fixture
tp PeckNear ~4.5 ~1 ~10.5 0 0
execute at @s run function sgp.kits:abilities/route_tick
function sgp.ci:pecking/expect_stopped
assert entity @a[name=PeckNear,nbt={Health:20.0f}]
