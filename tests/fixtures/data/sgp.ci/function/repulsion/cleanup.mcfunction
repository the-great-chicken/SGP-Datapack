#> sgp.ci:repulsion/cleanup
# Remove Repulsion targets, clear the fixed test room, and disconnect players.

tp @e[tag=sgp.ci.repulsion,type=husk] ~ -1000 ~
kill @e[tag=sgp.ci.repulsion,type=husk]
tag @e[tag=sgp.ci.repulsion,type=husk] remove sgp.ci.repulsion_peer
tag @e[tag=sgp.ci.repulsion,type=husk] remove sgp.ci.repulsion
# Remove this fixture's platform and room independently of the test structure position.
fill 0 128 0 16 133 16 air
function sgp.ci:players/cleanup
