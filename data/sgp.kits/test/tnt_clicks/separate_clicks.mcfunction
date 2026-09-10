#> sgp.kits:tnt_clicks/separate_clicks
# @dummy
# @environment sgp.ci:tnt_clicks/separate_clicks
#
# Two recorded clicks from different players reach their respective charges using each hitter's facing.

function sgp.ci:tnt/interaction_pairs/setup
dummy TntHitter spawn
gamemode creative TntHitter
tp TntHitter ~0.5 ~1 ~1.5 90 0
function sgp.ci:tnt_clicks/record {target:a}
execute as TntHitter run function sgp.ci:tnt_clicks/record {target:b}
function sgp.ci:tnt_clicks/dispatch
execute as TntHitter run function sgp.ci:tnt_clicks/dispatch
function sgp.ci:tnt_clicks/motion {target:a,x:"-20..20",y:"5980..6020",z:"6980..7020"}
function sgp.ci:tnt_clicks/motion {target:b,x:"-7020..-6980",y:"5980..6020",z:"-20..20"}
