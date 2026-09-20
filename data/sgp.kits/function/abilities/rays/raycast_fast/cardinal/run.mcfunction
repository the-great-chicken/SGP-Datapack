#> sgp.kits:abilities/rays/raycast_fast/cardinal/run
#
# Scan one clear cardinal beam and damage exact intersections immediately.
# Candidates are ordered by player origin distance; exact hitbox-entry order is not retained.

data modify storage bs:data raycast set value {x:0,y:0,z:0}
scoreboard players set #raycast.pe bs.data 51

execute if entity @s[tag=sgp.east] run function sgp.kits:abilities/rays/raycast_fast/cardinal/east
execute if entity @s[tag=sgp.west] run function sgp.kits:abilities/rays/raycast_fast/cardinal/west
execute if entity @s[tag=sgp.south] run function sgp.kits:abilities/rays/raycast_fast/cardinal/south
execute if entity @s[tag=sgp.north] run function sgp.kits:abilities/rays/raycast_fast/cardinal/north
