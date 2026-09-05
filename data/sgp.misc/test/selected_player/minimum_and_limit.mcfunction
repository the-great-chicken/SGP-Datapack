#> sgp.misc:selected_player/minimum_and_limit
# @dummy
#
# Bounties select one plus a seventh of the eligible players, including the threshold at seven.
# Small groups still get a seeker, and asking for more players than exist selects everyone available.

data modify storage sgp:data tests.selection_minimum set value {}
tag @s add sgp.test.selection_bounty_roster
dummy SelBountyA spawn
dummy SelBountyB spawn
dummy SelBountyC spawn
dummy SelBountyD spawn
dummy SelBountyE spawn
dummy SelBountyF spawn
tag SelBountyA add sgp.test.selection_bounty_roster
tag SelBountyB add sgp.test.selection_bounty_roster
tag SelBountyC add sgp.test.selection_bounty_roster
tag SelBountyD add sgp.test.selection_bounty_roster
tag SelBountyE add sgp.test.selection_bounty_roster
tag SelBountyF add sgp.test.selection_bounty_roster
tag @a[tag=sgp.test.selection_bounty_roster] add sgp.in_game

function sgp.misc:selected_player/main {div:7,add:1,sign:"/",tag:"sgp.test.selection_seven"}
execute store result storage sgp:data tests.selection_minimum.seven int 1 if entity @a[tag=sgp.test.selection_seven]
tag SelBountyF remove sgp.in_game
function sgp.misc:selected_player/main {div:7,add:1,sign:"/",tag:"sgp.test.selection_six"}
execute store result storage sgp:data tests.selection_minimum.six int 1 if entity @a[tag=sgp.test.selection_six]
tag @a[tag=sgp.test.selection_bounty_roster] remove sgp.in_game
tag @s add sgp.in_game
function sgp.misc:selected_player/main {div:10,add:1,sign:"/",tag:"sgp.test.selection_seeker"}
execute store result storage sgp:data tests.selection_minimum.seeker int 1 if entity @a[tag=sgp.test.selection_seeker]
function sgp.misc:selected_player/main {div:1,add:1,sign:"/",tag:"sgp.test.selection_oversized"}
execute store result storage sgp:data tests.selection_minimum.oversized int 1 if entity @a[tag=sgp.test.selection_oversized]
dummy SelBountyA leave
dummy SelBountyB leave
dummy SelBountyC leave
dummy SelBountyD leave
dummy SelBountyE leave
dummy SelBountyF leave

assert data storage sgp:data tests.selection_minimum{seven:2,six:1,seeker:1,oversized:1}
data remove storage sgp:data tests.selection_minimum
