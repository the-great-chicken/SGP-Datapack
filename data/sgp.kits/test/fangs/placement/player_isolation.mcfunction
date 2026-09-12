#> sgp.kits:fangs/placement/player_isolation
# @dummy
# @environment sgp.ci:fangs_placement
#
# A second nearby cast preserves the first player's fangs and gives each player ownership of their own attack.

function sgp.ci:fangs_placement/fixture
dummy FangOther spawn
tag FangOther add sgp.ci.fangs_actor
gamemode creative FangOther
tp FangOther ~10.5 ~3 ~9.5
function sgp.ci:fangs_placement/cast {count:2,x:"~0.5",y:"~3",z:"~0.5",yaw:0}
execute as FangOther run function sgp.ci:fangs_placement/cast {count:2,x:"~1.5",y:"~3",z:"~0.5",yaw:0}
function sgp.ci:fangs_placement/expect_count {count:4}
function sgp.ci:fangs_placement/expect {x:"~0.5",y:"~3",z:"~0.5"}
function sgp.ci:fangs_placement/expect {x:"~0.5",y:"~3",z:"~2.1"}
execute as FangOther run function sgp.ci:fangs_placement/expect {x:"~1.5",y:"~3",z:"~0.5"}
execute as FangOther run function sgp.ci:fangs_placement/expect {x:"~1.5",y:"~3",z:"~2.1"}
