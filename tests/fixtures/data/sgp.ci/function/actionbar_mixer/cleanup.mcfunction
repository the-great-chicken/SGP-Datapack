#> sgp.ci:actionbar_mixer/cleanup
# Disconnect test players and restore the complete Actionbar Mixer state saved by setup.

function sgp.ci:players/cleanup
data modify storage dah:actbar {} set from storage sgp.ci:actionbar_mixer previous
