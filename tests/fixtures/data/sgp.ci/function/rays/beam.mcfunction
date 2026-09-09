#> sgp.ci:rays/beam

# {direction, scale, center}: scale and local midpoint multiplied by 1000.
$execute positioned 8.0 88.0 8.0 store result score #ci.rays.direction sgp.dummy if entity @e[tag=sgp.ray,tag=sgp.$(direction),distance=..64,type=item_display]
assert score #ci.rays.direction sgp.dummy matches 1
$execute store result score #ci.rays.length sgp.dummy run data get entity @e[tag=sgp.ray,tag=sgp.$(direction),limit=1,type=item_display] transformation.scale[2] 1000
$execute store result score #ci.rays.center sgp.dummy run data get entity @e[tag=sgp.ray,tag=sgp.$(direction),limit=1,type=item_display] transformation.translation[2] 1000
$assert score #ci.rays.length sgp.dummy matches $(scale)
$assert score #ci.rays.center sgp.dummy matches $(center)
