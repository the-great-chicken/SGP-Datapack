#> sgp.kits:abilities/assassinate/trigger
#
# Mark the triggered assassin and get his attacker's position

tag @s add sgp.assassin_triggered

execute on attacker at @s rotated ~ 0 run function sgp.kits:abilities/assassinate/check_tp_position

schedule function sgp.kits:abilities/assassinate/rotate_delayed 2t

function sgp.kits:abilities/assassinate/end