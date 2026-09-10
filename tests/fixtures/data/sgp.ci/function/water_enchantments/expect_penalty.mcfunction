#> sgp.ci:water_enchantments/expect_penalty
# Require both production water-penalty status effects to be active.

assert entity @s[nbt={active_effects:[{id:"minecraft:poison"},{id:"minecraft:darkness"}]}]
