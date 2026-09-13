#> sgp.kits:fangs/placement/direction
# @dummy
# @environment sgp.ci:fangs_placement
#
# A westward cast follows the casting direction across the terrain.

function sgp.ci:fangs_placement/fixture
setblock ~6 ~3 ~0 stone
function sgp.ci:fangs_placement/cast {count:3,x:"~8.5",y:"~3",z:"~0.5",yaw:90}
function sgp.ci:fangs_placement/expect_count {count:3}
function sgp.ci:fangs_placement/expect {x:"~8.5",y:"~3",z:"~0.5"}
function sgp.ci:fangs_placement/expect {x:"~6.9",y:"~4",z:"~0.5"}
function sgp.ci:fangs_placement/expect {x:"~5.3",y:"~3",z:"~0.5"}
