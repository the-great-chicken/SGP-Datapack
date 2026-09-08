#> sgp.misc:interaction_dispatch/routing
# @dummy
# @environment sgp.ci:interaction_dispatch
#
# Only the clicked target's configured callback and arguments are applied.

function sgp.ci:interaction_dispatch/fixture
function sgp.ci:interaction_dispatch/record_click {target:second}
execute at @s run function sgp.misc:interactions/execute
assert entity @s[nbt={Inventory:[{Slot:0b,id:"minecraft:emerald",count:7}]}]
assert score @s sgp.dummy matches 1
assert not entity @s[tag=sgp.interacting]
assert not data entity @n[tag=sgp.ci.interaction_second,type=interaction] interaction
