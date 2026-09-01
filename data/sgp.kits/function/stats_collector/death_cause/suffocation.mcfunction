# Final damage mechanism: suffocation (21)
scoreboard players set @s sgp.death_cause 21
advancement revoke @s only sgp.kits:death_cause/suffocation
function sgp.kits:stats_collector/collect_damage_received
