#> sgp.majeurs:pco/cabane/ground
# `{x, y, z, dz, dx, block_2, block_to_replace_2}`
#
# This function replaces the blocks of the ground of the cabane with the one specified

$execute positioned ~$(x) ~$(y) ~$(z) \
    run fill ~ ~-1 ~ ~$(dx) ~-1 ~$(dz) $(block_2) replace $(block_to_replace_2)