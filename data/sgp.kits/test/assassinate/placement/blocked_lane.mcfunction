#> sgp.kits:assassinate/placement/blocked_lane
# @dummy
# @environment sgp.ci:assassinate_placement
#
# An intervening wall prevents teleporting through it to clear space beyond; the close fallback stays on the target's side.

function sgp.ci:assassinate_placement/fixture
fill ~8 ~1 ~7 ~8 ~4 ~7 stone
function sgp.ci:assassinate_placement/cast
function sgp.ci:assassinate_placement/expect {x:"~8.5",y:"~1.2",z:"~8.3"}
