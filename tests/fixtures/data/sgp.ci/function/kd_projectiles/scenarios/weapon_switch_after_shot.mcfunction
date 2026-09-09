#> sgp.ci:kd_projectiles/scenarios/weapon_switch_after_shot

scoreboard players set @s sgp.kills 40
scoreboard players set @s sgp.morts 10
function sgp.misc:kd_buffs_and_debuffs/main
item replace entity @s weapon.mainhand with bow[enchantments={"sgp.kits:kd_projectile_scaling":1}]
function sgp.ci:kd_projectiles/launch {weapon:bow}
item replace entity @s weapon.mainhand with stick
