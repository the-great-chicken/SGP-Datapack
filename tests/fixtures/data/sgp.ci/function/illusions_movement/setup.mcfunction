#> sgp.ci:illusions_movement/setup
# Bookshelf's milliblock coordinates require a location near the origin rather than PackTest's distant structures.
# Each scenario has its own environment batch because the loading wait and fixed arena cannot be shared concurrently.

function sgp.ci:players/cleanup
schedule clear sgp.ci:illusions_movement/unload
forceload add 0 0
