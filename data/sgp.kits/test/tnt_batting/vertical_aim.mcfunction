#> sgp.kits:tnt_batting/vertical_aim
# @dummy
# @environment sgp.ci:tnt_batting/vertical_aim
#
# Looking up or down changes the vertical trajectory while retaining the fixed upward lift.

function sgp.ci:tnt_batting/fixture
function sgp.ci:tnt_batting/bat {yaw:0,pitch:-90}
function sgp.ci:tnt_batting/expect_motion {x:"-20..20",y:"12980..13020",z:"-20..20"}
function sgp.ci:tnt_batting/bat {yaw:0,pitch:90}
function sgp.ci:tnt_batting/expect_motion {x:"-20..20",y:"-1020..-980",z:"-20..20"}
