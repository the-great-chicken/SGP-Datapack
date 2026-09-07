#> sgp.ci:bats_equipment/hide
# Use the same equipment entry point as ability activation, without spawning bats or entering the stats collector.

tag @s add sgp.processing
execute at @s summon armor_stand run function sgp.kits:abilities/bats/hide/equipment
tag @s remove sgp.processing
