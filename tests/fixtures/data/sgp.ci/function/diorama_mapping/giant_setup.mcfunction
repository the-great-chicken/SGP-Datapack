#> sgp.ci:diorama_mapping/giant_setup
# Run mapping setup, save the current giant offset, and load the larger giant-test region.

function sgp.ci:diorama_mapping/setup
execute store success storage sgp.ci:diorama_mapping offset_exists byte 1 store result storage sgp.ci:diorama_mapping offset int 1 run scoreboard players get #giant_offset sgp.dummy
forceload add 0 0 64 48
