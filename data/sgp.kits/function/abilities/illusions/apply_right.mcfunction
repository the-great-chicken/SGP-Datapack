#> sgp.kits:abilities/illusions/apply_right

tp @s ~ ~ ~ ~-90 ~

# Swap the axes for the right mannequin (X = -Z, Z = X)
scoreboard players set @s bs.pos.x 0
scoreboard players operation @s bs.pos.x -= $pz bs.in
scoreboard players operation @s bs.pos.z = $px bs.in