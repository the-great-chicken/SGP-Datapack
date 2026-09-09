#> sgp.ci:kd_projectiles/scenarios/unenchanted_projectile

scoreboard players set @s sgp.kills 40
scoreboard players set @s sgp.morts 10
function sgp.misc:kd_buffs_and_debuffs/main
function sgp.ci:kd_projectiles/launch {weapon:bow}
data remove entity @n[tag=sgp.ci.kd_arrow,x=8,y=162,z=8,distance=..4,type=arrow] weapon.components."minecraft:enchantments"
item replace entity @s weapon.mainhand with bow[enchantments={"sgp.kits:kd_projectile_scaling":1}]
