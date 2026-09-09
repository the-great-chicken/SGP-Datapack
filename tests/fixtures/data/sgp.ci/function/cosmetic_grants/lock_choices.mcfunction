#> sgp.ci:cosmetic_grants/lock_choices
# Establish locked representatives of all three cosmetic categories.

function sgp.cosmetics:particles/disable_type
function sgp.cosmetics:particles/disable_intensity
function sgp.cosmetics:kill_effects/disable
scoreboard players reset @s sgp.particle.marine_unlocked
scoreboard players set @s sgp.intensity.super_heavy_unlocked 0
scoreboard players set @s sgp.kill.firework_unlocked 0
