#> sgp.ci:kills_give/assert_count
# `{item: item id, count: nonnegative int}`
#
# Count matching items across the player's inventory without removing any.

$execute store result score @s sgp.dummy run clear @s $(item) 0
$assert score @s sgp.dummy matches $(count)
