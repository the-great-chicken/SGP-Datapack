#> sgp.cosmetics:kill_effects/particle_and_sound
# `{particle: minecraft_particle, sound: minecraft_sound}`
# 
# Customizable particle + sound kill effect

$execute at @e[type=marker,tag=sgp.marker,name="death_reaper"] run particle minecraft:$(particle)
$execute at @e[type=marker,tag=sgp.marker,name="death_reaper"] run playsound minecraft:$(sound) master @a[tag=sgp.in_game] ~ ~ ~ 0.8