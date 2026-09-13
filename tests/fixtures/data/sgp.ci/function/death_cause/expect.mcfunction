#> sgp.ci:death_cause/expect
# `{cause: death-cause path, id: integer}`
#
# Exercise the actual advancement reward function and require its stable analytics id.
# A synthetic pending damage statistic also verifies that every reward drains the event
# delta even when this dummy is not eligible for statistics collection.

scoreboard players set @s sgp.death_cause -999
scoreboard players set @s sgp.damage_taken 7
$function sgp.kits:stats_collector/death_cause/$(cause)
$assert score @s sgp.death_cause matches $(id)
assert not score @s sgp.damage_taken matches -2147483648..2147483647
