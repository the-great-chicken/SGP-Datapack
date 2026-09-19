#> sgp.ci:actionbar_mixer/display_one
# Run one Mixer display pass with a one-row scan budget.
# This is display/prepare with the online-player count made deterministic for the regression test.

scoreboard players set #count dah.actbar.calc 1
data modify storage dah:actbar temp set value []
data modify storage dah:actbar sleep set value []
function dah.actbar_mixer:z_private/display/main
function dah.actbar_mixer:z_private/display/cleanup
