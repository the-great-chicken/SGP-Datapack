#> sgp.ci:diorama_lifecycle/scenarios/leave_and_reenter

function sgp.ci:diorama_lifecycle/fixture
tag @s add sgp.in_game
tp @s 34.0 81.0 34.0
function sgp.ci:diorama_lifecycle/small_update
function sgp.ci:diorama_lifecycle/count {type:small,count:1}
tp @s 42.0 81.0 34.0
function sgp.ci:diorama_lifecycle/small_update
assert not entity @s[tag=sgp.has_small_mannequin_96001]
function sgp.ci:diorama_lifecycle/count {type:small,count:0}
tp @s 34.0 81.0 34.0
function sgp.ci:diorama_lifecycle/small_update
function sgp.ci:diorama_lifecycle/count {type:small,count:1}
