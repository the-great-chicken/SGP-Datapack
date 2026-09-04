#> sgp.kits:stats_collector/player_identity/capture
#
# Executed as a player when their identity snapshot needs to be refreshed.

scoreboard players add @s sgp.leave_game 0

execute store result storage sgp:macro stats.current_player_identity.player_id int 1 \
    run scoreboard players get @s sgp.id
data modify storage sgp:macro stats.current_player_identity.uuid set from entity @s UUID

summon item ~ ~ ~ {Tags:["sgp.stats_identity"],Item:{id:"minecraft:stone",count:1},PickupDelay:32767s,Age:-32768s}
loot replace entity @e[tag=sgp.stats_identity,distance=..1,limit=1,type=item] contents loot sgp.kits:stats_collector/player_profile
data modify storage sgp:macro stats.current_player_identity.nickname set from entity @e[tag=sgp.stats_identity,distance=..1,limit=1,type=item] Item.components."minecraft:profile".name
kill @e[tag=sgp.stats_identity,distance=..1,limit=1,type=item]

function sgp.kits:stats_collector/player_identity/save with storage sgp:macro stats.current_player_identity
scoreboard players operation @s sgp.leave_seen = @s sgp.leave_game
