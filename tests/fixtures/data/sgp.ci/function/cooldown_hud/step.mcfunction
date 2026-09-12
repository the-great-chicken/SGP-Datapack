#> sgp.ci:cooldown_hud/step
# Execute the remaining ability ticks requested by advance.

function sgp.kits:abilities/tick
scoreboard players remove #ci.hud.remaining sgp.dummy 1
execute if score #ci.hud.remaining sgp.dummy matches 1.. run function sgp.ci:cooldown_hud/step
