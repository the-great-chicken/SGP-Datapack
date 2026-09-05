#> sgp.integration.tab:luckperms/setup_locations
# Walk the copied marker UUID list without changing the server command source.

execute unless data storage sgp:macro tab.location_setup_markers[0] run data remove storage sgp:macro tab.location_setup_marker
execute unless data storage sgp:macro tab.location_setup_markers[0] run data remove storage sgp:macro tab.location_setup_markers
execute unless data storage sgp:macro tab.location_setup_markers[0] run return 0

function sgp.integration.tab:luckperms/read_location with storage sgp:macro tab.location_setup_markers[0]
data remove storage sgp:macro tab.location_setup_markers[0]
function sgp.integration.tab:luckperms/setup_locations
