#> sgp.majeurs:hide_and_seek/roles/active_respawn
# @dummy
# @environment sgp.ci:hider_teams
#
# A released seeker's death restores their hunting equipment and mobility without another waiting period.

function sgp.ci:hider_teams/seeker_roster
scoreboard players set #seeker sgp.timer 0
function sgp.majeurs:hide_and_seek/timer/seeker
# Establish the empty inventory and effects left by a normal death before calling the event's respawn handler.
clear @s
effect clear @s
tp @s ~5.5 ~1 ~3.5
function sgp.majeurs:hide_and_seek/died
assert entity @s[team=sgp.seeker,tag=sgp.seeker]
assert not entity @s[tag=sgp.seeker_waiting]
execute positioned ~2.5 ~1 ~2.5 run assert entity @s[distance=..0.1]
execute store result score @s sgp.dummy run attribute @s minecraft:movement_speed get 1000
assert score @s sgp.dummy matches 140
assert not entity @s[nbt={active_effects:[{id:"minecraft:blindness"}]}]
execute store result score @s sgp.dummy run clear @s minecraft:stone_axe 0
assert score @s sgp.dummy matches 1
execute store result score @s sgp.dummy run clear @s minecraft:ender_pearl 0
assert score @s sgp.dummy matches 8
execute store success score @s sgp.dummy if items entity @s armor.head minecraft:leather_helmet
assert score @s sgp.dummy matches 1
execute store result score @s sgp.dummy run attribute @s minecraft:attack_damage get 100
assert score @s sgp.dummy matches 1..
assert score HsGroup2 sgp.teammate_deaths matches 0
assert entity @a[name=HsGroup2,team=sgp.hider]
