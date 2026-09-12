#> sgp.ci:illusions_movement/setup
# Bookshelf's milliblock coordinates require a location near the origin rather than PackTest's distant structures.
# Each scenario has its own environment batch because the loading wait and fixed arena cannot be shared concurrently.

function sgp.ci:players/cleanup
forceload add -16 -16 0 0
# Keep the shared origin chunks loaded until this disposable CI server stops.
