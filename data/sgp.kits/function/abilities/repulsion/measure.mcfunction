#> sgp.kits:abilities/repulsion/measure
#
# Executed as the Archer 10 ticks after activation.

attribute @s gravity modifier remove sgp.kits:repulsion

execute at @s run function #bs.position:get_pos {scale:1000}

scoreboard players operation $vector.length.0 bs.in = @s bs.pos.x
scoreboard players operation $vector.length.0 bs.in -= @s sgp.old_x
scoreboard players operation $vector.length.1 bs.in = @s bs.pos.y
scoreboard players operation $vector.length.1 bs.in -= @s sgp.old_y
scoreboard players operation $vector.length.2 bs.in = @s bs.pos.z
scoreboard players operation $vector.length.2 bs.in -= @s sgp.old_z

function #bs.vector:length

scoreboard players operation #ability_metric_delta sgp.dummy = $vector.length bs.out
function sgp.kits:stats_collector/ability/increment_score {kit_id:2,ability_path:"repulsion",metric:"total_displacement"}

execute if score $vector.length bs.out matches 4001.. \
    run function sgp.kits:stats_collector/ability/mark_success {kit_id:2,ability_path:"repulsion"}
