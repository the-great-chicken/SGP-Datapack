# Final damage mechanism: fireball (7)
scoreboard players set @s sgp.death_cause 7
advancement revoke @s only sgp.kits:death_cause/fireball
function sgp.kits:stats_collector/collect_damage_received
