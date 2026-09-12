#> sgp.diorama:player_initialization
# Rebuild ownership after joining, even if the previous mannequins expired offline.

function sgp.diorama:cleanup_player
scoreboard players add @s sgp.leave_game 0
scoreboard players operation @s sgp.diorama_leave_seen = @s sgp.leave_game
