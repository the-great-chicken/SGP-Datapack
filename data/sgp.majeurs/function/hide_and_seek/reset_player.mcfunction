#> sgp.majeurs:hide_and_seek/reset_player
#
# Reset the player

title @s times 10t 70t 20t

tag @s remove sgp.hider
tag @s remove sgp.seeker
tag @s remove sgp.seeker_waiting
tag @s remove sgp.lost_jump_msg
tag @s remove sgp.lost_speed_msg

effect clear @s

attribute @s attack_damage modifier remove sgp:hide_and_seek.hider
attribute @s attack_damage modifier remove sgp:hide_and_seek.seeker
attribute @s water_movement_efficiency modifier remove sgp:hide_and_seek.water_movement

clear @s

scoreboard players reset @s sgp.link_teams
scoreboard players reset @s sgp.teammate_deaths
scoreboard players reset @s sgp.timer
function sgp.misc:stun/clear