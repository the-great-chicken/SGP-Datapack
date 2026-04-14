#> sgp.kits:abilities/illusions/apply_offset

# Common: Copy Y normally (but inverted)
scoreboard players set @s bs.pos.y 0
scoreboard players operation @s bs.pos.y -= $py bs.in

# Route to the specific direction's math and rotation
execute if entity @s[tag=sgp.direction_left] run function sgp.kits:abilities/illusions/apply_left
execute if entity @s[tag=sgp.direction_opposite] run function sgp.kits:abilities/illusions/apply_opposite
execute if entity @s[tag=sgp.direction_right] run function sgp.kits:abilities/illusions/apply_right

# Common: Add the swapped offset to push the mannequin into formation
function #bs.position:add_pos {scale:0.001}

# Update the illusions' pose
execute if score #pose sgp.dummy matches 1 unless data entity @s {pose:"crouching"} run return run data modify entity @s pose set value "crouching"
execute if score #pose sgp.dummy matches 2 unless data entity @s {pose:"swimming"} run return run data modify entity @s pose set value "swimming"
execute if score #pose sgp.dummy matches 0 unless data entity @s {pose:"standing"} run return run data modify entity @s pose set value "standing"