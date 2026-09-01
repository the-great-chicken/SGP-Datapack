# Final damage mechanism: unknown/unclassified (0)
scoreboard players set @s sgp.death_cause 0
advancement revoke @s only sgp.kits:death_cause/unknown
function sgp.kits:stats_collector/collect_damage_received
