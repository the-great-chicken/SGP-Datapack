#> sgp.majeurs:hide_and_seek/roles/initial_release
# @dummy
# @environment sgp.ci:hider_teams
#
# Seekers cannot move or attack during hiding time; the opening countdown releases all initial seekers with hunting equipment.

function sgp.ci:hider_teams/seeker_roster
assert entity @s[tag=sgp.seeker_waiting,team=sgp.seeker]
execute store result score @s sgp.dummy run attribute @s minecraft:movement_speed get 1000
assert score @s sgp.dummy matches 0
execute store result score @s sgp.dummy run attribute @s minecraft:attack_damage get 100
assert score @s sgp.dummy matches 0
assert entity @s[nbt={active_effects:[{id:"minecraft:blindness"}]}]
execute store result score @s sgp.dummy run clear @s minecraft:stone_axe 0
assert score @s sgp.dummy matches 0

scoreboard players set #seeker sgp.timer 0
function sgp.majeurs:hide_and_seek/timer/seeker
assert not entity @a[tag=sgp.ci.hider_actor,team=sgp.seeker,tag=sgp.seeker_waiting]
assert not entity @s[nbt={active_effects:[{id:"minecraft:blindness"}]}]
assert not entity @s[nbt={active_effects:[{id:"minecraft:resistance"}]}]
execute store result score @s sgp.dummy run attribute @s minecraft:movement_speed get 1000
assert score @s sgp.dummy matches 140
execute store result score @s sgp.dummy run attribute @s minecraft:attack_damage get 100
assert score @s sgp.dummy matches 1..
execute store result score @s sgp.dummy run clear @s minecraft:stone_axe 0
assert score @s sgp.dummy matches 1
execute store result score @s sgp.dummy run clear @s minecraft:ender_pearl 0
assert score @s sgp.dummy matches 8
execute store result score HsGroup1 sgp.dummy run clear HsGroup1 minecraft:stone_axe 0
assert score HsGroup1 sgp.dummy matches 1
assert entity @a[name=HsGroup2,team=sgp.hider,nbt={active_effects:[{id:"minecraft:invisibility"}]}]
execute store result score HsGroup2 sgp.dummy run clear HsGroup2 minecraft:stone_axe 0
assert score HsGroup2 sgp.dummy matches 0
