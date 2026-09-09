#> sgp.ci:water_enchantments/expect_no_penalty

assert not entity @s[nbt={active_effects:[{id:"minecraft:poison"}]}]
assert not entity @s[nbt={active_effects:[{id:"minecraft:darkness"}]}]
