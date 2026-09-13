#> sgp.ci:loadouts/expect_enchantment_count
# `{item: item id, enchantment: enchantment id, count: nonnegative int}`
#
# Count matching enchanted items across the current player's inventory and assert the exact total.

$execute store result score @s sgp.dummy run clear @s $(item)[enchantments~[{enchantments:"$(enchantment)"}]] 0
$assert score @s sgp.dummy matches $(count)
