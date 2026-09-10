#> sgp.kits:tnt_clicks/missing_charge
# @dummy
# @environment sgp.ci:tnt_clicks/missing_charge
#
# An orphaned interaction does not redirect the click to another nearby charge.

function sgp.ci:tnt_clicks/fixture
kill @e[tag=sgp.ci.click_tnt_a,type=tnt]
function sgp.ci:tnt_clicks/record {target:a}
function sgp.ci:tnt_clicks/dispatch
function sgp.ci:tnt_clicks/motion {target:b,x:"0",y:"0",z:"0"}
