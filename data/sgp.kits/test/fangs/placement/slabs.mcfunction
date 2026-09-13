#> sgp.kits:fangs/placement/slabs
# @dummy
# @environment sgp.ci:fangs_placement
#
# Fangs rest on the actual surface of bottom, top, and double slabs.

function sgp.ci:fangs_placement/fixture
setblock ~0 ~3 ~0 stone_slab[type=bottom]
setblock ~0 ~3 ~2 stone_slab[type=top]
setblock ~0 ~3 ~3 stone_slab[type=double]
function sgp.ci:fangs_placement/cast {count:3,x:"~0.5",y:"~3",z:"~0.5",yaw:0}
function sgp.ci:fangs_placement/expect_count {count:3}
function sgp.ci:fangs_placement/expect {x:"~0.5",y:"~3.5",z:"~0.5"}
function sgp.ci:fangs_placement/expect {x:"~0.5",y:"~4",z:"~2.1"}
function sgp.ci:fangs_placement/expect {x:"~0.5",y:"~4",z:"~3.7"}
