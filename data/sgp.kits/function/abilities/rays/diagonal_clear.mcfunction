#> sgp.kits:abilities/rays/diagonal_clear
#
# Return success when every voxel a 16-block diagonal beam can cross is pass-through.
# For a pitch-0 beam at yaw +-45/+-135, Bookshelf's fixed-point DDA only ever visits voxels (i, j)
# with 0 <= i, j <= 12 and |i - j| <= 2 (59 voxels), so an all-clear band proves the raycast would
# find no block and the beam keeps its full length without running the DDA at all.

execute if entity @s[tag=sgp.north_east] run return run function sgp.kits:abilities/rays/diagonal_clear/north_east
execute if entity @s[tag=sgp.south_east] run return run function sgp.kits:abilities/rays/diagonal_clear/south_east
execute if entity @s[tag=sgp.south_west] run return run function sgp.kits:abilities/rays/diagonal_clear/south_west
execute if entity @s[tag=sgp.north_west] run return run function sgp.kits:abilities/rays/diagonal_clear/north_west
return 0
