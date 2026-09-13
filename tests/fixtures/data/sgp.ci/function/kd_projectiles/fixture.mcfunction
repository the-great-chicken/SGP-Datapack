#> sgp.ci:kd_projectiles/fixture
# Create a survival shooter and a tick-verified stationary 40-health target with no armor.

fill 0 160 0 16 160 16 stone
fill 0 161 0 16 165 16 air
gamemode creative @s
tp @s 1.5 161.0 1.5
tag @s add sgp.ci.kd_shooter
summon husk 8.5 162.0 8.8 {Tags:["sgp.ci.kd_target"],NoAI:1b,NoGravity:1b,Silent:1b}
attribute @n[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,type=husk] minecraft:max_health base set 40
attribute @n[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,type=husk] minecraft:armor base set 0
data merge entity @n[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,type=husk] {Health:40.0f}
# Effect expiry establishes that the target is ticking before launching the arrow.
effect give @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,type=husk] glowing 1 0 true
assert entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt={active_effects:[{id:"minecraft:glowing"}]},type=husk]
