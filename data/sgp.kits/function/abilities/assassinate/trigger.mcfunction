#> sgp.kits:abilities/assassinate/trigger
#
# Mark the triggered assassin and get his attacker's position

tag @s add sgp.assassin_triggered

execute on attacker at @s rotated ~ 0 run function sgp.kits:abilities/assassinate/check_tp_position

tag @s remove sgp.assassin_triggered

function sgp.kits:abilities/assassinate/end