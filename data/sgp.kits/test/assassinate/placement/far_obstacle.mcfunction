#> sgp.kits:assassinate/placement/far_obstacle
# @dummy
# @environment sgp.ci:assassinate_placement
#
# A wall at the far landing spot selects the clear space one block behind instead.

function sgp.ci:assassinate_placement/fixture
fill ~8 ~1 ~6 ~8 ~4 ~6 stone
function sgp.ci:assassinate_placement/cast
function sgp.ci:assassinate_placement/expect {x:"~8.5",y:"~1.2",z:"~7.5"}
