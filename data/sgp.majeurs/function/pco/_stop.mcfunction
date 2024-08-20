# Supprime les cages
execute as @e[type=marker,tag=sgp.marker,name="pco_uncage_storage"] run function sgp.majeurs:pco/cage/compute_markers_coordinates
execute as @e[type=marker,tag=sgp.marker,name="pco_uncage_storage"] run function sgp.majeurs:pco/cage/clone_cage with entity @s data

useglow toggle

# Supprime les portillons des cabanes
execute as @e[type=marker,tag=sgp.marker,name="pco_cage_storage"] run function sgp.majeurs:pco/cabane/change_cabane_block {block:void_air, block_to_replace:warped_fence_gate}

execute as @a[tag=sgp.in_game] run trigger sgp.liberer_oies set 0
execute as @a[tag=sgp.in_game] run trigger sgp.liberer_canards set 0
execute as @a[tag=sgp.in_game] run trigger sgp.liberer_poules set 0

function sgp.majeurs:common/rounds with storage sgp:data majeurs.pco

function sgp.majeurs:common/stop