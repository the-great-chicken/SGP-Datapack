#> sgp.majeurs:hide_and_seek/reveal/audience
# @dummy
# @timeout 180
# @environment sgp.ci:hider_reveal/audience
#
# Only hiders become visible, and the next reveal announcement is queued.

function sgp.ci:hider_reveal/roster
function sgp.majeurs:hide_and_seek/timer/glow
assert entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
assert not entity @a[name=RevealSeeker,nbt={active_effects:[{id:"minecraft:glowing"}]}]
assert not entity @a[name=RevealIdle,nbt={active_effects:[{id:"minecraft:glowing"}]}]
execute store result score #ci.reveal.pending sgp.dummy run schedule clear sgp.majeurs:hide_and_seek/timer/glow_announce
assert score #ci.reveal.pending sgp.dummy matches 1
