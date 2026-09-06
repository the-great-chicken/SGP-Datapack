#> sgp.ci:cosmetic_rewards/cleanup
# Restore counters and remove test participants and celebrations, including after failure.

execute store result score #nbr_players sgp.particle.smoke_unlocked run data get storage sgp.ci:cosmetic_rewards saved.smoke
execute store result score #nbr_players sgp.particle.marine_unlocked run data get storage sgp.ci:cosmetic_rewards saved.marine
data remove storage sgp.ci:cosmetic_rewards saved
kill @e[type=firework_rocket]
function sgp.ci:players/cleanup
