#> sgp.ci:hider_reveal/scenarios/expect_hidden

function sgp.ci:hider_reveal/expect_active
assert not entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
