#> sgp.cosmetics:kill_effects/anvil
# 
# Anvil kill effect

execute at @e[type=marker,tag=sgp.marker,name="death_reaper"] run summon minecraft:falling_block ~ ~ ~ {NoGravity:1,Time:-30,BlockState:{Name:"anvil",Properties:{facing:south}},DropItem:0}
execute at @e[type=marker,tag=sgp.marker,name="death_reaper"] run playsound minecraft:block.anvil.land ambient @a ~ ~ ~ 0.8