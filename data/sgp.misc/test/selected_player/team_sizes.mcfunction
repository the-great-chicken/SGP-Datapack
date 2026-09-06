#> sgp.misc:selected_player/team_sizes
# @dummy
# @environment sgp.ci:selected_player/team_sizes
#
# Protect's half-team selection rounds down for odd groups and follows roster changes.

data modify storage sgp:data tests.selection_teams set value {}
tag @s add sgp.test.selection_roster
dummy SelTeamA spawn
dummy SelTeamB spawn
dummy SelTeamC spawn
dummy SelTeamD spawn
tag SelTeamA add sgp.test.selection_roster
tag SelTeamB add sgp.test.selection_roster
tag SelTeamC add sgp.test.selection_roster
tag SelTeamD add sgp.test.selection_roster
tag @a[tag=sgp.test.selection_roster] add sgp.in_game

function sgp.misc:selected_player/main {div:2,add:0,sign:"/",tag:"sgp.test.selection_five"}
execute store result storage sgp:data tests.selection_teams.five int 1 if entity @a[tag=sgp.test.selection_five]
tag SelTeamD remove sgp.in_game
function sgp.misc:selected_player/main {div:2,add:0,sign:"/",tag:"sgp.test.selection_four"}
execute store result storage sgp:data tests.selection_teams.four int 1 if entity @a[tag=sgp.test.selection_four]
execute store result storage sgp:data tests.selection_teams.outside int 1 if entity @a[tag=!sgp.in_game,tag=sgp.test.selection_four]
tag @a[tag=sgp.test.selection_roster] remove sgp.in_game
tag @s add sgp.in_game
function sgp.misc:selected_player/main {div:2,add:0,sign:"/",tag:"sgp.test.selection_one"}
execute store result storage sgp:data tests.selection_teams.one int 1 if entity @a[tag=sgp.test.selection_one]
dummy SelTeamA leave
dummy SelTeamB leave
dummy SelTeamC leave
dummy SelTeamD leave

assert data storage sgp:data tests.selection_teams{five:2,four:2,outside:0,one:0}
data remove storage sgp:data tests.selection_teams
