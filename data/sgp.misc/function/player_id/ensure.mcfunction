#> sgp.misc:player_id/ensure
# Assign stable IDs to online players who do not yet have a valid one.

execute as @a unless score @s sgp.id matches 1.. run function sgp.misc:player_id/allocate
