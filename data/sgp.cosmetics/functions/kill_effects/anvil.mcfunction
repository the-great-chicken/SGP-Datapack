#> sgp.cosmetics:kill_effects/anvil
# 
# Anvil kill effect

summon minecraft:falling_block ~ ~ ~ {NoGravity:1,Time:-30,BlockState:{Name:"anvil",Properties:{facing:south}},DropItem:0}
playsound minecraft:block.anvil.land ambient @a ~ ~ ~ 0.8