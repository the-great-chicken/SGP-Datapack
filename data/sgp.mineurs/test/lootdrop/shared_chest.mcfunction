#> sgp.mineurs:lootdrop/shared_chest
# @dummy
# @environment sgp.ci:lootdrop/shared_chest
#
# Once a drop is closed, its finder can share an item and the other drop keeps its visuals.
# This exercises close effects directly, not the last-viewer detector (covered by playtesting).

function sgp.ci:lootdrop/fixture
dummy LootViewer spawn
tp LootViewer ~9.5 ~1 ~4.5
tag LootViewer add sgp.in_game
tag @s add sgp.container_open
tag LootViewer add sgp.container_open

# A beacon can be farther from its chest than the neighboring drop's beacon.
execute positioned ~2 ~1 ~2 run tag @e[name=lootdrop_beacon,distance=..2,type=text_display] add sgp.ci.lootdrop.first_beacon
tp @e[tag=sgp.ci.lootdrop.first_beacon,type=text_display] ~2 ~20 ~2
execute positioned ~9 ~1 ~2 store result score @s sgp.dummy if entity @e[name=lootdrop_beacon,distance=..2,type=text_display]

execute as @n[tag=sgp.ci.lootdrop.first,type=marker] at @s run function sgp.mineurs:lootdrop/close_detection/tick/closed
assert block ~2 ~1 ~2 air
assert block ~9 ~1 ~2 trapped_chest
assert not entity @e[tag=sgp.ci.lootdrop.first_beacon,type=text_display]
execute positioned ~9 ~1 ~2 store result score #lootdrop_beacons_after sgp.dummy if entity @e[name=lootdrop_beacon,distance=..2,type=text_display]
assert score #lootdrop_beacons_after sgp.dummy = @s sgp.dummy
assert not entity @s[tag=sgp.container_open]
assert entity @a[name=LootViewer,tag=sgp.container_open]
execute store success score @s sgp.dummy run trigger sgp.share_item
assert score @s sgp.dummy matches 1
execute as LootViewer store success score @s sgp.dummy run trigger sgp.share_item
assert score LootViewer sgp.dummy matches 0
