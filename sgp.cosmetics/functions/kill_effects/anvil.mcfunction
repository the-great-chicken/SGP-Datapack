execute at @e[type=minecraft:marker,name="death_reaper"] run summon minecraft:falling_block ~ ~ ~ {NoGravity:1,Time:-30,BlockState:{Name:"anvil",Properties:{facing:south}},DropItem:0}
execute at @e[type=minecraft:marker,name="death_reaper"] run playsound minecraft:block.anvil.land ambient @a ~ ~ ~ 0.8
scoreboard players set @a death_effect 0