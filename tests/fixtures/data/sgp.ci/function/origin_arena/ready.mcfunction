#> sgp.ci:origin_arena/ready
# Place and verify the probe marker used to gate tests on the shared fixed-coordinate origin arena.

execute store success score #ci.origin_arena.probe_spawned sgp.dummy run summon marker 8.0 88.0 8.0 {Tags:["sgp.ci.origin_ready"]}
assert score #ci.origin_arena.probe_spawned sgp.dummy matches 1
