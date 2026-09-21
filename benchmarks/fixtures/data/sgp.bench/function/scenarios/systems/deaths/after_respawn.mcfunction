#> sgp.bench:scenarios/systems/deaths/after_respawn
# Executed as the respawned actor: back to its grid slot and back in its kit, like a player
# walking out of the lobby.
tag @s remove sgp.bench.respawning
scoreboard players set @s sgp.bench.deaths 0
function sgp.bench:scenarios/abilities/common/reset_actor_position
function sgp.bench:scenarios/systems/deaths/give_kit
scoreboard players add #deaths_respawns sgp.bench 1
