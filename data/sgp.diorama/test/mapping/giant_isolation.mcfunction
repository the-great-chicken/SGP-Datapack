#> sgp.diorama:mapping/giant_isolation
# @dummy
# @environment sgp.ci:diorama_mapping/giant_isolation

gamemode spectator @s
tp @s 8.0 88.0 8.0
function sgp.ci:diorama_mapping/ready
await entity @e[tag=sgp.ci.mapping_ready,x=8,y=88,z=8,distance=..1,type=marker]
function sgp.ci:diorama_mapping/scenarios/giant_isolation
