#> sgp.ci:tnt_batting/scenarios/redirect

function sgp.ci:tnt_batting/fixture
data merge entity @e[tag=sgp.ci.batted_tnt,limit=1,type=tnt] {Motion:[3.0d,-2.0d,4.0d]}
function sgp.ci:tnt_batting/bat {yaw:0,pitch:0}
function sgp.ci:tnt_batting/expect_motion {x:"-20..20",y:"5980..6020",z:"6980..7020"}
function sgp.ci:tnt_batting/bat {yaw:0,pitch:0}
function sgp.ci:tnt_batting/expect_motion {x:"-20..20",y:"5980..6020",z:"6980..7020"}
