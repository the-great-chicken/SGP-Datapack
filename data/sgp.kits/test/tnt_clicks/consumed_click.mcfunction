#> sgp.kits:tnt_clicks/consumed_click
# @dummy
# @environment sgp.ci:tnt_clicks/consumed_click
#
# A consumed click cannot be replayed to apply another impulse.

function sgp.ci:tnt/interaction_pairs/setup
function sgp.ci:tnt_clicks/record {target:a}
function sgp.ci:tnt_clicks/dispatch
function sgp.ci:tnt_clicks/motion {target:a,x:"-20..20",y:"5980..6020",z:"6980..7020"}
data merge entity @e[tag=sgp.ci.tnt_charge_a,limit=1,type=tnt] {Motion:[0.0d,0.0d,0.0d]}
function sgp.ci:tnt_clicks/dispatch
function sgp.ci:tnt_clicks/motion {target:a,x:"0",y:"0",z:"0"}
function sgp.ci:tnt_clicks/motion {target:b,x:"0",y:"0",z:"0"}
