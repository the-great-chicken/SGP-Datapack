#> sgp.kits:abilities/illusions/apply_opposite

tp @s ~ ~ ~ ~180 ~

# Set both X and Z for the opposite mannequin
scoreboard players operation @s bs.pos.x = $px bs.in
scoreboard players operation @s bs.pos.z = $pz bs.in