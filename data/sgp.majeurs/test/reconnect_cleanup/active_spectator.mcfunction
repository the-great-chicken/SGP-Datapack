#> sgp.majeurs:reconnect_cleanup/active_spectator
# @dummy
# @environment sgp.ci:major_reconnect
#
# A legitimate spectator has no event team, so reconnect repair must keep them
# in spectator state while any major event is still active.

dummy MajorSpecPeer spawn
tag MajorSpecPeer add sgp.in_game
tag MajorSpecPeer add sgp.major_participant
tag MajorSpecPeer add sgp.major.protect
team join sgp.rouge MajorSpecPeer

tag @s add sgp.major_spectator
gamemode spectator @s
give @s minecraft:stone 1

function sgp.majeurs:repair_reconnected_players

assert entity @s[gamemode=spectator,tag=sgp.major_spectator,tag=!sgp.major_participant]
assert entity @s[nbt={Inventory:[{id:"minecraft:stone"}]}]
assert entity @a[name=MajorSpecPeer,team=sgp.rouge,tag=sgp.major_participant,tag=sgp.major.protect]
