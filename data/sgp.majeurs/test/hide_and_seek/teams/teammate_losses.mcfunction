#> sgp.majeurs:hide_and_seek/teams/teammate_losses
# @dummy
# @environment sgp.ci:hider_teams
#
# The first loss removes only the linked survivors' jump bonus, the second removes speed, and refreshing effects cannot restore lost bonuses.

function sgp.ci:hider_teams/linked_roster
function sgp.majeurs:hide_and_seek/died
assert entity @s[team=sgp.seeker,tag=sgp.seeker_waiting]
assert not entity @s[tag=sgp.hider]
assert not score @s sgp.link_teams matches 1..
assert entity @a[name=HsGroup2,team=sgp.hider]
assert score HsGroup1 sgp.teammate_deaths matches 1
assert score HsGroup2 sgp.teammate_deaths matches 1
assert not entity @a[name=HsGroup2,nbt={active_effects:[{id:"minecraft:jump_boost"}]}]
execute store result score HsGroup2 sgp.dummy run attribute HsGroup2 minecraft:movement_speed get 1000
assert score HsGroup2 sgp.dummy matches 120
assert chat ".*tu perds ton Saut Amélioré.*" HsGroup2

# A subsequent seeker death must not count as another loss for the former group.
function sgp.majeurs:hide_and_seek/died
assert score HsGroup1 sgp.teammate_deaths matches 1
assert score HsGroup2 sgp.teammate_deaths matches 1

execute as HsGroup1 run function sgp.majeurs:hide_and_seek/died
assert entity @a[name=HsGroup1,team=sgp.seeker,tag=sgp.seeker_waiting]
assert score HsGroup2 sgp.teammate_deaths matches 2
execute store result score HsGroup2 sgp.dummy run attribute HsGroup2 minecraft:movement_speed get 1000
assert score HsGroup2 sgp.dummy matches 100
assert not entity @a[name=HsGroup2,nbt={active_effects:[{id:"minecraft:jump_boost"}]}]
assert chat ".*tu perds ta Vitesse.*" HsGroup2

execute as HsGroup2 run function sgp.majeurs:hide_and_seek/role/effect/hider
execute store result score HsGroup2 sgp.dummy run attribute HsGroup2 minecraft:movement_speed get 1000
assert score HsGroup2 sgp.dummy matches 100
assert not entity @a[name=HsGroup2,nbt={active_effects:[{id:"minecraft:jump_boost"}]}]
assert score HsGroup3 sgp.teammate_deaths matches 0
assert score HsGroup4 sgp.teammate_deaths matches 0
assert entity @a[name=HsGroup3,nbt={active_effects:[{id:"minecraft:jump_boost"}]}]
execute store result score HsGroup3 sgp.dummy run attribute HsGroup3 minecraft:movement_speed get 1000
assert score HsGroup3 sgp.dummy matches 120

execute as HsGroup2 run function sgp.majeurs:hide_and_seek/died
assert entity @a[name=HsGroup2,team=sgp.seeker,tag=sgp.seeker_waiting]
assert entity @a[name=HsGroup3,team=sgp.hider]
assert entity @a[name=HsGroup4,team=sgp.hider]
assert score HsGroup3 sgp.teammate_deaths matches 0
assert score HsGroup4 sgp.teammate_deaths matches 0
