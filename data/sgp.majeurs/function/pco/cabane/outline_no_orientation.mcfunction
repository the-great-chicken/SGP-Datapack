#> sgp.majeurs:pco/cabane/outline_no_orientation
# `{x, y, z, dz, dx, dz1, dx1, block, block_to_replace}`
#
# This function replaces the blocks of the outline of the cabane
# with the one specified, without any orientation applied.

$execute positioned $(x) $(y) $(z) \
    run fill ~-1 ~ ~ ~-1 ~ ~$(dz) $(block) replace $(block_to_replace)

$execute positioned $(x) $(y) $(z) \
    run fill ~ ~ ~-1 ~$(dx) ~ ~-1 $(block) replace $(block_to_replace)

$execute positioned $(x) $(y) $(z) \
    run fill ~$(dx1) ~ ~ ~$(dx1) ~ ~$(dz) $(block) replace $(block_to_replace)
    
$execute positioned $(x) $(y) $(z) \
    run fill ~ ~ ~$(dz1) ~$(dx) ~ ~$(dz1) $(block) replace $(block_to_replace)