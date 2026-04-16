#> sgp.kits:abilities/illusions/apply_left

tp @s ~ ~ ~ ~90 ~

# Swap the axes for the LEFT mannequin (X = Z, Z = -X)
scoreboard players operation @s bs.pos.x = $pz bs.in
scoreboard players set @s bs.pos.z 0
scoreboard players operation @s bs.pos.z -= $px bs.in