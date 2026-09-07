#> sgp.kits:activation_items/outside_arena
# @dummy
# @environment sgp.ci:activation_items
#
# Outside the arena, dropping an item remains an ordinary drop and does not activate the equipped kit.

function sgp.ci:activation_items/fixture
tag @s remove sgp.in_game
tag @s add sgp.tank
scoreboard players set @s sgp.cooldown_ability 0
attribute @s minecraft:scale base set 1
item replace entity @s hotbar.0 with diamond 5
dummy @s drop all
function sgp.ci:activation_items/track_drops
function sgp.kits:abilities/main_trigger
assert not entity @s[nbt={Inventory:[{}]}]
assert entity @e[tag=sgp.ci.activation_item,distance=..8,type=item]
assert score @s sgp.cooldown_ability matches 0
assert score @s sgp.duration_ability matches 7
execute store result score @s sgp.dummy run attribute @s minecraft:scale get 100
assert score @s sgp.dummy matches 100
assert not score @s sgp.drop_any matches 1..
assert not chat ".*En cooldown pendant.*" @s
