#> sgp.cosmetics:kill_effects/particle_and_sound
# `{particle: minecraft_particle, sound: minecraft_sound}`
# 
# Customizable particle + sound kill effect

$execute at @e[tag=sgp.marker,name="death_reaper"] run particle minecraft:$(particle)
$execute at @e[tag=sgp.marker,name="death_reaper"] run playsound minecraft:$(sound) master @a ~ ~ ~ 0.8