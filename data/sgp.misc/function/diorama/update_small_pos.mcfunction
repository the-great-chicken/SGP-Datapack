#> sgp.misc:diorama/update_small_pos
# `{id: int}`

# Grab the player's exact position and rotation
# We scale by 1000 (milliblocks/millidegrees) to prevent the division by 16 from wiping out fractional precision!
function #bs.position:get_pos_and_rot {scale:1000}

$function sgp.misc:diorama/compute_diorama_pos {id:$(id)}

# Store the final position and rotation into global temporary fake players
scoreboard players operation $temp_x sgp.dummy = @s bs.pos.x
scoreboard players operation $temp_y sgp.dummy = @s bs.pos.y
scoreboard players operation $temp_z sgp.dummy = @s bs.pos.z
scoreboard players operation $temp_h sgp.dummy = @s bs.rot.h
scoreboard players operation $temp_v sgp.dummy = @s bs.rot.v

# Update the player's pose status
scoreboard players set $pose sgp.dummy 0
execute if predicate sgp.misc:is_sneaking run scoreboard players set $pose sgp.dummy 1
execute if predicate sgp.misc:is_swimming run scoreboard players set $pose sgp.dummy 2
execute if predicate sgp.misc:is_fall_flying run scoreboard players set $pose sgp.dummy 3

# Don't directly use `#bs.link:as_children`, as the @e is too expensive without the type
scoreboard players operation $link.to bs.in = @s bs.id
$execute as @e[predicate=bs.link:link_equal,tag=sgp.small_mannequin_$(id),type=mannequin] run function sgp.misc:diorama/apply_mannequin_pos

# Only update weapons once every few ticks else it's too performance-intensive
execute unless score #mannequin_update_time sgp.dummy matches 4.. run return 1
$item replace entity @e[predicate=bs.link:link_equal,tag=sgp.small_mannequin_$(id),type=mannequin] weapon.mainhand from entity @s weapon.mainhand
$item replace entity @e[predicate=bs.link:link_equal,tag=sgp.small_mannequin_$(id),type=mannequin] weapon.offhand from entity @s weapon.offhand