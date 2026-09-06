#> sgp.cosmetics:selection/particle_selection
# @dummy
# @environment sgp.ci:cosmetics/particle_selection
#
# A new particle replaces the old one; a locked choice preserves it and other cosmetic settings.

scoreboard players set @s sgp.particle.cloud_unlocked 1
scoreboard players set @s sgp.particle.smoke_unlocked 1
scoreboard players set @s sgp.particle.marine_unlocked 0
tag @s add sgp.intensity.medium
tag @s add sgp.kill.witch
function sgp.cosmetics:particles/reset_and_replace {particle:"cloud",particle_name:"Cloud",color:"white"}
assert entity @s[tag=sgp.particle.cloud]
function sgp.cosmetics:particles/reset_and_replace {particle:"smoke",particle_name:"Smoke",color:"gray"}
assert entity @s[tag=sgp.particle.smoke,tag=sgp.intensity.medium,tag=sgp.kill.witch]
assert not entity @s[tag=sgp.particle.cloud]
function sgp.cosmetics:particles/reset_and_replace {particle:"marine",particle_name:"Locked marine",color:"aqua"}
assert entity @s[tag=sgp.particle.smoke,tag=sgp.intensity.medium,tag=sgp.kill.witch]
assert not entity @s[tag=sgp.particle.marine]
assert chat ".*pas encore débloqué.*Locked marine.*" @s
assert score @s sgp.particle.marine_unlocked matches 0
function sgp.cosmetics:particles/reset_and_replace {particle:"smoke",particle_name:"Smoke",color:"gray"}
assert entity @s[tag=sgp.particle.smoke,tag=sgp.intensity.medium,tag=sgp.kill.witch]
assert score @s sgp.particle.cloud_unlocked matches 1
assert score @s sgp.particle.smoke_unlocked matches 1
