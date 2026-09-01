# Final damage mechanism: explosion (14)
scoreboard players set @s sgp.death_cause 14
advancement revoke @s only sgp.kits:death_cause/explosion
function sgp.kits:stats_collector/collect_damage_received
