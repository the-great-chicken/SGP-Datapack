# Final damage mechanism: fireworks (10)
scoreboard players set @s sgp.death_cause 10
advancement revoke @s only sgp.kits:death_cause/fireworks
function sgp.kits:stats_collector/collect_damage_received
