#> sgp.ci:repulsion/tick_probe
# Natural effect expiry proves the entities are ticking before either positive or negative impulse assertions.

effect give @e[tag=sgp.ci.repulsion,type=husk] glowing 1 0 true
execute as @e[tag=sgp.ci.repulsion,type=husk] run assert entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
