#> sgp.majeurs:pco/dispatch_player
# Assign the current participant to the next PCO team.

execute if score #pco_dispatch_team sgp.dummy matches 0 run team join sgp.Poule @s
execute if score #pco_dispatch_team sgp.dummy matches 1 run team join sgp.Canard @s
execute if score #pco_dispatch_team sgp.dummy matches 2 run team join sgp.Oie @s
scoreboard players add #pco_dispatch_team sgp.dummy 1
execute if score #pco_dispatch_team sgp.dummy matches 3.. run scoreboard players set #pco_dispatch_team sgp.dummy 0
