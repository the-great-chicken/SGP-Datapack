#> sgp.cosmetics:kill_effects/death_reaper
#
# Checks if a player died and summons the kill effect
#
# Execute the attacker's selected effect at the victim's position.

advancement revoke @s only sgp.cosmetics:death

execute at @s on attacker run function sgp.cosmetics:kill_effects/summon

scoreboard players set @a[tag=sgp.in_game] sgp.death_effect 0
