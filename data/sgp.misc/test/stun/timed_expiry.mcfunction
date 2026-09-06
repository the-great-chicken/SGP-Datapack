#> sgp.misc:stun/timed_expiry
# @dummy
#
# A timed stun prevents ordinary damage and suppresses movement/melee attributes, then expires without explicit cleanup.

gamemode survival @s
fill ~ ~1 ~ ~ ~3 ~ air
setblock ~ ~ ~ stone
tp @s ~0.5 ~1 ~0.5
attribute @s minecraft:movement_speed base set 0.1
attribute @s minecraft:attack_damage base set 4
# Wait for dummy client-loading protection before testing damage resistance.
await delay 61t

function sgp.misc:stun/apply {duration:1}
damage @s 6 minecraft:generic
execute store result storage sgp:data tests.stun_timed.protected_health int 1 run data get entity @s Health
execute store result storage sgp:data tests.stun_timed.stunned_speed int 1 run attribute @s minecraft:movement_speed get 1000
execute store result storage sgp:data tests.stun_timed.stunned_attack int 1 run attribute @s minecraft:attack_damage get 100

await delay 21t
execute store result storage sgp:data tests.stun_timed.restored_speed int 1 run attribute @s minecraft:movement_speed get 1000
execute store result storage sgp:data tests.stun_timed.restored_attack int 1 run attribute @s minecraft:attack_damage get 100
damage @s 6 minecraft:generic
execute store result storage sgp:data tests.stun_timed.exposed_health int 1 run data get entity @s Health

assert data storage sgp:data tests.stun_timed{protected_health:20,stunned_speed:0,stunned_attack:0,restored_speed:100,restored_attack:400,exposed_health:14}
assert not entity @s[nbt={active_effects:[{id:"minecraft:blindness"}]}]
assert not entity @s[nbt={active_effects:[{id:"minecraft:jump_boost"}]}]
data remove storage sgp:data tests.stun_timed
