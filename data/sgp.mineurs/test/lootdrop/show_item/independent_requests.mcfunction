#> sgp.mineurs:lootdrop/show_item/independent_requests
# @dummy
#
# Two pending shares each produce a message; the first player must not consume the other's request.

tag @s add sgp.in_game
item replace entity @s weapon.mainhand with minecraft:diamond[minecraft:custom_name="First loot"]
dummy LootShareOther spawn
tag LootShareOther add sgp.in_game
item replace entity LootShareOther weapon.mainhand with minecraft:emerald[minecraft:custom_name="Second loot"]
scoreboard players enable @s sgp.share_item
scoreboard players enable LootShareOther sgp.share_item
trigger sgp.share_item
execute as LootShareOther run trigger sgp.share_item
function sgp.mineurs:lootdrop/show_item/main
scoreboard players operation @s sgp.dummy = LootShareOther sgp.share_item
execute as LootShareOther run function sgp.mineurs:lootdrop/show_item/main
dummy LootShareOther leave

assert score @s sgp.dummy matches 1
assert chat ".*First loot.*" @s
assert chat ".*Second loot.*" @s
