#> sgp.mineurs:lootdrop/close_detection/tick/closed
#
# Things that happen when the chest is closed (remove the chest, particles,...)

tag @a[tag=sgp.container_open] remove sgp.container_open

setblock ~ ~ ~ air replace

playsound minecraft:block.beacon.power_select master @a[tag=sgp.in_game] ~ ~ ~ 1 0.5

tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Le coffre a été trouvé !", "color":"gold"}]

particle minecraft:large_smoke ~ ~.5 ~ 0.2 0.2 0.2 0.02 1000