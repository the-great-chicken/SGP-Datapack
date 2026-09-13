#> sgp.ci:hider_reveal/scenarios/refresh
# Run the production glow refresh and require the active hider to remain revealed.

function sgp.ci:hider_reveal/expect_active
function sgp.majeurs:hide_and_seek/timer/glow
assert entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
