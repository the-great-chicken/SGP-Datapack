#> sgp.ci:fangs_placement/cleanup
# Remove fixture fangs and disconnect every test player.

kill @e[tag=sgp.ci.fang,type=evoker_fangs]
function sgp.ci:players/cleanup
