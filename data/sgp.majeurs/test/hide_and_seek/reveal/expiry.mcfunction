#> sgp.majeurs:hide_and_seek/reveal/expiry
# @dummy
# @timeout 180
# @environment sgp.ci:hider_reveal/expiry
#
# The reveal lasts three seconds and does not remain on players indefinitely.

function sgp.ci:hider_reveal/roster
function sgp.majeurs:hide_and_seek/timer/glow
assert entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
await delay 61t
assert not entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
