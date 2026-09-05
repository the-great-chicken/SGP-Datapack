#> sgp.misc:selected_player/no_eligible_players
# @dummy
#
# Neither an outsider nor a peaceful participant may be selected, even with a minimum of one.

data modify storage sgp:data tests.selection_empty set value {}
dummy SelEmptyOutside spawn
tag @s add sgp.in_game
tag @s add sgp.peaceful
function sgp.misc:selected_player/main {div:2,add:0,sign:"/",tag:"sgp.test.selection_empty_team"}
function sgp.misc:selected_player/main {div:7,add:1,sign:"/",tag:"sgp.test.selection_empty_bounty"}
execute store result storage sgp:data tests.selection_empty.team int 1 if entity @a[tag=sgp.test.selection_empty_team]
execute store result storage sgp:data tests.selection_empty.bounty int 1 if entity @a[tag=sgp.test.selection_empty_bounty]
dummy SelEmptyOutside leave

assert data storage sgp:data tests.selection_empty{team:0,bounty:0}
data remove storage sgp:data tests.selection_empty
