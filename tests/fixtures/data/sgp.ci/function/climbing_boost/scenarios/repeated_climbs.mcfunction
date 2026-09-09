#> sgp.ci:climbing_boost/scenarios/repeated_climbs

function sgp.ci:climbing_boost/fixture
function sgp.world:climbing_boost/add
function sgp.world:climbing_boost/add
function sgp.ci:climbing_boost/expect_gravity {range:"0"}
function sgp.world:climbing_boost/remove
function sgp.ci:climbing_boost/expect_gravity {range:"7999..8001"}
function sgp.world:climbing_boost/add
function sgp.ci:climbing_boost/expect_gravity {range:"0"}
function sgp.world:climbing_boost/remove
function sgp.ci:climbing_boost/expect_gravity {range:"7999..8001"}
assert not entity @s[tag=sgp.climbing]
