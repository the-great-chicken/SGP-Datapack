#> sgp.majeurs:hide_and_seek/initialization
#
# Create Cache-cache-owned objectives, teams, and actionbar state.

scoreboard objectives add sgp.link_teams dummy
scoreboard objectives add sgp.teammate_deaths dummy
scoreboard objectives add sgp.ab.hide_hider dummy
scoreboard players set #sgp.ab.width.hide_hider sgp.dummy 344

team add sgp.hider "Volaille"
team modify sgp.hider collisionRule pushOtherTeams
team modify sgp.hider nametagVisibility never
team modify sgp.hider color yellow

team add sgp.seeker "Chasseurs"
team modify sgp.seeker friendlyFire false
team modify sgp.seeker color dark_green
