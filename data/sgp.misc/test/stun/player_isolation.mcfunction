#> sgp.misc:stun/player_isolation
# @dummy
#
# Applying or clearing one player's stun leaves another player's independent state intact.

attribute @s minecraft:movement_speed base set 0.1
attribute @s minecraft:attack_damage base set 2
dummy StunOther spawn
attribute StunOther minecraft:movement_speed base set 0.1
attribute StunOther minecraft:attack_damage base set 2
function sgp.misc:stun/apply {duration:infinite}
execute store result storage sgp:data tests.stun_players.first_speed int 1 run attribute @s minecraft:movement_speed get 1000
execute store result storage sgp:data tests.stun_players.first_attack int 1 run attribute @s minecraft:attack_damage get 100
execute store result storage sgp:data tests.stun_players.other_speed int 1 run attribute StunOther minecraft:movement_speed get 1000
execute store result storage sgp:data tests.stun_players.other_attack int 1 run attribute StunOther minecraft:attack_damage get 100

execute as StunOther run function sgp.misc:stun/apply {duration:infinite}
function sgp.misc:stun/clear
execute store result storage sgp:data tests.stun_players.first_restored_speed int 1 run attribute @s minecraft:movement_speed get 1000
execute store result storage sgp:data tests.stun_players.first_restored_attack int 1 run attribute @s minecraft:attack_damage get 100
execute store result storage sgp:data tests.stun_players.other_stunned_speed int 1 run attribute StunOther minecraft:movement_speed get 1000
execute store result storage sgp:data tests.stun_players.other_stunned_attack int 1 run attribute StunOther minecraft:attack_damage get 100
dummy StunOther leave

assert data storage sgp:data tests.stun_players{first_speed:0,first_attack:0,other_speed:100,other_attack:200,first_restored_speed:100,first_restored_attack:200,other_stunned_speed:0,other_stunned_attack:0}
data remove storage sgp:data tests.stun_players
