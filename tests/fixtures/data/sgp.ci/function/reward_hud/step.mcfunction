#> sgp.ci:reward_hud/step
# Run one synchronous reward/actionbar update and recurse for the requested number of ticks.

function sgp.misc:actionbar/tick
scoreboard players remove #ci.reward.steps sgp.dummy 1
execute if score #ci.reward.steps sgp.dummy matches 1.. run function sgp.ci:reward_hud/step
