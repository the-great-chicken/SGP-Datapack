#> sgp.majeurs:hide_and_seek/reveal/announcement_delay
# @dummy
# @timeout 180
# @environment sgp.ci:hider_reveal/announcement_delay
#
# The five-second warning precedes the scheduled reveal instead of exposing hiders immediately.

function sgp.ci:hider_reveal/roster
function sgp.majeurs:hide_and_seek/timer/glow_announce
assert not entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
await delay 80t
assert not entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
await delay 21t
assert entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
