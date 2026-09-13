#> sgp.ci:hider_reveal/scenarios/expect_visible
# Verify the active hider/seeker roster remains valid while the hider is glowing.

function sgp.ci:hider_reveal/expect_active
assert entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
