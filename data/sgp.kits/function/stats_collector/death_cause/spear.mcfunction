# Final damage mechanism: spear (3)
scoreboard players set @s sgp.death_cause 3
advancement revoke @s only sgp.kits:death_cause/spear
function sgp.kits:stats_collector/collect_damage_received
