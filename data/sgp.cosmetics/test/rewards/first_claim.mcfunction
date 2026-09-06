#> sgp.cosmetics:rewards/first_claim
# @dummy
# @environment sgp.ci:cosmetic_rewards/first_claim
#
# Claiming saves the unlock and advances the existing completion count, without auto-equipping it.

tag @s add sgp.peaceful
tag @s add sgp.particle.cloud
tag @s add sgp.intensity.light
scoreboard players reset @s sgp.particle.smoke_unlocked
scoreboard players set #nbr_players sgp.particle.smoke_unlocked 7
function sgp.cosmetics:reward/give {objective:"sgp.particle.smoke_unlocked",reward_name:"Smoke",reward_type:"Cloak",reward_color:8421504,trial_name:"Tower Trial"}
assert score @s sgp.particle.smoke_unlocked matches 1
assert score #nbr_players sgp.particle.smoke_unlocked matches 8
assert chat ".*Tu viens de débloquer Cloak Smoke.*" @s
assert chat ".*8e personne.*Tower Trial.*" @s
assert entity @s[tag=sgp.particle.cloud,tag=sgp.intensity.light]
assert not entity @s[tag=sgp.particle.smoke]
execute store result score @s sgp.dummy if entity @e[type=firework_rocket]
assert score @s sgp.dummy matches 1

# The earned unlock must actually be accepted by the cosmetic selection entry point.
function sgp.cosmetics:particles/reset_and_replace {particle:"smoke",particle_name:"Smoke",color:"gray"}
assert entity @s[tag=sgp.particle.smoke,tag=sgp.intensity.light]
assert not entity @s[tag=sgp.particle.cloud]
