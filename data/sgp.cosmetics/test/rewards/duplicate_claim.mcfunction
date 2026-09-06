#> sgp.cosmetics:rewards/duplicate_claim
# @dummy
# @environment sgp.ci:cosmetic_rewards/duplicate_claim
#
# A repeat claim neither increments the completion count nor repeats the public celebration.

tag @s add sgp.peaceful
scoreboard players set @s sgp.particle.smoke_unlocked 0
function sgp.cosmetics:reward/give {objective:"sgp.particle.smoke_unlocked",reward_name:"Smoke",reward_type:"Cloak",reward_color:8421504,trial_name:"Tower Trial"}
assert score @s sgp.particle.smoke_unlocked matches 1
assert score #nbr_players sgp.particle.smoke_unlocked matches 1
kill @e[type=firework_rocket]

# A new observer did not receive the original broadcast.
dummy RewardObserver spawn
function sgp.cosmetics:reward/give {objective:"sgp.particle.smoke_unlocked",reward_name:"Smoke",reward_type:"Cloak",reward_color:8421504,trial_name:"Tower Trial"}
assert score @s sgp.particle.smoke_unlocked matches 1
assert score #nbr_players sgp.particle.smoke_unlocked matches 1
assert chat ".*déjà récupéré cette récompense.*" @s
assert not chat ".*Tower Trial.*" RewardObserver
assert not chat ".*déjà récupéré cette récompense.*" RewardObserver
assert not entity @e[type=firework_rocket]
