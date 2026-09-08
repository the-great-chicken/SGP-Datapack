#> sgp.ci:pecking/cleanup

function sgp.ci:players/cleanup
data modify storage sgp:data kits.ability_cooldowns.pecking.cooldown set from storage sgp.ci:pecking previous_cooldown
