#> sgp.ci:diorama_lifecycle/scenarios/entry_and_repeat

function sgp.ci:diorama_lifecycle/fixture
tag @s add sgp.in_game
tp @s 34.0 81.0 34.0
function sgp.ci:diorama_lifecycle/small_update
assert entity @s[tag=sgp.has_small_mannequin_96001]
function sgp.ci:diorama_lifecycle/count {type:small,count:1}
function sgp.ci:diorama_lifecycle/small_update
function sgp.ci:diorama_lifecycle/count {type:small,count:1}
