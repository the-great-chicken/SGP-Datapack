#> sgp.mineurs:lootdrop/restart
# @dummy
# @environment sgp.ci:lootdrop/restart
#
# Restart replaces old loot and cancels existing close-detection work before making fresh drops.
# Enter the open handler directly; dummy menu interactions have different advancement timing.

function sgp.ci:lootdrop/fixture
tag @s add sgp.container_open
execute as @n[tag=sgp.ci.lootdrop.first,type=marker] at @s run function sgp.mineurs:lootdrop/close_detection/on_open
assert entity @n[tag=sgp.ci.lootdrop.first,tag=sgp.opened_chest,type=marker]
assert data storage bs:data schedule.queue[{id:"close_detection"}]
data modify entity @n[tag=sgp.ci.lootdrop.first,type=marker] data.Items set value []
function sgp.mineurs:lootdrop/start
assert not entity @s[tag=sgp.container_open]
assert not entity @e[tag=sgp.ci.lootdrop,tag=sgp.opened_chest,type=marker]
assert not data storage bs:data schedule.queue[{id:"close_detection"}]
execute store result score @s sgp.dummy run data get entity @n[tag=sgp.ci.lootdrop.first,type=marker] data.Items
assert score @s sgp.dummy matches 27
await delay 12t
assert block ~2 ~1 ~2 trapped_chest[facing=north]
assert block ~9 ~1 ~2 trapped_chest[facing=east]
execute positioned ~2 ~1 ~2 run assert entity @e[name=lootdrop_beacon,distance=..2,type=text_display]
execute positioned ~9 ~1 ~2 run assert entity @e[name=lootdrop_beacon,distance=..2,type=text_display]
