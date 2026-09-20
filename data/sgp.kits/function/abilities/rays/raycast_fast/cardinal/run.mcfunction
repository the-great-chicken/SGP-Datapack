#> sgp.kits:abilities/rays/raycast_fast/cardinal/run
#
# Scan one clear cardinal beam and damage every intersecting player immediately.
# Executed at the collision origin. Every test is a selector box against the target's vanilla
# hitbox, so no coordinate is ever read: one box selects the candidates along the 16-block
# segment, and two more boxes per candidate prove the hitbox straddles the beam line on the two
# transverse axes. Candidate order is arbitrary; exact hitbox-entry order is not retained.

scoreboard players set #raycast.pe bs.data 51

execute if entity @s[tag=sgp.east] run function sgp.kits:abilities/rays/raycast_fast/cardinal/east
execute if entity @s[tag=sgp.west] run function sgp.kits:abilities/rays/raycast_fast/cardinal/west
execute if entity @s[tag=sgp.south] run function sgp.kits:abilities/rays/raycast_fast/cardinal/south
execute if entity @s[tag=sgp.north] run function sgp.kits:abilities/rays/raycast_fast/cardinal/north
