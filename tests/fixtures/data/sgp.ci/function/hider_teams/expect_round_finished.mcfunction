#> sgp.ci:hider_teams/expect_round_finished
# Finishing removes event roles, bonuses, equipment and HUD state, and counts the round only once.

assert score #rounds sgp.dummy matches 1
assert not entity @a[team=sgp.hider]
assert not entity @a[team=sgp.seeker]
assert not entity @a[tag=sgp.ci.hider_actor,tag=sgp.major_participant]
assert not entity @a[tag=sgp.ci.hider_actor,tag=sgp.hider]
assert not entity @a[tag=sgp.ci.hider_actor,tag=sgp.seeker]
assert not entity @a[tag=sgp.ci.hider_actor,tag=sgp.seeker_waiting]
assert not entity @a[tag=sgp.ci.hider_actor,tag=sgp.lost_jump_msg]
assert not entity @a[tag=sgp.ci.hider_actor,tag=sgp.lost_speed_msg]
assert not entity @a[tag=sgp.ci.hider_actor,scores={sgp.ab.hide_hider=1..}]
assert not entity @a[tag=sgp.ci.hider_actor,gamemode=!survival]
execute as @a[tag=sgp.ci.hider_actor] store result score @s sgp.dummy run attribute @s minecraft:movement_speed get 1000
execute as @a[tag=sgp.ci.hider_actor] run assert score @s sgp.dummy matches 100
execute as @a[tag=sgp.ci.hider_actor] store result score @s sgp.dummy run attribute @s minecraft:attack_damage get 100
execute as @a[tag=sgp.ci.hider_actor] run assert score @s sgp.dummy matches 100
assert not entity @a[tag=sgp.ci.hider_actor,nbt={Inventory:[{}]}]
function sgp.majeurs:hide_and_seek/running
function sgp.majeurs:hide_and_seek/_stop
assert score #rounds sgp.dummy matches 1
