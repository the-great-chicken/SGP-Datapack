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

# Update the illusions' pose only when it changed: the entity NBT write costs ~25 µs per mannequin per tick.
execute if score @s sgp.illusion_pose = #pose sgp.dummy run return 0
scoreboard players operation @s sgp.illusion_pose = #pose sgp.dummy
execute if score #pose sgp.dummy matches 1 run return run data modify entity @s pose set value "crouching"
execute if score #pose sgp.dummy matches 2 run return run data modify entity @s pose set value "swimming"
execute if score #pose sgp.dummy matches 0 run return run data modify entity @s pose set value "standing"