#> sgp.majeurs:hide_and_seek/roles/hiding_phase_end
# @dummy
# @environment sgp.ci:hider_teams
#
# Hiders lose their hiding-time protection and invisibility when hunting starts, receiving only their surviving group bonuses.

function sgp.ci:hider_teams/seeker_roster
assert entity @a[name=HsGroup2,nbt={active_effects:[{id:"minecraft:invisibility"},{id:"minecraft:resistance"}]}]
execute store result score HsGroup2 sgp.dummy run attribute HsGroup2 minecraft:movement_speed get 1000
assert score HsGroup2 sgp.dummy matches 200
scoreboard players set #hider sgp.timer 0
function sgp.majeurs:hide_and_seek/timer/hider
assert not entity @a[name=HsGroup2,nbt={active_effects:[{id:"minecraft:invisibility"}]}]
assert not entity @a[name=HsGroup2,nbt={active_effects:[{id:"minecraft:resistance"}]}]
assert entity @a[name=HsGroup2,nbt={active_effects:[{id:"minecraft:jump_boost"}]}]
execute store result score HsGroup2 sgp.dummy run attribute HsGroup2 minecraft:movement_speed get 1000
assert score HsGroup2 sgp.dummy matches 120
assert entity @s[tag=sgp.seeker_waiting,nbt={active_effects:[{id:"minecraft:blindness"}]}]

# A group loss during hiding time must still be respected at release.
execute as HsGroup2 run function sgp.majeurs:hide_and_seek/role/hider
scoreboard players set HsGroup2 sgp.teammate_deaths 1
scoreboard players set #hider sgp.timer 0
function sgp.majeurs:hide_and_seek/timer/hider
assert not entity @a[name=HsGroup2,nbt={active_effects:[{id:"minecraft:jump_boost"}]}]
execute store result score HsGroup2 sgp.dummy run attribute HsGroup2 minecraft:movement_speed get 1000
assert score HsGroup2 sgp.dummy matches 120
