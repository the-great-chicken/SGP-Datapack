#> sgp.ci:diorama_mapping/giant_cleanup
function sgp.ci:diorama_mapping/cleanup
execute if data storage sgp.ci:diorama_mapping {offset_exists:1b} store result score #giant_offset sgp.dummy run data get storage sgp.ci:diorama_mapping offset
execute if data storage sgp.ci:diorama_mapping {offset_exists:0b} run scoreboard players reset #giant_offset sgp.dummy
