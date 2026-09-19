#> sgp.misc:actionbar_mixer/online_after_offline_row
# @dummy
# @environment sgp.ci:mixer_lifecycle
#
# A persisted offline Mixer row must not starve an online player's render on the next display pass.
# The first pass is important: a broken display/self renders once, but misclassifies the online row
# as sleeping and rotates it behind the offline row. The second pass exposes that bookkeeping error.

function sgp.ci:actionbar_mixer/fresh_registration
await score @s dah.actbar.UID matches 1..

data modify storage dah:actbar new set value {id:"sgp.ci:online_probe",text:{text:"Online probe"},order:1}
function dah.actbar_mixer:new/update_id

dummy MixerSleeper spawn
execute as MixerSleeper run function sgp.ci:actionbar_mixer/fresh_registration
await score MixerSleeper dah.actbar.UID matches 1..
dummy MixerSleeper leave

# Scan exactly one stored row, matching the real one-online-player case without depending on how
# many unrelated PackTest dummies happen to be connected to the shared test server.
function sgp.ci:actionbar_mixer/display_one

# A stale value makes this an observation of pass two, rather than accidentally accepting output
# left by pass one. With correct online bookkeeping, pass two replaces it with @s's Mixer content.
data modify storage dah:actbar display_content set value [{id:"sgp.ci:stale_render",text:{text:"stale"}}]
function sgp.ci:actionbar_mixer/display_one

assert data storage dah:actbar display_content[{id:"sgp.ci:online_probe",text:{text:"Online probe"}}]
assert not data storage dah:actbar display_content[{id:"sgp.ci:stale_render"}]
