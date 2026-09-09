#> sgp.ci:tnt_batting/scenarios/preserve_charge

function sgp.ci:tnt_batting/fixture
data modify entity @e[tag=sgp.ci.batted_tnt,limit=1,type=tnt] owner set from entity @s UUID
data modify storage sgp.ci:tnt_batting owner set from entity @e[tag=sgp.ci.batted_tnt,limit=1,type=tnt] owner
assert data storage sgp.ci:tnt_batting owner
summon tnt ~3.5 ~2 ~2.5 {Tags:["sgp.ci.other_tnt"],fuse:80s,NoGravity:1b,Motion:[0.1d,0.2d,0.3d]}
function sgp.ci:tnt_batting/bat {yaw:90,pitch:0}
function sgp.ci:tnt_batting/expect_motion {x:"-7020..-6980",y:"5980..6020",z:"-20..20"}
execute positioned ~2.5 ~2 ~2.5 run assert entity @e[tag=sgp.ci.batted_tnt,distance=..0.01,nbt={fuse:100s},type=tnt]
assert score @e[tag=sgp.ci.batted_tnt,limit=1,type=tnt] sgp.damage_owner matches 98001
execute store success score #ci.bat.owner_changed sgp.dummy run data modify storage sgp.ci:tnt_batting owner set from entity @e[tag=sgp.ci.batted_tnt,limit=1,type=tnt] owner
assert score #ci.bat.owner_changed sgp.dummy matches 0
execute positioned ~3.5 ~2 ~2.5 run assert entity @e[tag=sgp.ci.other_tnt,distance=..0.01,nbt={fuse:80s},type=tnt]
execute store result score #ci.bat.other_x sgp.dummy run data get entity @e[tag=sgp.ci.other_tnt,limit=1,type=tnt] Motion[0] 10000
execute store result score #ci.bat.other_y sgp.dummy run data get entity @e[tag=sgp.ci.other_tnt,limit=1,type=tnt] Motion[1] 10000
execute store result score #ci.bat.other_z sgp.dummy run data get entity @e[tag=sgp.ci.other_tnt,limit=1,type=tnt] Motion[2] 10000
assert score #ci.bat.other_x sgp.dummy matches 1000
assert score #ci.bat.other_y sgp.dummy matches 2000
assert score #ci.bat.other_z sgp.dummy matches 3000
