#> sgp.ci:bigger/scenarios/expiry

function sgp.ci:bigger/fixture
function sgp.kits:abilities/bigger/apply
scoreboard players set @s sgp.duration_ability 3
function sgp.kits:abilities/route_tick
function sgp.ci:bigger/expect {scale:"199999..200001",jump:"52499..52501",reach:"449999..450001",damage:"199999..200001"}
scoreboard players set @s sgp.duration_ability 2
function sgp.kits:abilities/route_tick
function sgp.ci:bigger/expect {scale:"199999..200001",jump:"52499..52501",reach:"449999..450001",damage:"199999..200001"}
scoreboard players set @s sgp.duration_ability 1
function sgp.kits:abilities/route_tick
function sgp.ci:bigger/expect {scale:"99999..100001",jump:"41999..42001",reach:"299999..300001",damage:"99999..100001"}
