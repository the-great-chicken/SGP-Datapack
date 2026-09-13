#> sgp.kits:kd_projectiles/weapon_switch_after_shot
# @dummy
# @environment sgp.ci:kd_projectiles/weapon_switch_after_shot
#
# Switching held items after firing does not remove the enchantment carried by the projectile.

gamemode spectator @s
tp @s 8.0 168.0 8.0
await entity @s[predicate=sgp.ci:kd_projectiles/area_loaded]
function sgp.ci:kd_projectiles/fixture
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{active_effects:[{id:"minecraft:glowing"}]},type=husk]
scoreboard players set @s sgp.kills 40
scoreboard players set @s sgp.morts 10
function sgp.misc:kd_buffs_and_debuffs/main
item replace entity @s weapon.mainhand with bow[enchantments={"sgp.kits:kd_projectile_scaling":1}]
function sgp.ci:kd_projectiles/launch {weapon:bow}
item replace entity @s weapon.mainhand with stick
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{Health:40.0f},type=husk]
function sgp.ci:kd_projectiles/expect_damage {health:35000}
