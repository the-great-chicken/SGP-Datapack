#> sgp.kits:death_cleanup/repeated_cleanup
# @dummy
# @environment sgp.ci:death_cleanup/repeated_cleanup
#
# Repeating death cleanup leaves the player cleared and does not restore a finished ability.

function sgp.ci:death_cleanup/fixture
function sgp.ci:death_cleanup/tank
function sgp.kits:cleanup_after_death
function sgp.ci:death_cleanup/expect_cleared
function sgp.ci:bigger/expect {scale:"99999..100001",jump:"41999..42001",reach:"299999..300001",damage:"99999..100001"}
function sgp.kits:cleanup_after_death
function sgp.ci:death_cleanup/expect_cleared
function sgp.ci:bigger/expect {scale:"99999..100001",jump:"41999..42001",reach:"299999..300001",damage:"99999..100001"}
