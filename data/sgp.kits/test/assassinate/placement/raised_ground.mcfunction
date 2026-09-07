#> sgp.kits:assassinate/placement/raised_ground
# @dummy
# @environment sgp.ci:assassinate_placement
#
# A one-block rise can be used when the whole route above it has enough headroom.

function sgp.ci:assassinate_placement/fixture
fill ~8 ~1 ~6 ~8 ~1 ~7 stone
function sgp.ci:assassinate_placement/cast
function sgp.ci:assassinate_placement/expect {x:"~8.5",y:"~2.2",z:"~6.5"}
