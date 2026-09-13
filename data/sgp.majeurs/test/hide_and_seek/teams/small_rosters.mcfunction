#> sgp.majeurs:hide_and_seek/teams/small_rosters
# @dummy
# @environment sgp.ci:hider_teams
#
# Up to five hiders stay together; an empty roster produces no group.

function sgp.ci:hider_teams/populate {count:0}
function sgp.majeurs:hide_and_seek/teams/select_teams
function sgp.ci:hider_teams/expect_groups {g1:0,g2:0,g3:0,g4:0,g5:0}
function sgp.ci:hider_teams/populate {count:1}
function sgp.majeurs:hide_and_seek/teams/select_teams
function sgp.ci:hider_teams/expect_groups {g1:1,g2:0,g3:0,g4:0,g5:0}
function sgp.ci:hider_teams/populate {count:2}
function sgp.majeurs:hide_and_seek/teams/select_teams
function sgp.ci:hider_teams/expect_groups {g1:0,g2:1,g3:0,g4:0,g5:0}
function sgp.ci:hider_teams/populate {count:3}
function sgp.majeurs:hide_and_seek/teams/select_teams
function sgp.ci:hider_teams/expect_groups {g1:0,g2:0,g3:1,g4:0,g5:0}
function sgp.ci:hider_teams/populate {count:4}
function sgp.majeurs:hide_and_seek/teams/select_teams
function sgp.ci:hider_teams/expect_groups {g1:0,g2:0,g3:0,g4:1,g5:0}
function sgp.ci:hider_teams/populate {count:5}
function sgp.majeurs:hide_and_seek/teams/select_teams
function sgp.ci:hider_teams/expect_groups {g1:0,g2:0,g3:0,g4:0,g5:1}
