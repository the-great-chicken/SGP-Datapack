#> sgp.kits:bigger/repeated_use
# @dummy
# @environment sgp.ci:bigger/repeated_use
#
# A second activation after cleanup gives the same boost without accumulating changes.

function sgp.ci:bigger/fixture
function sgp.kits:abilities/bigger/apply
function sgp.ci:bigger/expect {scale:"199999..200001",jump:"52499..52501",reach:"449999..450001",damage:"199999..200001"}
function sgp.kits:abilities/bigger/end
function sgp.ci:bigger/expect {scale:"99999..100001",jump:"41999..42001",reach:"299999..300001",damage:"99999..100001"}
function sgp.kits:abilities/bigger/apply
function sgp.ci:bigger/expect {scale:"199999..200001",jump:"52499..52501",reach:"449999..450001",damage:"199999..200001"}
function sgp.kits:abilities/bigger/end
function sgp.ci:bigger/expect {scale:"99999..100001",jump:"41999..42001",reach:"299999..300001",damage:"99999..100001"}
