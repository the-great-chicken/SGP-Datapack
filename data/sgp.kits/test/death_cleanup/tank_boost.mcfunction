#> sgp.kits:death_cleanup/tank_boost
# @dummy
# @environment sgp.ci:death_cleanup/tank_boost
#
# Death cleanup ends Bigger through the Tank route before clearing kit tags.

function sgp.ci:death_cleanup/fixture
function sgp.ci:death_cleanup/tank
function sgp.kits:cleanup_after_death
function sgp.ci:death_cleanup/expect_cleared
assert not entity @s[tag=sgp.tank]
function sgp.ci:bigger/expect {scale:"99999..100001",jump:"41999..42001",reach:"299999..300001",damage:"99999..100001"}
