#> sgp.ci:kd_projectiles/launch
# `{weapon: bow|crossbow}`
#
# Summon one owned arrow carrying the real projectile-scaling enchantment for the selected weapon.

assert entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt={Health:40.0f},type=husk]
$summon arrow 8.5 162.6 8.0 {Tags:["sgp.ci.kd_arrow"],NoGravity:1b,Motion:[0.0d,0.0d,1.0d],damage:10.0d,crit:0b,weapon:{id:"minecraft:$(weapon)",count:1,components:{"minecraft:enchantments":{"sgp.kits:kd_projectile_scaling":1}}}}
data modify entity @n[tag=sgp.ci.kd_arrow,x=8,y=162,z=8,distance=..4,type=arrow] Owner set from entity @s UUID
