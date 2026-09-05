#> sgp.cosmetics:initialization

# ---------- Create Objectives ----------

scoreboard objectives add sgp.cosmetics.api dummy

# Cosmetic display names and order are read by TGCPlugin directly from these declarations.
scoreboard objectives add sgp.particle.cloud_unlocked dummy "Nuage"
scoreboard objectives add sgp.particle.marine_unlocked dummy "Marin"
scoreboard objectives add sgp.particle.smoke_unlocked dummy "Fumée"
scoreboard objectives add sgp.particle.ench_unlocked dummy "Tranchant"
scoreboard objectives add sgp.particle.flame_crown_unlocked dummy "Couronne de Feu"
scoreboard objectives add sgp.intensity.light_unlocked dummy "Légère"
scoreboard objectives add sgp.intensity.medium_unlocked dummy "Moyenne"
scoreboard objectives add sgp.intensity.heavy_unlocked dummy "Lourde"
scoreboard objectives add sgp.intensity.super_heavy_unlocked dummy "Super Lourde"
scoreboard objectives add sgp.kill.anvil_unlocked dummy "Enclume"
scoreboard objectives add sgp.kill.explosion_unlocked dummy "Explosion"
scoreboard objectives add sgp.kill.portal_unlocked dummy "Portail"
scoreboard objectives add sgp.kill.witch_unlocked dummy "Magie"
scoreboard objectives add sgp.kill.hurt_unlocked dummy "Blessé"
scoreboard objectives add sgp.kill.cloud_unlocked dummy "Nuage"
scoreboard objectives add sgp.kill.splash_unlocked dummy "Splash"
scoreboard objectives add sgp.kill.firework_unlocked dummy "Feux d’Artifice"

scoreboard objectives add sgp.death_effect deathCount



# ---------- Initialize Values ----------

scoreboard players set #ench_particle sgp.dummy 0
scoreboard players set #flame_crown_particle sgp.dummy 0
