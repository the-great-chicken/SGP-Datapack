#> sgp.ci:reward_hud/advance
# `{ticks: positive int}`
#
# Advance reward lifetimes through the production actionbar update without running unrelated world ticks.

$scoreboard players set #ci.reward.steps sgp.dummy $(ticks)
function sgp.ci:reward_hud/step
