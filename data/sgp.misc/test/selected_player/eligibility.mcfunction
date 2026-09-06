#> sgp.misc:selected_player/eligibility
# @dummy
# @environment sgp.ci:selected_player/eligibility
#
# Only active, non-peaceful players contribute to the count and can be selected.
# Selecting a second role preserves the first role's tags.

data modify storage sgp:data tests.selection_eligibility set value {}
tag @s add sgp.in_game
dummy SelEligibleA spawn
dummy SelEligibleB spawn
dummy SelPeaceful spawn
dummy SelOutside spawn
tag SelEligibleA add sgp.in_game
tag SelEligibleB add sgp.in_game
tag SelPeaceful add sgp.in_game
tag SelPeaceful add sgp.peaceful

function sgp.misc:selected_player/main {div:1,add:0,sign:"/",tag:"sgp.test.selection_all"}
function sgp.misc:selected_player/main {div:2,add:0,sign:"/",tag:"sgp.test.selection_half"}
execute store result storage sgp:data tests.selection_eligibility.all int 1 if entity @a[tag=sgp.test.selection_all]
execute store result storage sgp:data tests.selection_eligibility.half int 1 if entity @a[tag=sgp.test.selection_half]
execute store result storage sgp:data tests.selection_eligibility.peaceful int 1 if entity @a[tag=sgp.peaceful,tag=sgp.test.selection_all]
execute store result storage sgp:data tests.selection_eligibility.outside int 1 if entity @a[tag=!sgp.in_game,tag=sgp.test.selection_all]
execute store result storage sgp:data tests.selection_eligibility.half_eligible int 1 if entity @a[tag=sgp.test.selection_half,tag=sgp.test.selection_all]
dummy SelEligibleA leave
dummy SelEligibleB leave
dummy SelPeaceful leave
dummy SelOutside leave

assert data storage sgp:data tests.selection_eligibility{all:3,half:1,peaceful:0,outside:0,half_eligible:1}
data remove storage sgp:data tests.selection_eligibility
