#> sgp.ci:diorama_lifecycle/scenarios/giant_inside_and_outside

function sgp.ci:diorama_lifecycle/fixture
tp @s 6.0 81.0 9.0
function sgp.ci:diorama_lifecycle/giant_update
function sgp.ci:diorama_lifecycle/count {type:giant,count:1}
tp @s 9.0 81.0 9.0
function sgp.ci:diorama_lifecycle/giant_update
assert entity @s[tag=sgp.inside_current_model,tag=!sgp.around_current_model]
function sgp.ci:diorama_lifecycle/count {type:giant,count:0}
tp @s 20.0 81.0 9.0
function sgp.ci:diorama_lifecycle/giant_update
assert not entity @s[tag=sgp.around_current_model]
function sgp.ci:diorama_lifecycle/count {type:giant,count:0}
