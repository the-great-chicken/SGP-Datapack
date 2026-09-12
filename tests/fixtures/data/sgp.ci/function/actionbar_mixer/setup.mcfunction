#> sgp.ci:actionbar_mixer/setup
# Disconnect stale test players and snapshot the complete Actionbar Mixer state.

function sgp.ci:players/cleanup
data modify storage sgp.ci:actionbar_mixer previous set from storage dah:actbar {}
