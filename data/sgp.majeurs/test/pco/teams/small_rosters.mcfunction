#> sgp.majeurs:pco/teams/small_rosters
# @dummy
# @environment sgp.ci:pco/synchronous
#
# Empty and small rosters distribute without phantom members, and each dispatch starts a fresh allocation.

function sgp.ci:pco/fixture
function sgp.majeurs:pco/dispatch
function sgp.ci:pco/expect_teams {total:0,min:0,max:0}
tag @s add sgp.major_participant
function sgp.majeurs:pco/dispatch
function sgp.ci:pco/expect_teams {total:1,min:0,max:1}

dummy PcoSmallA spawn
tag PcoSmallA add sgp.ci.pco_actor
tag PcoSmallA add sgp.major_participant
function sgp.majeurs:pco/dispatch
function sgp.ci:pco/expect_teams {total:2,min:0,max:1}
dummy PcoSmallB spawn
tag PcoSmallB add sgp.ci.pco_actor
tag PcoSmallB add sgp.major_participant
function sgp.majeurs:pco/dispatch
function sgp.ci:pco/expect_teams {total:3,min:1,max:1}
function sgp.majeurs:pco/dispatch
function sgp.ci:pco/expect_teams {total:3,min:1,max:1}
