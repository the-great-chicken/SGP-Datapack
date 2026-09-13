#> sgp.majeurs:reconnect_cleanup/hide_and_seek
# @dummy
# @environment sgp.ci:major_reconnect
#
# A Cache-cache participant who was offline at round end loses every retained
# role modifier/tag/loadout before normal gameplay can observe them.

tag @s add sgp.in_game
tag @s add sgp.major_participant
tag @s add sgp.major.hide_and_seek
tag @s add sgp.seeker
tag @s add sgp.seeker_waiting
attribute @s minecraft:attack_damage base set 1
attribute @s minecraft:water_movement_efficiency base set 0
attribute @s minecraft:attack_damage modifier add sgp:hide_and_seek.seeker 1000 add_value
attribute @s minecraft:water_movement_efficiency modifier add sgp:hide_and_seek.water_movement 1 add_value
effect give @s minecraft:speed infinite 1 true
give @s minecraft:stone_axe 1
gamemode spectator @s

function sgp.majeurs:repair_reconnected_players
assert score @s sgp.synthetic_death matches 1
assert score @s sgp.just_died matches 1
function sgp.misc:on_death

assert entity @s[gamemode=survival,tag=!sgp.major_participant,tag=!sgp.major_spectator,tag=!sgp.major.hide_and_seek,tag=!sgp.seeker,tag=!sgp.seeker_waiting]
assert not data entity @s active_effects[0]
assert not entity @s[nbt={Inventory:[{}]}]
execute store result score @s sgp.dummy run attribute @s minecraft:attack_damage get 100
assert score @s sgp.dummy matches 100
execute store result score @s sgp.dummy run attribute @s minecraft:water_movement_efficiency get 100
assert score @s sgp.dummy matches 0
