#> sgp.majeurs:pco/_stop
#
# Stop the PCO major event

function sgp.majeurs:common/stop

# Remove the cages
execute as @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_uncage_storage"] \
    run function sgp.majeurs:pco/cage/compute_markers_coordinates

execute as @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_uncage_storage"] \
    run function sgp.majeurs:pco/cage/clone_cage with entity @s data


useglow toggle


execute as @a[tag=sgp.in_game] \
    run trigger sgp.liberer_oies set 0

execute as @a[tag=sgp.in_game] \
    run trigger sgp.liberer_canards set 0

execute as @a[tag=sgp.in_game] \
    run trigger sgp.liberer_poules set 0
function sgp.majeurs:common/rounds with storage sgp:data majeurs.pco

function sgp.majeurs:common/stop
