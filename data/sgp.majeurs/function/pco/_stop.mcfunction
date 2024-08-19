#> sgp.majeurs:pco/_stop
#
# Stop the PCO major event

# Remove the cages
execute as @e[type=marker,tag=sgp.marker,name="pco_uncage_storage"] \
    run function sgp.majeurs:pco/cage/compute_markers_coordinates

execute as @e[type=marker,tag=sgp.marker,name="pco_uncage_storage"] \
    run function sgp.majeurs:pco/cage/clone_cage with entity @s data


useglow toggle

# Remove the cabanes
execute as @e[type=marker,tag=sgp.marker,name="pco_cage_storage",nbt={data:{cage:"poule"}},limit=1] \
    run function sgp.majeurs:pco/cabane/change_cabane_block {block:void_air, block_to_replace:warped_fence_gate, block_2:white_concrete, block_to_replace_2:green_concrete, cage:"canard"}

execute as @e[type=marker,tag=sgp.marker,name="pco_cage_storage",nbt={data:{cage:"oie"}},limit=1] \
    run function sgp.majeurs:pco/cabane/change_cabane_block {block:void_air, block_to_replace:warped_fence_gate, block_2:white_concrete, block_to_replace_2:green_concrete, cage:"poule"}

execute as @e[type=marker,tag=sgp.marker,name="pco_cage_storage",nbt={data:{cage:"canard"}},limit=1] \
    run function sgp.majeurs:pco/cabane/change_cabane_block {block:void_air, block_to_replace:warped_fence_gate, block_2:white_concrete, block_to_replace_2:green_concrete, cage:"oie"}


execute as @a[tag=sgp.in_game] \
    run trigger sgp.liberer_oies set 0

execute as @a[tag=sgp.in_game] \
    run trigger sgp.liberer_canards set 0

execute as @a[tag=sgp.in_game] \
    run trigger sgp.liberer_poules set 0

function sgp.majeurs:common/stop