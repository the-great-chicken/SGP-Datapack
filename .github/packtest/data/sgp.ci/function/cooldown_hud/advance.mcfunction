#> sgp.ci:cooldown_hud/advance
# `{ticks: positive int}`
#
# Advance the real ability tick synchronously, without running unrelated world systems.

$scoreboard players set @s sgp.dummy $(ticks)
function sgp.ci:cooldown_hud/step
