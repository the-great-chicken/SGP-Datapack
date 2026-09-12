#> sgp.diorama:lifecycle/rejoin_surviving_peer
# @dummy
# @environment sgp.ci:diorama_rejoin/surviving_peer

gamemode spectator @s
tp @s 8.0 88.0 8.0
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:diorama_rejoin/fixture

tag @s add sgp.in_game
tp @s 34.0 81.0 34.0
dummy RejoinPeer spawn
gamemode survival RejoinPeer
tag RejoinPeer add sgp.in_game
execute as RejoinPeer run function #bs.id:give_suid
tp RejoinPeer 35.0 81.0 34.0
scoreboard players set RejoinPeer sgp.leave_game 0
scoreboard players reset RejoinPeer sgp.diorama_leave_seen
function sgp.diorama:tick/main
function sgp.ci:diorama_rejoin/count {type:small,count:1}
execute as RejoinPeer run function sgp.ci:diorama_rejoin/count {type:small,count:1}
data modify storage sgp.ci:diorama_rejoin uuid set from entity @n[tag=sgp.small_mannequin_96001,predicate=bs.link:link_equal,type=mannequin] UUID
# A short disconnect must replace the returning owner's survivor without duplicating it or touching the peer.
scoreboard players add @s sgp.leave_game 1
function sgp.diorama:tick/main
function sgp.ci:diorama_rejoin/count {type:small,count:1}
execute as RejoinPeer run function sgp.ci:diorama_rejoin/count {type:small,count:1}
execute store success score #ci.rejoin.replaced sgp.dummy run data modify storage sgp.ci:diorama_rejoin uuid set from entity @n[tag=sgp.small_mannequin_96001,predicate=bs.link:link_equal,type=mannequin] UUID
assert score #ci.rejoin.replaced sgp.dummy matches 0
assert score @s sgp.diorama_leave_seen matches 1
assert score RejoinPeer sgp.diorama_leave_seen matches 0
