#> sgp.cosmetics:kill_effects/anvil
# 
# Anvil kill effect

summon minecraft:falling_block ~ ~ ~ {NoGravity:true,Time:-30,BlockState:{Name:"anvil",Properties:{facing:south}},DropItem:false}
playsound minecraft:block.anvil.land ambient @a[tag=sgp.in_game] ~ ~ ~ 0.8