#> sgp.majeurs:pco/cage/restore
# `{cage}`
# Restore one closed cage after a release.

$execute as @e[tag=sgp.marker,tag=sgp.pco.active,name="pco_cage_storage",nbt={data:{cage:"$(cage)"}},limit=1,type=marker] \
    run function sgp.majeurs:pco/cage/compute_markers_coordinates

$execute as @e[tag=sgp.marker,tag=sgp.pco.active,name="pco_cage_storage",nbt={data:{cage:"$(cage)"}},limit=1,type=marker] \
    run function sgp.majeurs:pco/cage/clone_cage with entity @s data

$tag @e[tag=sgp.marker,tag=sgp.pco.active,name="pco_$(cage)_cage_arena",limit=1,type=marker] remove sgp.pco.cage_open
