#> sgp.misc:interaction_dispatch/repeat_clicks
# @dummy
# @environment sgp.ci:interaction_dispatch
#
# A consumed click is not replayed; a new click can invoke the same target again.

function sgp.ci:interaction_dispatch/fixture
function sgp.ci:interaction_dispatch/record_click {target:first}
execute at @s run function sgp.misc:interactions/execute
assert entity @s[nbt={Inventory:[{Slot:0b,id:"minecraft:diamond",count:3}]}]
assert score @s sgp.dummy matches 1
execute at @s run function sgp.misc:interactions/execute
assert score @s sgp.dummy matches 1
assert not entity @s[tag=sgp.interacting]
function sgp.ci:interaction_dispatch/record_click {target:first}
execute at @s run function sgp.misc:interactions/execute
assert score @s sgp.dummy matches 2
assert not data entity @n[tag=sgp.ci.interaction_first,type=interaction] interaction
