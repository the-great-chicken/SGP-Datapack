#> sgp.mineurs:lootdrop/show_item/empty_hand_retry
# @dummy
#
# Sharing an empty hand allows a retry; a successful share consumes the permission.

tag @s add sgp.in_game
scoreboard players enable @s sgp.share_item
trigger sgp.share_item
function sgp.mineurs:lootdrop/show_item/main
execute store success score @s sgp.dummy run trigger sgp.share_item
assert score @s sgp.dummy matches 1
item replace entity @s weapon.mainhand with minecraft:diamond[minecraft:custom_name="Retry loot"]
function sgp.mineurs:lootdrop/show_item/main
assert chat ".*Retry loot.*" @s
execute store success score @s sgp.dummy run trigger sgp.share_item
assert score @s sgp.dummy matches 0
