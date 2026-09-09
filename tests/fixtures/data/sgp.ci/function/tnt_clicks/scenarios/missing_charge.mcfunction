#> sgp.ci:tnt_clicks/scenarios/missing_charge

function sgp.ci:tnt_clicks/fixture
kill @e[tag=sgp.ci.click_tnt_a,type=tnt]
function sgp.ci:tnt_clicks/record {target:a}
function sgp.ci:tnt_clicks/dispatch
function sgp.ci:tnt_clicks/motion {target:b,x:"0",y:"0",z:"0"}
