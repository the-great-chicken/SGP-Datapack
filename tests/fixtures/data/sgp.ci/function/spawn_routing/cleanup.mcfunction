#> sgp.ci:spawn_routing/cleanup
# Remove routing markers/players and restore the production event state saved by setup.

kill @e[tag=sgp.ci.spawn_routing,type=marker]
function sgp.ci:players/cleanup
execute store result score #confines_secondes sgp.timer run data get storage sgp.ci:spawn_routing previous.confinement
execute store result score #protect_phase sgp.dummy run data get storage sgp.ci:spawn_routing previous.protect
data remove storage sgp.ci:spawn_routing previous
