#> sgp.ci:rays_far/ready
# Place and verify the probe marker used to gate tests on the far-from-origin Rays arena.

execute store success score #ci.rays_far.probe_spawned sgp.dummy run summon marker 1008.0 88.0 1008.0 {Tags:["sgp.ci.far_ready"]}
assert score #ci.rays_far.probe_spawned sgp.dummy matches 1
