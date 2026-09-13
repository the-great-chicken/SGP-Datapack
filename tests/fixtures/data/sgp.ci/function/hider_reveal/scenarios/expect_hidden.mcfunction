#> sgp.ci:hider_reveal/scenarios/expect_hidden
# Verify the active hider/seeker roster remains valid while the hider is not glowing.

function sgp.ci:hider_reveal/expect_active
assert not entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
