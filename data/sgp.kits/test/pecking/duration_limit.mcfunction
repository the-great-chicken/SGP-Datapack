#> sgp.kits:pecking/duration_limit
# @dummy
# @environment sgp.ci:pecking
#
# The duration limit ends an attack even with an opponent still in sight.

function sgp.ci:pecking/fixture
scoreboard players set @s sgp.duration_ability 1
scoreboard players set @s sgp.pecking_timer 1
execute at @s run function sgp.kits:abilities/route_tick
function sgp.ci:pecking/expect_stopped
assert entity @a[name=PeckNear,nbt={Health:20.0f}]
