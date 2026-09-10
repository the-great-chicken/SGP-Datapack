#> sgp.ci:water_trident/cleanup
# Remove temporary water markers and disconnect every test player.

kill @e[tag=sgp.marker,name=temp_water,type=marker]
function sgp.ci:players/cleanup
