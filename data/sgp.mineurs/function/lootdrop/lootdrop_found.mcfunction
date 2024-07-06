setblock ~ ~ ~ air replace
playsound minecraft:block.beacon.power_select master @a[tag=sgp.in_game] ~ ~ ~ 1 0.5
tellraw @a[tag=sgp.in_game] [{"text":"Le coffre a été trouvé !","color":"gold"}]
particle minecraft:large_smoke ~ ~.5 ~ 0.2 0.2 0.2 0.02 1000