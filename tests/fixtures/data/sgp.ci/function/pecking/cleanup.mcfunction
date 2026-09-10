#> sgp.ci:pecking/cleanup
# Restore the production Pecking cooldown and disconnect fixture players.

function sgp.ci:players/cleanup
data modify storage sgp:data kits.ability_cooldowns.pecking.cooldown set from storage sgp.ci:pecking previous_cooldown
