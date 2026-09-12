#> sgp.majeurs:reconnect_cleanup/during_later_event
# @dummy
# @environment sgp.ci:major_reconnect
#
# A participant returning from an older round is stale even while a different
# major event is active; the current event participant must remain untouched.

dummy MajorActivePeer spawn
tag MajorActivePeer add sgp.in_game
tag MajorActivePeer add sgp.major_participant
tag MajorActivePeer add sgp.major.protect
team join sgp.rouge MajorActivePeer

tag @s add sgp.in_game
tag @s add sgp.major_participant
tag @s add sgp.major.hide_and_seek
tag @s add sgp.seeker
attribute @s minecraft:attack_damage base set 1
attribute @s minecraft:attack_damage modifier add sgp:hide_and_seek.seeker 1000 add_value
give @s minecraft:stone_axe 1

function sgp.majeurs:repair_reconnected_players
assert score @s sgp.synthetic_death matches 1
assert score @s sgp.just_died matches 1
function sgp.misc:on_death

assert entity @s[gamemode=survival,team=,tag=!sgp.major_participant,tag=!sgp.major.hide_and_seek,tag=!sgp.seeker]
assert not entity @s[nbt={Inventory:[{}]}]
execute store result score @s sgp.dummy run attribute @s minecraft:attack_damage get 100
assert score @s sgp.dummy matches 100
assert entity @a[name=MajorActivePeer,team=sgp.rouge,tag=sgp.major_participant,tag=sgp.major.protect]
