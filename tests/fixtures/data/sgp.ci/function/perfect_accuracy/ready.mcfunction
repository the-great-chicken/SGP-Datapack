#> sgp.ci:perfect_accuracy/ready

execute store success score #ci.accuracy.probe_spawned sgp.dummy run summon marker 8.0 88.0 8.0 {Tags:["sgp.ci.origin_ready"]}
assert score #ci.accuracy.probe_spawned sgp.dummy matches 1
