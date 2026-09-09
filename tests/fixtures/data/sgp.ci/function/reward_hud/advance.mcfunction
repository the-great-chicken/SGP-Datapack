#> sgp.ci:reward_hud/advance
# {ticks}: advance reward lifetimes through the production actionbar update.

$scoreboard players set #ci.reward.steps sgp.dummy $(ticks)
function sgp.ci:reward_hud/step
