#> sgp.majeurs:hide_and_seek/roles/conversion_delay
# @dummy
# @environment sgp.ci:hider_teams/release
# @timeout 650
#
# A caught hider waits thirty seconds before hunting. Dying while waiting neither releases them early nor restarts the delay.

function sgp.ci:hider_teams/seeker_roster
function sgp.majeurs:hide_and_seek/reset_player
function sgp.majeurs:hide_and_seek/role/hider
tag @s add sgp.hider
scoreboard players set @s sgp.link_teams 7
function sgp.majeurs:hide_and_seek/died
assert entity @s[team=sgp.seeker,tag=sgp.seeker_waiting]
assert not entity @s[tag=sgp.hider]
await delay 21t
scoreboard players operation @s sgp.dummy = @s sgp.timer
clear @s
effect clear @s
function sgp.majeurs:hide_and_seek/died
assert score @s sgp.timer = @s sgp.dummy
assert entity @s[tag=sgp.seeker_waiting]
execute store result score @s sgp.dummy run attribute @s minecraft:movement_speed get 1000
assert score @s sgp.dummy matches 0
execute store result score @s sgp.dummy run clear @s minecraft:stone_axe 0
assert score @s sgp.dummy matches 0

await delay 560t
assert entity @s[tag=sgp.seeker_waiting]
execute store result score @s sgp.dummy run attribute @s minecraft:movement_speed get 1000
assert score @s sgp.dummy matches 0
await delay 21t
assert entity @s[team=sgp.seeker,tag=sgp.seeker]
assert not entity @s[tag=sgp.seeker_waiting]
assert not entity @s[nbt={active_effects:[{id:"minecraft:blindness"}]}]
execute store result score @s sgp.dummy run attribute @s minecraft:movement_speed get 1000
assert score @s sgp.dummy matches 140
execute store result score @s sgp.dummy run attribute @s minecraft:attack_damage get 100
assert score @s sgp.dummy matches 1..
execute store result score @s sgp.dummy run clear @s minecraft:stone_axe 0
assert score @s sgp.dummy matches 1
execute store result score @s sgp.dummy run clear @s minecraft:ender_pearl 0
assert score @s sgp.dummy matches 8
assert entity @a[name=HsGroup1,team=sgp.seeker,tag=sgp.seeker_waiting]
assert entity @a[name=HsGroup2,team=sgp.hider]
