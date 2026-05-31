#> sgp.mineurs:bounty/stop

tag @a[tag=sgp.wanted] remove sgp.wanted
effect clear @a[tag=sgp.wanted] minecraft:glowing
schedule clear sgp.mineurs:bounty/end
scoreboard players set #second sgp.timer 0