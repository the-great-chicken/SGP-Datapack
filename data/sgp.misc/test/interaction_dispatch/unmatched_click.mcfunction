#> sgp.misc:interaction_dispatch/unmatched_click
# @dummy
# @environment sgp.ci:interaction_dispatch
#
# An unmatched request leaves no dispatch state that could steal another player's later click.

function sgp.ci:interaction_dispatch/fixture
execute at @s run function sgp.misc:interactions/execute
assert not entity @s[tag=sgp.interacting]
assert score @s sgp.dummy matches 0
# Keep a record belonging to the first player while the other player clicks their own target.
function sgp.ci:interaction_dispatch/record_click {target:first}
dummy ClickOther spawn
tag ClickOther add sgp.ci.interaction_actor
gamemode creative ClickOther
tp ClickOther ~0.5 ~1 ~2.5
scoreboard players set ClickOther sgp.dummy 0
execute as ClickOther run function sgp.ci:interaction_dispatch/record_click {target:second}
execute as ClickOther at @s run function sgp.misc:interactions/execute
assert entity @a[name=ClickOther,nbt={Inventory:[{Slot:0b,id:"minecraft:emerald",count:7}]}]
assert score ClickOther sgp.dummy matches 1
assert score @s sgp.dummy matches 0
assert data entity @n[tag=sgp.ci.interaction_first,type=interaction] interaction
