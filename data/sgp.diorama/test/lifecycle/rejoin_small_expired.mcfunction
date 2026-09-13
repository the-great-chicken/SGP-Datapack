#> sgp.diorama:lifecycle/rejoin_small_expired
# @dummy
# @environment sgp.ci:diorama_rejoin/small_expired
# @timeout 240

gamemode spectator @s
tp @s 8.0 88.0 8.0
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:diorama_rejoin/fixture

tag @s add sgp.in_game
tp @s 34.0 81.0 34.0
function sgp.diorama:tick/main
function sgp.ci:diorama_rejoin/count {type:small,count:1}
assert score @s sgp.diorama_leave_seen matches 0
# Model the offline interval by withholding updates until the real Bookshelf TTL expires.
await delay 121t
assert not entity @e[tag=sgp.small_mannequin_96001,type=mannequin]
assert entity @s[tag=sgp.has_small_mannequin_96001]
# Reconnect changes leave_game while position and persistent ownership tags remain unchanged.
scoreboard players add @s sgp.leave_game 1
function sgp.diorama:tick/main
function sgp.ci:diorama_rejoin/count {type:small,count:1}
assert entity @s[tag=sgp.has_small_mannequin_96001]
assert score @s sgp.diorama_leave_seen matches 1
data modify storage sgp.ci:diorama_rejoin uuid set from entity @n[tag=sgp.small_mannequin_96001,predicate=bs.link:link_equal,type=mannequin] UUID
function sgp.diorama:tick/main
function sgp.ci:diorama_rejoin/count {type:small,count:1}
execute store success score #ci.rejoin.replaced sgp.dummy run data modify storage sgp.ci:diorama_rejoin uuid set from entity @n[tag=sgp.small_mannequin_96001,predicate=bs.link:link_equal,type=mannequin] UUID
assert score #ci.rejoin.replaced sgp.dummy matches 0
