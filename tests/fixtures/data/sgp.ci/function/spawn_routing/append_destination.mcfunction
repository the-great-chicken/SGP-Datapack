#> sgp.ci:spawn_routing/append_destination
# Build an absolute destination from a fixture marker, retaining fractional coordinates.

data modify storage sgp.ci:spawn_routing destination set from entity @s data
data modify storage sgp.ci:spawn_routing destination.x set from entity @s Pos[0]
data modify storage sgp.ci:spawn_routing destination.y set from entity @s Pos[1]
data modify storage sgp.ci:spawn_routing destination.z set from entity @s Pos[2]
data modify storage sgp.ci:spawn_routing normal.spawns append from storage sgp.ci:spawn_routing destination
