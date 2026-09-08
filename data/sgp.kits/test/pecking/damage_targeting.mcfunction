#> sgp.kits:pecking/damage_targeting
# @dummy
# @environment sgp.ci:pecking/damage
#
# The nearer eligible opponent takes damage; peaceful players and the caster remain protected.

function sgp.ci:pecking/fixture
dummy PeckFar spawn
tag PeckFar add sgp.ci.peck_actor
gamemode survival PeckFar
tp PeckFar ~4.5 ~1 ~8.5 0 0
# Let the dummies finish their initial client-loading damage protection.
await delay 61t
tp @s ~4.5 ~1 ~4.5 0 0
tp PeckNear ~4.5 ~1 ~6.5 0 0
tp PeckFar ~4.5 ~1 ~8.5 0 0
assert entity @a[name=PeckNear,nbt={Health:20.0f}]
assert entity @a[name=PeckFar,nbt={Health:20.0f}]
execute at @s run function sgp.kits:abilities/route_tick
execute at @s run function sgp.kits:abilities/route_tick
assert entity @a[name=PeckNear,nbt={Health:18.5f}]
assert entity @a[name=PeckFar,nbt={Health:20.0f}]
assert entity @s[nbt={Health:20.0f}]
assert entity @s[tag=sgp.is_pecking]
assert score @s sgp.cooldown_ability matches 0
# Making the nearer player peaceful lets the attack reach the other opponent.
tag PeckNear add sgp.peaceful
execute at @s run function sgp.kits:abilities/route_tick
execute at @s run function sgp.kits:abilities/route_tick
assert entity @a[name=PeckNear,nbt={Health:18.5f}]
assert entity @a[name=PeckFar,nbt={Health:18.5f}]
assert entity @s[nbt={Health:20.0f}]
assert not entity @a[tag=sgp.ci.peck_actor,tag=sgp.is_being_pecked]
assert not entity @s[tag=sgp.source_peck]
