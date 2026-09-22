#> sgp.bench:scenarios/abilities/rays/position
# `{first: int}`
# Executed as one actor. Pack up to 9 actors per horizontal plane on a 34-block
# lattice, then stack planes 3 blocks apart. Players on one plane are too far
# apart to enter each other's Rays broad phase, and adjacent planes are vertically
# separated enough that their hitboxes cannot intersect the horizontal beams.

scoreboard players operation @s sgp.bench.clock = @s sgp.bench
$scoreboard players remove @s sgp.bench.clock $(first)

# X: ((index % 3) - 1) * 34
scoreboard players operation @s bs.pos.x = @s sgp.bench.clock
scoreboard players set #ray_sparse_cols sgp.bench 3
scoreboard players operation @s bs.pos.x %= #ray_sparse_cols sgp.bench
scoreboard players remove @s bs.pos.x 1
scoreboard players set #ray_sparse_horizontal sgp.bench 34000
scoreboard players operation @s bs.pos.x *= #ray_sparse_horizontal sgp.bench

# Z: (((index / 3) % 3) - 1) * 34
scoreboard players operation @s bs.pos.z = @s sgp.bench.clock
scoreboard players operation @s bs.pos.z /= #ray_sparse_cols sgp.bench
scoreboard players operation @s bs.pos.z %= #ray_sparse_cols sgp.bench
scoreboard players remove @s bs.pos.z 1
scoreboard players operation @s bs.pos.z *= #ray_sparse_horizontal sgp.bench

# Y: 81 + floor(index / 9) * 3
scoreboard players operation @s bs.pos.y = @s sgp.bench.clock
scoreboard players set #ray_sparse_per_plane sgp.bench 9
scoreboard players operation @s bs.pos.y /= #ray_sparse_per_plane sgp.bench
scoreboard players set #ray_sparse_vertical sgp.bench 3000
scoreboard players operation @s bs.pos.y *= #ray_sparse_vertical sgp.bench
scoreboard players add @s bs.pos.y 81000

function #bs.position:set_pos {scale:0.001}
execute at @s run tp @s ~ ~ ~ 0 0
