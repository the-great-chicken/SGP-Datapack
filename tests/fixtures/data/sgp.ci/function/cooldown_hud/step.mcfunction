#> sgp.ci:cooldown_hud/step
#
# Execute the remaining ability ticks requested by advance.

function sgp.kits:abilities/tick
scoreboard players remove @s sgp.dummy 1
execute if score @s sgp.dummy matches 1.. run function sgp.ci:cooldown_hud/step
