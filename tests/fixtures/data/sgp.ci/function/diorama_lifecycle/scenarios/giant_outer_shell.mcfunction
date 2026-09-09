#> sgp.ci:diorama_lifecycle/scenarios/giant_outer_shell

function sgp.ci:diorama_lifecycle/fixture
tp @s 6.0 81.0 9.0
function sgp.ci:diorama_lifecycle/giant_update
assert entity @s[tag=sgp.around_current_model,tag=sgp.has_giant_mannequin_96001]
function sgp.ci:diorama_lifecycle/count {type:giant,count:1}
function sgp.ci:diorama_lifecycle/giant_update
function sgp.ci:diorama_lifecycle/count {type:giant,count:1}
