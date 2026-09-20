#> sgp.ci:cooldown_hud/isolate_mixer_entry
# `{uid: int}`: keep only this Mixer entry in dah:actbar data.
#
# Every dummy that ever joined leaves a sleeping entry, and display/prepare only walks as many
# entries as there are online players, so a freshly registered entry at the end of the list is
# never rendered. The environment teardown restores the full Mixer state afterwards.

$data modify storage sgp.ci:cooldown_hud mine set from storage dah:actbar data[{UID:$(uid)}]
data modify storage dah:actbar data set value []
data modify storage dah:actbar data append from storage sgp.ci:cooldown_hud mine
data remove storage sgp.ci:cooldown_hud mine
