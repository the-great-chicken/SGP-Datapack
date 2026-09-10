#> sgp.ci:mixer_lifecycle/cleanup
# Restore the complete actionbar-mixer state saved by setup and disconnect players.

function sgp.ci:players/cleanup
data modify storage dah:actbar {} set from storage sgp.ci:mixer previous
