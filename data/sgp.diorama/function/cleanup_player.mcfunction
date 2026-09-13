#> sgp.diorama:cleanup_player
# Clear ownership and any surviving mannequins for this player.

# Player-owned Bookshelf links must never reuse a stale shared link input.
execute unless score @s bs.id matches 1.. run function #bs.id:give_suid
scoreboard players operation $link.to bs.in = @s bs.id
tag @s add sgp.diorama_cleanup
function sgp.misc:loop_as_entity/init {list_location:"sgp:data markers_lists.playable_map", command:"run function sgp.diorama:tick/update_mannequin/remove with entity @s data"}
tag @s remove sgp.diorama_cleanup
