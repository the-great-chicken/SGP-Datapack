# Final damage mechanism: indirect_magic (15)
scoreboard players set @s sgp.death_cause 15
advancement revoke @s only sgp.kits:death_cause/indirect_magic
function sgp.kits:stats_collector/collect_damage_received
