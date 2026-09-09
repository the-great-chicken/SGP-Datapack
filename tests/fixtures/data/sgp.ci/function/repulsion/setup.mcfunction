#> sgp.ci:repulsion/setup
# Keep the arena loaded throughout this disposable CI server, as with other asynchronous origin fixtures.

function sgp.ci:players/cleanup
forceload add 0 0 32 32
