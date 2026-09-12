#> sgp.kits:assassinate/placement/target_facing
# @dummy
# @environment sgp.ci:assassinate_placement
#
# Behind follows the target's horizontal facing rather than a fixed world direction or the assassin's facing.

function sgp.ci:assassinate_placement/fixture
tp AssTarget ~8.5 ~1 ~8.5 90 35
function sgp.ci:assassinate_placement/cast
function sgp.ci:assassinate_placement/expect {x:"~10.5",y:"~1.2",z:"~8.5"}
function sgp.ci:assassinate_placement/clear_projectiles
tp AssTarget ~8.5 ~1 ~8.5 -90 -35
function sgp.ci:assassinate_placement/cast
function sgp.ci:assassinate_placement/expect {x:"~6.5",y:"~1.2",z:"~8.5"}
function sgp.ci:assassinate_placement/clear_projectiles
tp AssTarget ~8.5 ~1 ~8.5 180 0
function sgp.ci:assassinate_placement/cast
function sgp.ci:assassinate_placement/expect {x:"~8.5",y:"~1.2",z:"~10.5"}
