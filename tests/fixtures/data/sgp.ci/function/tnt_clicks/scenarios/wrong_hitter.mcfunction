#> sgp.ci:tnt_clicks/scenarios/wrong_hitter

function sgp.ci:tnt_clicks/fixture
dummy TntHitter spawn
gamemode creative TntHitter
tp TntHitter ~0.5 ~1 ~1.5 90 0
execute as TntHitter run function sgp.ci:tnt_clicks/record {target:a}
function sgp.ci:tnt_clicks/dispatch
function sgp.ci:tnt_clicks/motion {target:a,x:"0",y:"0",z:"0"}
assert data entity @e[tag=sgp.ci.click_a,limit=1,type=interaction] attack
execute as TntHitter run function sgp.ci:tnt_clicks/dispatch
function sgp.ci:tnt_clicks/motion {target:a,x:"-7020..-6980",y:"5980..6020",z:"-20..20"}
