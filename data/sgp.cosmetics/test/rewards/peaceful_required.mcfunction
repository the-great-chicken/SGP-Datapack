#> sgp.cosmetics:rewards/peaceful_required
# @dummy
# @environment sgp.ci:cosmetic_rewards
#
# A non-Peaceful player cannot claim a trial reward or change its completion count.

scoreboard players set @s sgp.particle.smoke_unlocked 0
scoreboard players set #nbr_players sgp.particle.smoke_unlocked 5
function sgp.cosmetics:reward/give {objective:"sgp.particle.smoke_unlocked",reward_name:"Smoke",reward_type:"Cloak",reward_color:8421504,trial_name:"Tower Trial"}
assert score @s sgp.particle.smoke_unlocked matches 0
assert score #nbr_players sgp.particle.smoke_unlocked matches 5
assert chat ".*Paisible.*récupérer cette récompense.*" @s
assert not chat ".*Tu viens de débloquer.*" @s
assert not entity @e[distance=..2,type=firework_rocket]
