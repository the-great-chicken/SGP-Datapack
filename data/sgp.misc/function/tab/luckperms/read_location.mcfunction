#> sgp.misc:tab/luckperms/read_location
# `{uuid: string}`
# Read the marker as a command target. Unlike `execute as`, this preserves the
# server command source for setup_location and its LuckPerms commands.

data remove storage sgp:macro tab.location_setup_marker
$data modify storage sgp:macro tab.location_setup_marker set from entity $(uuid) data

execute if data storage sgp:macro tab.location_setup_marker.lieu run function sgp.misc:tab/luckperms/setup_location with storage sgp:macro tab.location_setup_marker
