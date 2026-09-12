#> sgp.kits:fangs/placement/uneven_ground
# @dummy
# @environment sgp.ci:fangs_placement
#
# The line climbs an obstacle, descends into a trench, and returns to the platform.

function sgp.ci:fangs_placement/fixture
fill ~0 ~3 ~2 ~0 ~4 ~2 stone
fill ~0 ~1 ~3 ~0 ~2 ~3 air
function sgp.ci:fangs_placement/cast {count:4,x:"~0.5",y:"~3",z:"~0.5",yaw:0}
function sgp.ci:fangs_placement/expect_count {count:4}
function sgp.ci:fangs_placement/expect {x:"~0.5",y:"~3",z:"~0.5"}
function sgp.ci:fangs_placement/expect {x:"~0.5",y:"~5",z:"~2.1"}
function sgp.ci:fangs_placement/expect {x:"~0.5",y:"~1",z:"~3.7"}
function sgp.ci:fangs_placement/expect {x:"~0.5",y:"~3",z:"~5.3"}
