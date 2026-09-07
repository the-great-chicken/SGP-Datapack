#> sgp.kits:activation_items/player_isolation
# @dummy
# @environment sgp.ci:activation_items
#
# Two nearby drops return to their respective throwers, even when both exist before either request is handled.

function sgp.ci:activation_items/fixture
dummy DropOther spawn
tag DropOther add sgp.ci.activation_actor
tag DropOther add sgp.in_game
gamemode survival DropOther
tp DropOther ~1.5 ~1 ~0.5 0 0
scoreboard players set DropOther sgp.cooldown_ability 40
item replace entity @s hotbar.0 with diamond[custom_data={ci_owner:1}] 11
item replace entity DropOther hotbar.0 with emerald[custom_data={ci_owner:2}] 13
data modify storage sgp.ci:activation_items first_before set from entity @s Inventory
data modify storage sgp.ci:activation_items other_before set from entity DropOther Inventory
dummy @s drop all
dummy DropOther drop all
function sgp.ci:activation_items/track_drops
execute store result score #ci.activation.drops sgp.dummy if entity @e[tag=sgp.ci.activation_item,distance=..8,type=item]
assert score #ci.activation.drops sgp.dummy matches 2
function sgp.kits:abilities/main_trigger
function sgp.ci:activation_items/expect_inventory {key:first_before}
assert not entity @a[name=DropOther,nbt={Inventory:[{}]}]
execute store result score #ci.activation.drops sgp.dummy if entity @e[tag=sgp.ci.activation_item,distance=..8,type=item]
assert score #ci.activation.drops sgp.dummy matches 1
execute as DropOther at @s run function sgp.kits:abilities/main_trigger
execute as DropOther run function sgp.ci:activation_items/expect_inventory {key:other_before}
function sgp.ci:activation_items/expect_inventory {key:first_before}
assert not entity @e[tag=sgp.ci.activation_item,distance=..8,type=item]
assert not data block ~6 ~1 ~ Items[0]
