#> sgp.kits:activation_items/poseidon
# @dummy
# @environment sgp.ci:activation_items/poseidon
# @template sgp.ci:activation_items
#
# Poseidon's dropped trident is returned, but dropping does not trigger its separate use-based ability or a generic cooldown warning.

function sgp.ci:activation_items/fixture
tag @s add sgp.poseidon
item replace entity @s hotbar.0 with trident[custom_data={sgp.water_trident:true},damage=12,enchantments={unbreaking:3}]
data modify storage sgp.ci:activation_items trident_before set from entity @s Inventory
dummy @s drop all
function sgp.ci:activation_items/track_drops
function sgp.kits:abilities/main_trigger
function sgp.ci:activation_items/expect_inventory {key:trident_before}
assert not entity @e[tag=sgp.ci.activation_item,distance=..8,type=item]
assert score @s sgp.cooldown_ability matches 40
assert score @s sgp.duration_ability matches 7
assert not chat ".*En cooldown pendant.*" @s
