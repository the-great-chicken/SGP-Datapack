#> sgp.ci:rays/beam
# `{direction: north|north_east|east|south_east|south|south_west|west|north_west, scale, center: score range (transform * 1000)}`
#
# Check one directional beam's longitudinal scale and local midpoint at fixed-point precision.

$execute positioned 8.0 88.0 8.0 store result score #ci.rays.direction sgp.dummy if entity @e[tag=sgp.ray,tag=sgp.$(direction),distance=..64,type=item_display]
assert score #ci.rays.direction sgp.dummy matches 1
$execute store result score #ci.rays.length sgp.dummy run data get entity @e[tag=sgp.ray,tag=sgp.$(direction),limit=1,type=item_display] transformation.scale[2] 1000
$execute store result score #ci.rays.center sgp.dummy run data get entity @e[tag=sgp.ray,tag=sgp.$(direction),limit=1,type=item_display] transformation.translation[2] 1000
$assert score #ci.rays.length sgp.dummy matches $(scale)
$assert score #ci.rays.center sgp.dummy matches $(center)
