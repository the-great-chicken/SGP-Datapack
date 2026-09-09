#> sgp.ci:hider_reveal/scenarios/expect_visible

function sgp.ci:hider_reveal/expect_active
assert entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
