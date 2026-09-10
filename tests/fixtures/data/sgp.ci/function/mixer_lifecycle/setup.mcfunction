#> sgp.ci:mixer_lifecycle/setup
# Snapshot the complete actionbar-mixer state before a lifecycle test mutates it.

function sgp.ci:players/cleanup
data modify storage sgp.ci:mixer previous set from storage dah:actbar {}
