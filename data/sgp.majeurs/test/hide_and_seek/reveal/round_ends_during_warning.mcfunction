#> sgp.majeurs:hide_and_seek/reveal/round_ends_during_warning
# @dummy
# @timeout 180
# @environment sgp.ci:hider_reveal/round_ends_during_warning
#
# A pending reveal stops when the round ends during its warning and does not start another cycle.

function sgp.ci:hider_reveal/roster
function sgp.majeurs:hide_and_seek/timer/glow_announce
await delay 40t
# End the roster while leaving the pending callback intact to test its own guard.
function sgp.ci:hider_reveal/expect_active
team leave @s
team leave RevealSeeker
tag @s remove sgp.major_participant
tag RevealSeeker remove sgp.major_participant
await delay 61t
assert not entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
execute store result score #ci.reveal.pending sgp.dummy run schedule clear sgp.majeurs:hide_and_seek/timer/glow
assert score #ci.reveal.pending sgp.dummy matches 0
execute store result score #ci.reveal.pending sgp.dummy run schedule clear sgp.majeurs:hide_and_seek/timer/glow_announce
assert score #ci.reveal.pending sgp.dummy matches 0
