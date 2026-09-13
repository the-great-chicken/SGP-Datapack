#> sgp.diorama:lifecycle/rejoin_missing_id_peer
# @dummy
# @environment sgp.ci:diorama_rejoin/missing_id_peer
#
# First initialization without bs.id must not consume a previous owner's shared link input.

gamemode spectator @s
tp @s 8.0 88.0 8.0
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:diorama_rejoin/fixture

tag @s add sgp.in_game
tp @s 60.0 81.0 60.0
dummy RejoinPeer spawn
gamemode survival RejoinPeer
tag RejoinPeer add sgp.in_game
execute as RejoinPeer run function #bs.id:give_suid
tp RejoinPeer 35.0 81.0 34.0
scoreboard players set RejoinPeer sgp.leave_game 0
scoreboard players reset RejoinPeer sgp.diorama_leave_seen
function sgp.diorama:tick/main
execute as RejoinPeer run function sgp.ci:diorama_rejoin/count {type:small,count:1}

# Reproduce the dangerous state: the joining player has no source id while the
# shared Bookshelf link input still names the peer.
scoreboard players operation $link.to bs.in = RejoinPeer bs.id
scoreboard players reset @s bs.id
scoreboard players reset @s sgp.diorama_leave_seen
function sgp.diorama:player_initialization

assert score @s bs.id matches 1..
assert score $link.to bs.in = @s bs.id
execute as RejoinPeer run function sgp.ci:diorama_rejoin/count {type:small,count:1}
dummy RejoinPeer leave
