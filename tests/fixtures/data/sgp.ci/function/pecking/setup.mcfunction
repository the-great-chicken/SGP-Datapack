#> sgp.ci:pecking/setup
# Save the production Pecking cooldown and replace it with a deterministic test value.

function sgp.ci:players/cleanup
data modify storage sgp.ci:pecking previous_cooldown set from storage sgp:data kits.ability_cooldowns.pecking.cooldown
data modify storage sgp:data kits.ability_cooldowns.pecking.cooldown set value 37
