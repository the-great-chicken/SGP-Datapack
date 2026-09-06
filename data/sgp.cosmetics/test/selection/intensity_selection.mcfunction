#> sgp.cosmetics:selection/intensity_selection
# @dummy
# @environment sgp.ci:cosmetics/intensity_selection
#
# Intensity changes keep the particle and kill effect; a missing unlock cannot erase the current intensity.

scoreboard players set @s sgp.intensity.light_unlocked 1
scoreboard players set @s sgp.intensity.heavy_unlocked 1
scoreboard players reset @s sgp.intensity.super_heavy_unlocked
tag @s add sgp.particle.cloud
tag @s add sgp.kill.portal
function sgp.cosmetics:particles/reset_and_replace_intensity {intensity:"light",intensity_name:"Light",color:"white"}
assert entity @s[tag=sgp.intensity.light]
function sgp.cosmetics:particles/reset_and_replace_intensity {intensity:"heavy",intensity_name:"Heavy",color:"gold"}
assert entity @s[tag=sgp.intensity.heavy,tag=sgp.particle.cloud,tag=sgp.kill.portal]
assert not entity @s[tag=sgp.intensity.light]
function sgp.cosmetics:particles/reset_and_replace_intensity {intensity:"super_heavy",intensity_name:"Locked intensity",color:"red"}
assert entity @s[tag=sgp.intensity.heavy,tag=sgp.particle.cloud,tag=sgp.kill.portal]
assert not entity @s[tag=sgp.intensity.super_heavy]
assert chat ".*pas encore débloqué.*Locked intensity.*" @s
assert not score @s sgp.intensity.super_heavy_unlocked matches 1
assert score @s sgp.intensity.light_unlocked matches 1
assert score @s sgp.intensity.heavy_unlocked matches 1
