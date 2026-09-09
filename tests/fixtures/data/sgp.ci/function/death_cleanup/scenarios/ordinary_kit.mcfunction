#> sgp.ci:death_cleanup/scenarios/ordinary_kit

function sgp.ci:death_cleanup/fixture
tag @s add sgp.archer
scoreboard players set @s sgp.kit_id 2
function sgp.kits:cleanup_after_death
function sgp.ci:death_cleanup/expect_cleared
assert not entity @s[tag=sgp.archer]
