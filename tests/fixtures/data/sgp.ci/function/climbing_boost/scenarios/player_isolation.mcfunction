#> sgp.ci:climbing_boost/scenarios/player_isolation

function sgp.ci:climbing_boost/fixture
dummy ClimbPeer spawn
tp ClimbPeer ~2 ~1 ~2
attribute ClimbPeer minecraft:gravity base set 0.12
function sgp.world:climbing_boost/add
execute as ClimbPeer run function sgp.ci:climbing_boost/expect_gravity {range:"11999..12001"}
assert entity @a[name=ClimbPeer,tag=!sgp.climbing]
execute as ClimbPeer run function sgp.world:climbing_boost/add
function sgp.world:climbing_boost/remove
function sgp.ci:climbing_boost/expect_gravity {range:"7999..8001"}
execute as ClimbPeer run function sgp.ci:climbing_boost/expect_gravity {range:"0"}
assert entity @a[name=ClimbPeer,tag=sgp.climbing]
execute as ClimbPeer run function sgp.world:climbing_boost/remove
execute as ClimbPeer run function sgp.ci:climbing_boost/expect_gravity {range:"11999..12001"}
dummy ClimbPeer leave
