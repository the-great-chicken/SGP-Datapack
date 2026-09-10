#> sgp.kits:tnt_clicks/clicked_charge
# @dummy
# @environment sgp.ci:tnt_clicks/clicked_charge
#
# Clicking the farther charge bats that charge, leaving a nearer charge stationary.

function sgp.ci:tnt_clicks/fixture
function sgp.ci:tnt_clicks/record {target:a}
function sgp.ci:tnt_clicks/dispatch
function sgp.ci:tnt_clicks/motion {target:a,x:"-20..20",y:"5980..6020",z:"6980..7020"}
function sgp.ci:tnt_clicks/motion {target:b,x:"0",y:"0",z:"0"}
assert not data entity @e[tag=sgp.ci.click_a,limit=1,type=interaction] attack
