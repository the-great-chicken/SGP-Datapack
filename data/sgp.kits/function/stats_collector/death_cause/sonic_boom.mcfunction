# Final damage mechanism: sonic_boom (9)
scoreboard players set @s sgp.death_cause 9
advancement revoke @s only sgp.kits:death_cause/sonic_boom
function sgp.kits:stats_collector/collect_damage_received
