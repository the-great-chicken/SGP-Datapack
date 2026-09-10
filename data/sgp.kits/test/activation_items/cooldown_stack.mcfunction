#> sgp.kits:activation_items/cooldown_stack
# @dummy
# @environment sgp.ci:activation_items/cooldown_stack
# @template sgp.ci:activation_items
#
# A rejected activation returns one dropped item into its existing stack without restarting cooldown or applying the ability.

function sgp.ci:activation_items/fixture
tag @s add sgp.tank
attribute @s minecraft:scale base set 1
item replace entity @s hotbar.0 with snowball[custom_name={text:"CI stack"},custom_data={ci_keep:7}] 16
data modify storage sgp.ci:activation_items before set from entity @s Inventory
dummy @s drop
function sgp.ci:activation_items/track_drops
assert entity @e[tag=sgp.ci.activation_item,distance=..8,type=item]
function sgp.kits:abilities/main_trigger
function sgp.ci:activation_items/expect_inventory {key:before}
assert not entity @e[tag=sgp.ci.activation_item,distance=..8,type=item]
assert not data block ~6 ~1 ~ Items[0]
assert score @s sgp.cooldown_ability matches 40
assert score @s sgp.duration_ability matches 7
execute store result score @s sgp.dummy run attribute @s minecraft:scale get 100
assert score @s sgp.dummy matches 100
assert not score @s sgp.drop_any matches 1..
assert chat ".*En cooldown pendant.*" @s
