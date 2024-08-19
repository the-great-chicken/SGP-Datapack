#> sgp.majeurs:pco/cabane/outline
# `{x, y, z, dz, dx, dz1, dx1, block, block_to_replace}`
#
# This function tries to replace the blocks of the outline of the cabane
# with the one specified. It applies a direction to the blocks to make them face the right way.
# Returns 1 if successful, 0 otherwise

$execute positioned ~$(x) ~$(y) ~$(z) \
    run fill ~-1 ~ ~ ~-1 ~ ~$(dz) $(block)[facing=west] replace $(block_to_replace)

$execute positioned ~$(x) ~$(y) ~$(z) \
    run fill ~ ~ ~-1 ~$(dx) ~ ~-1 $(block)[facing=north] replace $(block_to_replace)

$execute positioned ~$(x) ~$(y) ~$(z) \
    run fill ~$(dx1) ~ ~ ~$(dx1) ~ ~$(dz) $(block)[facing=west] replace $(block_to_replace)

$execute positioned ~$(x) ~$(y) ~$(z) \
    run fill ~ ~ ~$(dz1) ~$(dx) ~ ~$(dz1) $(block)[facing=north] replace $(block_to_replace)

return 1