#> sgp.majeurs:pco/dispatch
#
# Dispatch participants once in random order, keeping team sizes within one player.

scoreboard players set #pco_dispatch_team sgp.dummy 0
execute as @a[tag=sgp.major_participant,sort=random] run function sgp.majeurs:pco/dispatch_player
