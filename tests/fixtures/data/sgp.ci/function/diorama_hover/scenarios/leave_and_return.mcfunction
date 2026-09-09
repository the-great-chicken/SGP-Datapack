#> sgp.ci:diorama_hover/scenarios/leave_and_return

function sgp.ci:diorama_hover/fixture
function sgp.ci:diorama_hover/update
function sgp.ci:diorama_hover/expect {target:first,active:1,scale:0.7}
tag @s remove sgp.around_current_model
function sgp.ci:diorama_hover/update
function sgp.ci:diorama_hover/expect {target:first,active:0,scale:0.55}
assert not entity @e[tag=sgp.ci.hover,tag=sgp.hover_model_active,distance=..16,type=marker]
function sgp.ci:diorama_hover/update
function sgp.ci:diorama_hover/expect {target:first,active:0,scale:0.55}
tag @s add sgp.around_current_model
function sgp.ci:diorama_hover/update
function sgp.ci:diorama_hover/expect {target:first,active:1,scale:0.7}
# Removing the model also resets an active selection.
execute as @n[tag=sgp.ci.hover,distance=..16,type=marker] at @s run function sgp.diorama:hover/uninstall_model {id:93001}
function sgp.ci:diorama_hover/expect {target:first,active:0,scale:0.55}
assert not entity @e[tag=sgp.ci.hover,tag=sgp.hover_model_active,distance=..16,type=marker]
