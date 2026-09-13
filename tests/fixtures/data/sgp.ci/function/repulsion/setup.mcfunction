#> sgp.ci:repulsion/setup
# Keep the arena loaded throughout this disposable CI server. Its room is at Y=128, above the other origin fixtures.

function sgp.ci:players/cleanup
forceload add 0 0 32 32
