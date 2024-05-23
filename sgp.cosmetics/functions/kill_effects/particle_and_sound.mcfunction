$execute at @e[type=minecraft:marker,name="death_reaper"] run particle minecraft:$(particle)
$execute at @e[type=minecraft:marker,name="death_reaper"] run playsound minecraft:$(sound) master @a ~ ~ ~ 0.8
scoreboard players set @a sgp.death_effect 0