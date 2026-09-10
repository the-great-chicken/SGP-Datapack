#> sgp.ci:water_enchantments/expect_no_penalty
# Require neither of the water-penalty status effects to be active.

assert not entity @s[nbt={active_effects:[{id:"minecraft:poison"}]}]
assert not entity @s[nbt={active_effects:[{id:"minecraft:darkness"}]}]
