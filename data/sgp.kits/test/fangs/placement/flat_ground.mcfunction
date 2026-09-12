#> sgp.kits:fangs/placement/flat_ground
# @dummy
# @environment sgp.ci:fangs_placement
#
# A full line snaps down to the floor, keeps its spacing, and belongs to its caster.

function sgp.ci:fangs_placement/fixture
function sgp.ci:fangs_placement/cast {count:5,x:"~0.5",y:"~6",z:"~0.5",yaw:0}
function sgp.ci:fangs_placement/expect_count {count:5}
function sgp.ci:fangs_placement/expect {x:"~0.5",y:"~3",z:"~0.5"}
function sgp.ci:fangs_placement/expect {x:"~0.5",y:"~3",z:"~2.1"}
function sgp.ci:fangs_placement/expect {x:"~0.5",y:"~3",z:"~3.7"}
function sgp.ci:fangs_placement/expect {x:"~0.5",y:"~3",z:"~5.3"}
function sgp.ci:fangs_placement/expect {x:"~0.5",y:"~3",z:"~6.9"}
