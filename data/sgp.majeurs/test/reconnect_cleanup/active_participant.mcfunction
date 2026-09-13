#> sgp.majeurs:reconnect_cleanup/active_participant
# @dummy
# @environment sgp.ci:major_reconnect
#
# Reconnect repair must leave a participant alone when their event team still
# proves that the current round owns their state.

tag @s add sgp.in_game
tag @s add sgp.major_participant
tag @s add sgp.major.hide_and_seek
tag @s add sgp.seeker
team join sgp.seeker @s
attribute @s minecraft:attack_damage base set 1
attribute @s minecraft:attack_damage modifier add sgp:hide_and_seek.seeker 1000 add_value
effect give @s minecraft:speed infinite 1 true
give @s minecraft:stone_axe 1

scoreboard players set @s sgp.synthetic_death 0
scoreboard players set @s sgp.just_died 0
function sgp.majeurs:repair_reconnected_players

assert score @s sgp.synthetic_death matches 0
assert score @s sgp.just_died matches 0
assert entity @s[team=sgp.seeker,tag=sgp.major_participant,tag=sgp.major.hide_and_seek,tag=sgp.seeker]
assert entity @s[nbt={active_effects:[{id:"minecraft:speed"}]}]
assert entity @s[nbt={Inventory:[{id:"minecraft:stone_axe"}]}]
execute store result score @s sgp.dummy run attribute @s minecraft:attack_damage get 100
assert score @s sgp.dummy matches 100100
