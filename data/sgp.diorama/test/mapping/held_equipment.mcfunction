#> sgp.diorama:mapping/held_equipment
# @dummy
# @environment sgp.ci:diorama_mapping/held_equipment

gamemode spectator @s
tp @s 8 88 8
function sgp.ci:diorama_mapping/ready
await entity @e[tag=sgp.ci.mapping_ready,x=8,y=88,z=8,distance=..1,type=marker]
function sgp.ci:diorama_mapping/scenarios/held_equipment
