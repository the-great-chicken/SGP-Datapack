#> sgp.majeurs:hide_and_seek/teams/round_reset
# @dummy
# @environment sgp.ci:hider_teams
#
# A new hider round restores bonuses lost previously, while resetting one player leaves another group's penalties intact.

function sgp.ci:hider_teams/linked_roster
scoreboard players set @s sgp.teammate_deaths 2
tag @s add sgp.lost_jump_msg
tag @s add sgp.lost_speed_msg
function sgp.majeurs:hide_and_seek/role/effect/hider
execute store result score @s sgp.dummy run attribute @s minecraft:movement_speed get 1000
assert score @s sgp.dummy matches 100
assert not entity @s[nbt={active_effects:[{id:"minecraft:jump_boost"}]}]
scoreboard players set HsGroup3 sgp.teammate_deaths 2
execute as HsGroup3 run function sgp.majeurs:hide_and_seek/role/effect/hider

function sgp.majeurs:hide_and_seek/reset_player
assert not score @s sgp.link_teams matches 1..
assert not score @s sgp.teammate_deaths matches 0..
assert not entity @s[tag=sgp.lost_jump_msg]
assert not entity @s[tag=sgp.lost_speed_msg]
function sgp.majeurs:hide_and_seek/role/hider
function sgp.majeurs:hide_and_seek/role/effect/hider
execute store result score @s sgp.dummy run attribute @s minecraft:movement_speed get 1000
assert score @s sgp.dummy matches 120
assert entity @s[nbt={active_effects:[{id:"minecraft:jump_boost"}]}]
assert score HsGroup3 sgp.teammate_deaths matches 2
execute store result score HsGroup3 sgp.dummy run attribute HsGroup3 minecraft:movement_speed get 1000
assert score HsGroup3 sgp.dummy matches 100
assert not entity @a[name=HsGroup3,nbt={active_effects:[{id:"minecraft:jump_boost"}]}]
