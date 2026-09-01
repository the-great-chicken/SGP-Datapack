#> sgp.cosmetics:initialization

# ---------- Create Objectives ----------

scoreboard objectives add sgp.intensity.light_unlocked dummy
scoreboard objectives add sgp.intensity.medium_unlocked dummy
scoreboard objectives add sgp.intensity.heavy_unlocked dummy
scoreboard objectives add sgp.intensity.super_heavy_unlocked dummy
scoreboard objectives add sgp.particle.flame_crown_unlocked dummy
scoreboard objectives add sgp.particle.marine_unlocked dummy
scoreboard objectives add sgp.particle.ench_unlocked dummy
scoreboard objectives add sgp.particle.smoke_unlocked dummy
scoreboard objectives add sgp.particle.cloud_unlocked dummy

scoreboard objectives add sgp.kill.anvil_unlocked dummy
scoreboard objectives add sgp.kill.portal_unlocked dummy
scoreboard objectives add sgp.kill.explosion_unlocked dummy
scoreboard objectives add sgp.kill.witch_unlocked dummy
scoreboard objectives add sgp.kill.hurt_unlocked dummy
scoreboard objectives add sgp.kill.cloud_unlocked dummy
scoreboard objectives add sgp.kill.splash_unlocked dummy
scoreboard objectives add sgp.kill.firework_unlocked dummy

scoreboard objectives add sgp.death_effect deathCount



# ---------- Initialize Values ----------

scoreboard players set #ench_particle sgp.dummy 0
scoreboard players set #flame_crown_particle sgp.dummy 0