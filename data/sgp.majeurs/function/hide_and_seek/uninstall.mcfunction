#> sgp.majeurs:hide_and_seek/uninstall
#
# Remove Cache-cache-owned objectives, teams, and actionbar state.

execute as @a run function sgp.majeurs:hide_and_seek/actionbar/clear

team remove sgp.hider
team remove sgp.seeker

scoreboard objectives remove sgp.link_teams
scoreboard objectives remove sgp.teammate_deaths
scoreboard objectives remove sgp.ab.hide_hider
