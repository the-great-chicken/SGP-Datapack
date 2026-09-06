#> sgp.ci:cosmetic_rewards/setup
# Preserve global completion counts while the test uses its own participants.

function sgp.ci:players/cleanup
kill @e[type=firework_rocket]
execute store result storage sgp.ci:cosmetic_rewards saved.smoke int 1 run scoreboard players get #nbr_players sgp.particle.smoke_unlocked
execute store result storage sgp.ci:cosmetic_rewards saved.marine int 1 run scoreboard players get #nbr_players sgp.particle.marine_unlocked
scoreboard players set #nbr_players sgp.particle.smoke_unlocked 0
scoreboard players set #nbr_players sgp.particle.marine_unlocked 0
