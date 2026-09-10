#> sgp.ci:tnt_batting/fixture
# Create one stationary owned TNT charge with deliberately unrelated entity rotation.

summon tnt ~2.5 ~2 ~2.5 {Tags:["sgp.ci.batted_tnt","sgp.tnt"],fuse:100s,NoGravity:1b,Motion:[0.0d,0.0d,0.0d],Rotation:[135f,40f]}
assert entity @e[tag=sgp.ci.batted_tnt,type=tnt]
scoreboard players set @e[tag=sgp.ci.batted_tnt,type=tnt] sgp.damage_owner 98001
