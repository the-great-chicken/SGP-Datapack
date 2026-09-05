#> sgp.cosmetics:initialization

# ---------- Create Objectives ----------

scoreboard objectives add sgp.cosmetics.api dummy

# Cosmetic display names, colors and order are read by TGCPlugin directly from these declarations.
scoreboard objectives add sgp.particle.cloud_unlocked dummy {"text":"Nuage","color":"#ffffff"}
scoreboard objectives add sgp.particle.marine_unlocked dummy {"text":"Marin","color":"#5555ff"}
scoreboard objectives add sgp.particle.smoke_unlocked dummy {"text":"Fumée","color":"#aaaaaa"}
scoreboard objectives add sgp.particle.ench_unlocked dummy {"text":"Tranchant","color":"#55ffff"}
scoreboard objectives add sgp.particle.flame_crown_unlocked dummy {"text":"Couronne de Feu","color":"#ffaa00"}
scoreboard objectives add sgp.intensity.light_unlocked dummy {"text":"Légère","color":"#ff55ff"}
scoreboard objectives add sgp.intensity.medium_unlocked dummy {"text":"Moyenne","color":"#aa00aa"}
scoreboard objectives add sgp.intensity.heavy_unlocked dummy {"text":"Lourde","color":"#5555ff"}
scoreboard objectives add sgp.intensity.super_heavy_unlocked dummy {"text":"Super Lourde","color":"#0000aa"}
scoreboard objectives add sgp.kill.anvil_unlocked dummy {"text":"Enclume","color":"#aaaaaa"}
scoreboard objectives add sgp.kill.explosion_unlocked dummy {"text":"Explosion","color":"#ffaa00"}
scoreboard objectives add sgp.kill.portal_unlocked dummy {"text":"Portail","color":"#aa00aa"}
scoreboard objectives add sgp.kill.witch_unlocked dummy {"text":"Magie","color":"#ff55ff"}
scoreboard objectives add sgp.kill.hurt_unlocked dummy {"text":"Blessé","color":"#aa0000"}
scoreboard objectives add sgp.kill.cloud_unlocked dummy {"text":"Nuage","color":"#ffffff"}
scoreboard objectives add sgp.kill.splash_unlocked dummy {"text":"Splash","color":"#5555ff"}
scoreboard objectives add sgp.kill.firework_unlocked dummy {"text":"Feux d’Artifice","color":"#ff5555"}

scoreboard objectives add sgp.death_effect deathCount



# ---------- Initialize Values ----------

scoreboard players set #ench_particle sgp.dummy 0
scoreboard players set #flame_crown_particle sgp.dummy 0
