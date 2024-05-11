$execute at @e[type=minecraft:marker,name="Death_Reaper"] run particle minecraft:$(particle)
$execute at @e[type=minecraft:marker,name="Death_Reaper"] run playsound minecraft:$(sound) master @a ~ ~ ~ 0.8
scoreboard players set @a death_effect 0