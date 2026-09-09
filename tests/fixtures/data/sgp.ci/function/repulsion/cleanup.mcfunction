#> sgp.ci:repulsion/cleanup

tp @e[tag=sgp.ci.repulsion,type=husk] ~ -1000 ~
kill @e[tag=sgp.ci.repulsion,type=husk]
tag @e[tag=sgp.ci.repulsion,type=husk] remove sgp.ci.repulsion_peer
tag @e[tag=sgp.ci.repulsion,type=husk] remove sgp.ci.repulsion
function sgp.ci:players/cleanup
