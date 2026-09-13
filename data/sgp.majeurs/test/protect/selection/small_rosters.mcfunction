#> sgp.majeurs:protect/selection/small_rosters
# @dummy
# @environment sgp.ci:protect
#
# Empty and small participant rosters remain valid with other players present in the arena.

function sgp.ci:protect/selection_fixture
tag @a[tag=sgp.ci.protect_actor] remove sgp.major_participant
team leave @a[tag=sgp.ci.protect_actor]
function sgp.majeurs:protect/dispatch
function sgp.ci:protect/expect_dispatch {red:0,blue:0}
assert not entity @a[tag=sgp.ci.protect_actor,team=sgp.rouge]
assert not entity @a[tag=sgp.ci.protect_actor,team=sgp.bleue]

tag PrRedKing add sgp.major_participant
function sgp.majeurs:protect/dispatch
function sgp.ci:protect/expect_dispatch {red:1,blue:0}
tag PrRedA add sgp.major_participant
function sgp.majeurs:protect/dispatch
function sgp.ci:protect/expect_dispatch {red:1,blue:1}
assert entity @a[name=PrBlueA,team=]
