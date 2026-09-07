#> sgp.ci:locations/scan
# `{tag: string}`
#
# Run the location part of a tick using this test's markers and their real metadata.

scoreboard players set @s sgp.ab.location 0
scoreboard players set @s sgp.ab.location_width 0
$execute as @e[tag=$(tag),distance=..32,type=marker] at @s run function sgp.world:lieu/lieu_trouve with entity @s data
