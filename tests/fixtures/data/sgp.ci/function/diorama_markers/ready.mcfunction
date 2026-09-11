#> sgp.ci:diorama_markers/ready
# `{owner: string}`
# Gate the fixed arena with a test-owned probe. Block readiness and entity-selector readiness are separate.

$execute store success score #ci.diorama_markers.probe_spawned sgp.dummy run summon marker 8.0 88.0 8.0 {Tags:["sgp.ci.diorama_markers","sgp.ci.diorama_markers_$(owner)","sgp.ci.diorama_markers_ready"]}
assert score #ci.diorama_markers.probe_spawned sgp.dummy matches 1
