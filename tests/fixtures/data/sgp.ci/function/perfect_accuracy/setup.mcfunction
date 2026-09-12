#> sgp.ci:perfect_accuracy/setup
# The production aim calculation creates its temporary marker at the world origin.

function sgp.ci:players/cleanup
forceload add -16 -16 0 0
# Keep the shared origin chunks loaded until this disposable CI server stops.
