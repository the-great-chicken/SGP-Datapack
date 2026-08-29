# Final damage mechanism: fire_contact (12)
scoreboard players set @s sgp.death_cause 12
advancement revoke @s only sgp.kits:death_cause/fire_contact
function sgp.kits:stats_collector/collect_damage_received
