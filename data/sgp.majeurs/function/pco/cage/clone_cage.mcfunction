#> sgp.majeurs:pco/cage/clone_cage
# `{cage, x, y, z, x2, y2, z2}`
#
# Clone the current source structure into its active location-set destination.

$execute at @e[tag=sgp.marker,tag=sgp.pco.active,name="pco_$(cage)_cage_arena",limit=1,type=marker] \
    run clone $(x) $(y) $(z) $(x2) $(y2) $(z2) ~ ~ ~
