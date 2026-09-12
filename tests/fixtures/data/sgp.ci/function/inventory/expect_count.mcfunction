#> sgp.ci:inventory/expect_count
# `{item: item id, count: nonnegative int}`
#
# Count matching items across the current player's inventory and assert the exact total.

$execute store result score @s sgp.dummy run clear @s $(item) 0
$assert score @s sgp.dummy matches $(count)
