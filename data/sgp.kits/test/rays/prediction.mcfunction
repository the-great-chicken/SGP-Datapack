#> sgp.kits:rays/prediction
# @dummy
# @environment sgp.ci:rays/movement
# Visual prediction preserves fractional positions and does not move the collision origin.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/fixture
function sgp.ci:rays/start
setblock 8 88 12 stone
tp @s 8.5 88.0 9.0 73 35
function sgp.ci:rays/update
execute positioned 8.5 88.6 10.0 store result score #ci.rays.moved sgp.dummy if entity @e[tag=sgp.ray,distance=..0.0001,type=item_display]
assert score #ci.rays.moved sgp.dummy matches 8
function sgp.ci:rays/beam {direction:south,scale:"5990..6010",center:"1495..1505"}
function sgp.ci:rays/beam {direction:north,scale:"31990..32010",center:"7995..8005"}
execute positioned 8.5 88.6 10.0 run assert entity @e[tag=sgp.ray,tag=sgp.south,nbt={Rotation:[0.0f,0.0f]},distance=..0.01,type=item_display]
execute positioned 8.5 88.6 10.0 run assert entity @e[tag=sgp.ray,tag=sgp.east,nbt={Rotation:[-90.0f,0.0f]},distance=..0.01,type=item_display]

tp @s 8.2497 88.1254 8.0003 11 -20
function sgp.ci:rays/update
execute positioned 7.7477 88.8504 6.0003 store result score #ci.rays.moved sgp.dummy if entity @e[tag=sgp.ray,distance=..0.0001,type=item_display]
assert score #ci.rays.moved sgp.dummy matches 8
