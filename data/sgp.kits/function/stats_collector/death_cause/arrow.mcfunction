# Final damage mechanism: arrow (4)
scoreboard players set @s sgp.death_cause 4
advancement revoke @s only sgp.kits:death_cause/arrow
function sgp.kits:stats_collector/collect_damage_received
