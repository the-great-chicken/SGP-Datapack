#> sgp.misc:stun/explicit_release
# @dummy
#
# An indefinite stun suppresses even a seeker's damage bonus; release preserves unrelated modifiers/effects and allows another stun.

attribute @s minecraft:movement_speed base set 0.1
attribute @s minecraft:movement_speed modifier add sgp:test_stun_speed 0.1 add_value
attribute @s minecraft:attack_damage base set 2
attribute @s minecraft:attack_damage modifier add sgp:test_stun_attack 1000 add_value
effect give @s night_vision infinite 0 true
function sgp.misc:stun/apply {duration:infinite}
await delay 25t
execute store result storage sgp:data tests.stun_release.stunned_speed int 1 run attribute @s minecraft:movement_speed get 1000
execute store result storage sgp:data tests.stun_release.stunned_attack int 1 run attribute @s minecraft:attack_damage get 100

function sgp.misc:stun/clear
execute store result storage sgp:data tests.stun_release.restored_speed int 1 run attribute @s minecraft:movement_speed get 1000
execute store result storage sgp:data tests.stun_release.restored_attack int 1 run attribute @s minecraft:attack_damage get 100
function sgp.misc:stun/clear
execute store result storage sgp:data tests.stun_release.cleared_again_speed int 1 run attribute @s minecraft:movement_speed get 1000
execute store result storage sgp:data tests.stun_release.cleared_again_attack int 1 run attribute @s minecraft:attack_damage get 100

function sgp.misc:stun/apply {duration:infinite}
execute store result storage sgp:data tests.stun_release.reapplied_speed int 1 run attribute @s minecraft:movement_speed get 1000
execute store result storage sgp:data tests.stun_release.reapplied_attack int 1 run attribute @s minecraft:attack_damage get 100
function sgp.misc:stun/clear

assert data storage sgp:data tests.stun_release{stunned_speed:0,stunned_attack:0,restored_speed:200,restored_attack:100200,cleared_again_speed:200,cleared_again_attack:100200,reapplied_speed:0,reapplied_attack:0}
assert entity @s[nbt={active_effects:[{id:"minecraft:night_vision"}]}]
assert not entity @s[nbt={active_effects:[{id:"minecraft:blindness"}]}]
assert not entity @s[nbt={active_effects:[{id:"minecraft:jump_boost"}]}]
data remove storage sgp:data tests.stun_release
