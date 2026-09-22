#> sgp.kits:rays/wall_diagonal
# @dummy
# @environment sgp.ci:rays/wall_diagonal
#
# Blocks inside the scanned diagonal band but off the beam line, or outside the band, leave a diagonal beam at
# full length; a block on the line shortens it to the block's edge, exactly as the Bookshelf raycast does.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/fixture
# South-east beam from (8.5, 8.5): voxel (6, 4) is inside the band but never entered by the line, (5, 1) is outside it.
setblock 14 88 12 stone
setblock 13 88 9 stone
function sgp.ci:rays/start
function sgp.ci:rays/update
function sgp.ci:rays/beam {direction:south_east,scale:"31990..32010",center:"7995..8005"}
function sgp.ci:rays/beam {direction:north_west,scale:"31990..32010",center:"7995..8005"}

# Voxel (3, 3) is entered at its corner, 2.5 * sqrt(2) = 3.536 blocks from the origin.
setblock 11 88 11 stone
function sgp.ci:rays/update
function sgp.ci:rays/beam {direction:south_east,scale:"7060..7082",center:"1760..1775"}
function sgp.ci:rays/beam {direction:north_east,scale:"31990..32010",center:"7995..8005"}
function sgp.ci:rays/beam {direction:south_west,scale:"31990..32010",center:"7995..8005"}
function sgp.ci:rays/beam {direction:north_west,scale:"31990..32010",center:"7995..8005"}
