#> sgp.ci:bats_equipment/expect_snapshot
# Replacing identical NBT reports no modification; any item difference fails.

function sgp.ci:bats_equipment/snapshot {key:actual}
$execute store success score @s sgp.dummy run data modify storage sgp.ci:bats_equipment actual set from storage sgp.ci:bats_equipment $(key)
assert score @s sgp.dummy matches 0
