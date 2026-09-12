#> sgp.kits:tnt_batting/horizontal_aim
# @dummy
# @environment sgp.ci:tnt_batting/horizontal_aim
#
# Batting sends TNT along the hitter's aim with lift, independently of the charge's own rotation.

function sgp.ci:tnt_batting/fixture
function sgp.ci:tnt_batting/bat {yaw:0,pitch:0}
function sgp.ci:tnt_batting/expect_motion {x:"-20..20",y:"5980..6020",z:"6980..7020"}
function sgp.ci:tnt_batting/bat {yaw:90,pitch:0}
function sgp.ci:tnt_batting/expect_motion {x:"-7020..-6980",y:"5980..6020",z:"-20..20"}
function sgp.ci:tnt_batting/bat {yaw:180,pitch:0}
function sgp.ci:tnt_batting/expect_motion {x:"-20..20",y:"5980..6020",z:"-7020..-6980"}
function sgp.ci:tnt_batting/bat {yaw:-90,pitch:0}
function sgp.ci:tnt_batting/expect_motion {x:"6980..7020",y:"5980..6020",z:"-20..20"}
