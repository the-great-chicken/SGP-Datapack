#> sgp.cosmetics:unlock_all_cosmetics
#
# Unlocks all cosmetics for the executing player

tellraw @s "Tu as accès à tous les cosmétiques"

scoreboard players set @s sgp.intensity.light_unlocked 1
scoreboard players set @s sgp.intensity.medium_unlocked 1
scoreboard players set @s sgp.intensity.heavy_unlocked 1
scoreboard players set @s sgp.intensity.super_heavy_unlocked 1
scoreboard players set @s sgp.particle.flame_crown_unlocked 1
scoreboard players set @s sgp.particle.marine_unlocked 1
scoreboard players set @s sgp.particle.ench_unlocked 1
scoreboard players set @s sgp.particle.smoke_unlocked 1
scoreboard players set @s sgp.particle.cloud_unlocked 1

scoreboard players set @s sgp.kill.anvil_unlocked 1
scoreboard players set @s sgp.kill.portal_unlocked 1
scoreboard players set @s sgp.kill.explosion_unlocked 1
scoreboard players set @s sgp.kill.witch_unlocked 1
scoreboard players set @s sgp.kill.hurt_unlocked 1
scoreboard players set @s sgp.kill.cloud_unlocked 1
scoreboard players set @s sgp.kill.splash_unlocked 1
scoreboard players set @s sgp.kill.firework_unlocked 1