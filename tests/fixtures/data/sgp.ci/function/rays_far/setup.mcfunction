#> sgp.ci:rays_far/setup
# Disconnect stale players and load the far-from-origin region used by large-coordinate Rays tests.

function sgp.ci:players/cleanup
forceload add 984 984 1032 1032
