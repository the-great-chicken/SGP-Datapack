#> sgp.majeurs:hide_and_seek/reset_player
#
# Reset the player

title @s times 10t 70t 20t
tag @s remove sgp.hider
tag @s remove sgp.seeker
attribute @s generic.attack_damage modifier remove sgp.hider
attribute @s generic.attack_damage modifier remove sgp.seeker
attribute @s generic.movement_speed modifier remove sgp.hider
attribute @s generic.jump_strength modifier remove sgp.hider
scoreboard players reset @s sgp.link_teams
function sgp.majeurs:hide_and_seek/stun/unstun
