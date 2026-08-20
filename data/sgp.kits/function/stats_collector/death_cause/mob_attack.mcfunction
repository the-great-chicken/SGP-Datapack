# Final damage mechanism: mob_attack (27)
scoreboard players set @s sgp.death_cause 27
advancement revoke @s only sgp.kits:death_cause/mob_attack
function sgp.kits:stats_collector/collect_damage_received
