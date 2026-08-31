#> sgp.majeurs:hide_and_seek/teams/apply_lost_effects
#
# Applies the hider penalties caused by dead teammates.

execute if score @s sgp.teammate_deaths matches 1 unless entity @s[tag=sgp.lost_jump_msg] \
    run tellraw @s [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"Un membre de ton équipe est mort : tu perds ton Saut Amélioré.", color:red}]
execute if score @s sgp.teammate_deaths matches 1 run tag @s add sgp.lost_jump_msg
execute if score @s sgp.teammate_deaths matches 1.. run effect clear @s jump_boost

execute if score @s sgp.teammate_deaths matches 2 unless entity @s[tag=sgp.lost_speed_msg] \
    run tellraw @s [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"Un autre membre de ton équipe est mort : tu perds ta Vitesse.", color:red}]
execute if score @s sgp.teammate_deaths matches 2 run tag @s add sgp.lost_speed_msg
execute if score @s sgp.teammate_deaths matches 2.. run effect clear @s speed