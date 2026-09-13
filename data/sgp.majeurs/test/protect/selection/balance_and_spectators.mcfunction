#> sgp.majeurs:protect/selection/balance_and_spectators
# @dummy
# @environment sgp.ci:protect/selection/balance_and_spectators
#
# Odd and even participant rosters are balanced, and a spectator's existing team and position remain untouched.

function sgp.ci:protect/selection_fixture
tag PrBlueB remove sgp.major_participant
tag PrBlueB add sgp.major_spectator
team join sgp.rouge PrBlueB
function sgp.majeurs:protect/dispatch
function sgp.ci:protect/expect_dispatch {red:3,blue:2}
assert entity @a[name=PrBlueB,team=sgp.rouge,tag=sgp.major_spectator]
execute positioned ~23.5 ~1 ~0.5 run assert entity @a[name=PrBlueB,distance=..0.1]
execute positioned ~10.5 ~1 ~10.5 run assert entity @s[distance=..0.1]

tag PrBlueB remove sgp.major_spectator
tag PrBlueB add sgp.major_participant
function sgp.majeurs:protect/dispatch
function sgp.ci:protect/expect_dispatch {red:3,blue:3}
