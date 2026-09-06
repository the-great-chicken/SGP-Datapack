#> sgp.cosmetics:selection/disable_and_reenable
# @dummy
# @environment sgp.ci:cosmetics
#
# Disabling affects only its category and preserves unlocks so the cosmetic can be equipped again.

scoreboard players set @s sgp.particle.smoke_unlocked 1
scoreboard players set @s sgp.intensity.medium_unlocked 1
scoreboard players set @s sgp.kill.witch_unlocked 1
function sgp.cosmetics:particles/reset_and_replace {particle:"smoke",particle_name:"Smoke",color:"gray"}
function sgp.cosmetics:particles/reset_and_replace_intensity {intensity:"medium",intensity_name:"Medium",color:"yellow"}
function sgp.cosmetics:kill_effects/reset_and_replace {kill:"witch",kill_name:"Witch",color:"light_purple"}
function sgp.cosmetics:particles/manually_disable
assert not entity @s[tag=sgp.particle.smoke]
assert not entity @s[tag=sgp.intensity.medium]
assert entity @s[tag=sgp.kill.witch]
assert score @s sgp.particle.smoke_unlocked matches 1
assert score @s sgp.intensity.medium_unlocked matches 1
function sgp.cosmetics:particles/reset_and_replace {particle:"smoke",particle_name:"Smoke",color:"gray"}
function sgp.cosmetics:particles/reset_and_replace_intensity {intensity:"medium",intensity_name:"Medium",color:"yellow"}
assert entity @s[tag=sgp.particle.smoke,tag=sgp.intensity.medium,tag=sgp.kill.witch]
function sgp.cosmetics:kill_effects/manually_disable
assert not entity @s[tag=sgp.kill.witch]
assert entity @s[tag=sgp.particle.smoke,tag=sgp.intensity.medium]
assert score @s sgp.kill.witch_unlocked matches 1
function sgp.cosmetics:kill_effects/reset_and_replace {kill:"witch",kill_name:"Witch",color:"light_purple"}
assert entity @s[tag=sgp.particle.smoke,tag=sgp.intensity.medium,tag=sgp.kill.witch]
