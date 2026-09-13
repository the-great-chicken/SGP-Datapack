#> sgp.majeurs:hide_and_seek/rounds/stop_cancels_release
# @dummy
# @environment sgp.ci:hider_teams/stop
#
# Stopping cancels both shared countdowns and the pending per-player conversion callback.

function sgp.ci:hider_teams/round_roster
function sgp.majeurs:hide_and_seek/role/become_seeker
scoreboard players set #hider sgp.timer 2
scoreboard players set #seeker sgp.timer 2
function sgp.majeurs:hide_and_seek/timer/hider
function sgp.majeurs:hide_and_seek/timer/seeker
assert entity @s[tag=sgp.seeker_waiting]
function sgp.majeurs:hide_and_seek/_stop
function sgp.ci:hider_teams/expect_round_finished

# Later timer values must not be consumed by callbacks belonging to the stopped round.
scoreboard players set #hider sgp.timer 71
scoreboard players set #seeker sgp.timer 72
scoreboard players set @s sgp.timer 73
await delay 21t
assert score #hider sgp.timer matches 71
assert score #seeker sgp.timer matches 72
assert score @s sgp.timer matches 73
assert not entity @s[tag=sgp.seeker_waiting]
assert not entity @s[nbt={active_effects:[{id:"minecraft:blindness"}]}]
execute store result score @s sgp.dummy run clear @s minecraft:stone_axe 0
assert score @s sgp.dummy matches 0
assert score #rounds sgp.dummy matches 1
