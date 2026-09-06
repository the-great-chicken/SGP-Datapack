#> sgp.ci:cosmetic_rewards/setup
# Preserve global completion counts for the batch; each test establishes its own inputs.

function sgp.ci:players/cleanup
kill @e[type=firework_rocket]
execute store result storage sgp.ci:cosmetic_rewards saved.smoke int 1 run scoreboard players get #nbr_players sgp.particle.smoke_unlocked
execute store result storage sgp.ci:cosmetic_rewards saved.marine int 1 run scoreboard players get #nbr_players sgp.particle.marine_unlocked
