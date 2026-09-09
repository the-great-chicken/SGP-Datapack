#> sgp.majeurs:hide_and_seek/reveal/refresh
# @dummy
# @timeout 180
# @environment sgp.ci:hider_reveal/refresh
#
# Refreshing a reveal extends visibility from the latest reveal, then expires normally.

function sgp.ci:hider_reveal/roster
function sgp.majeurs:hide_and_seek/timer/glow
await delay 40t
function sgp.majeurs:hide_and_seek/timer/glow
await delay 40t
assert entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
await delay 21t
assert not entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
