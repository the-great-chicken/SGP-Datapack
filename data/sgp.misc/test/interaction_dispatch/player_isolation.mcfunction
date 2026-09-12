#> sgp.misc:interaction_dispatch/player_isolation
# @dummy
# @environment sgp.ci:interaction_dispatch
#
# Pending clicks by two players are routed independently to the correct recipients.

function sgp.ci:interaction_dispatch/fixture
dummy ClickOther spawn
tag ClickOther add sgp.ci.interaction_actor
gamemode creative ClickOther
tp ClickOther ~0.5 ~1 ~2.5
scoreboard players set ClickOther sgp.dummy 0
function sgp.ci:interaction_dispatch/record_click {target:first}
execute as ClickOther run function sgp.ci:interaction_dispatch/record_click {target:second}
execute at @s run function sgp.misc:interactions/execute
assert entity @s[nbt={Inventory:[{Slot:0b,id:"minecraft:diamond",count:3}]}]
assert score @s sgp.dummy matches 1
assert score ClickOther sgp.dummy matches 0
assert not entity @a[name=ClickOther,nbt={Inventory:[{}]}]
assert data entity @n[tag=sgp.ci.interaction_second,type=interaction] interaction
execute as ClickOther at @s run function sgp.misc:interactions/execute
assert entity @a[name=ClickOther,nbt={Inventory:[{Slot:0b,id:"minecraft:emerald",count:7}]}]
assert score ClickOther sgp.dummy matches 1
assert score @s sgp.dummy matches 1
assert not entity @a[tag=sgp.ci.interaction_actor,tag=sgp.interacting]
