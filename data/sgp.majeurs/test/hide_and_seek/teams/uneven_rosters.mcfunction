#> sgp.majeurs:hide_and_seek/teams/uneven_rosters
# @dummy
# @environment sgp.ci:hider_teams
#
# Remainders form useful groups rather than leaving one or two isolated hiders; group membership and ID order remain random.

function sgp.ci:hider_teams/populate {count:6}
function sgp.majeurs:hide_and_seek/teams/select_teams
function sgp.ci:hider_teams/expect_groups {g1:0,g2:0,g3:2,g4:0,g5:0}
function sgp.ci:hider_teams/populate {count:7}
function sgp.majeurs:hide_and_seek/teams/select_teams
function sgp.ci:hider_teams/expect_groups {g1:0,g2:0,g3:1,g4:1,g5:0}
function sgp.ci:hider_teams/populate {count:8}
function sgp.majeurs:hide_and_seek/teams/select_teams
function sgp.ci:hider_teams/expect_groups {g1:0,g2:0,g3:0,g4:2,g5:0}
function sgp.ci:hider_teams/populate {count:9}
function sgp.majeurs:hide_and_seek/teams/select_teams
function sgp.ci:hider_teams/expect_groups {g1:0,g2:0,g3:0,g4:1,g5:1}
function sgp.ci:hider_teams/populate {count:10}
function sgp.majeurs:hide_and_seek/teams/select_teams
function sgp.ci:hider_teams/expect_groups {g1:0,g2:0,g3:0,g4:0,g5:2}
function sgp.ci:hider_teams/populate {count:11}
function sgp.majeurs:hide_and_seek/teams/select_teams
function sgp.ci:hider_teams/expect_groups {g1:0,g2:0,g3:1,g4:2,g5:0}
function sgp.ci:hider_teams/populate {count:14}
function sgp.majeurs:hide_and_seek/teams/select_teams
function sgp.ci:hider_teams/expect_groups {g1:0,g2:0,g3:0,g4:1,g5:2}
