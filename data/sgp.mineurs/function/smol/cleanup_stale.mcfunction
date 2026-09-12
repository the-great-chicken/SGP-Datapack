#> sgp.mineurs:smol/cleanup_stale
#
# Remove Smol state retained across logout after the event has ended.

attribute @s minecraft:scale modifier remove sgp.smol
tag @s remove sgp.smol
