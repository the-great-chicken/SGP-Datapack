#> sgp.kits:pecking/lost_target
# @dummy
# @environment sgp.ci:pecking
#
# Turning away from an acquired opponent ends the attack and begins cooldown.

function sgp.ci:pecking/fixture
execute at @s run function sgp.kits:abilities/route_tick
assert entity @s[tag=sgp.is_pecking]
assert score @s sgp.cooldown_ability matches 0
tp @s ~4.5 ~1 ~4.5 180 0
execute at @s run function sgp.kits:abilities/route_tick
function sgp.ci:pecking/expect_stopped
assert entity @a[name=PeckNear,nbt={Health:20.0f}]
