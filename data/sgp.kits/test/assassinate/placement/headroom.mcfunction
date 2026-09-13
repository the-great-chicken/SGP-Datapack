#> sgp.kits:assassinate/placement/headroom
# @dummy
# @environment sgp.ci:assassinate_placement
#
# Clear feet are insufficient: a low ceiling rejects the far landing spot and uses the nearer open column.

function sgp.ci:assassinate_placement/fixture
fill ~8 ~2 ~6 ~8 ~4 ~6 stone
function sgp.ci:assassinate_placement/cast
function sgp.ci:assassinate_placement/expect {x:"~8.5",y:"~1.2",z:"~7.5"}
