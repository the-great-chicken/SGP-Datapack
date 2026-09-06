#> sgp.cosmetics:rewards/independent_claims
# @dummy
# @environment sgp.ci:cosmetic_rewards
#
# Different players can earn the same reward, and different trials maintain separate unlocks and counts.

tag @s add sgp.peaceful
scoreboard players set #nbr_players sgp.particle.smoke_unlocked 0
scoreboard players set #nbr_players sgp.particle.marine_unlocked 0
dummy RewardOther spawn
tag RewardOther add sgp.peaceful
scoreboard players set @s sgp.particle.smoke_unlocked 0
scoreboard players set @s sgp.particle.marine_unlocked 0
scoreboard players set RewardOther sgp.particle.smoke_unlocked 0
scoreboard players set RewardOther sgp.particle.marine_unlocked 0
function sgp.cosmetics:reward/give {objective:"sgp.particle.smoke_unlocked",reward_name:"Smoke",reward_type:"Cloak",reward_color:8421504,trial_name:"Tower Trial"}
assert score RewardOther sgp.particle.smoke_unlocked matches 0
assert score @s sgp.particle.marine_unlocked matches 0
assert score #nbr_players sgp.particle.smoke_unlocked matches 1
execute as RewardOther at @s run function sgp.cosmetics:reward/give {objective:"sgp.particle.smoke_unlocked",reward_name:"Smoke",reward_type:"Cloak",reward_color:8421504,trial_name:"Tower Trial"}
assert score @s sgp.particle.smoke_unlocked matches 1
assert score RewardOther sgp.particle.smoke_unlocked matches 1
assert score #nbr_players sgp.particle.smoke_unlocked matches 2
function sgp.cosmetics:reward/give {objective:"sgp.particle.marine_unlocked",reward_name:"Marine",reward_type:"Cloak",reward_color:65535,trial_name:"Water Trial"}
assert score @s sgp.particle.marine_unlocked matches 1
assert score RewardOther sgp.particle.marine_unlocked matches 0
assert score #nbr_players sgp.particle.marine_unlocked matches 1
assert score #nbr_players sgp.particle.smoke_unlocked matches 2
assert chat ".*1e personne.*Water Trial.*" RewardOther
