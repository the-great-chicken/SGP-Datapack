clone 2439 252 2141 2439 252 2141 2429 252 2132
tellraw @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72] [{"text":"Désactivation des Événements Mineurs","color":"red","bold":true}]
setblock 2433 251 2160 minecraft:redstone_block
setblock 2431 251 2172 air
execute unless score #confines_secondes test matches 0 unless score #confines_tick test matches 0 run scoreboard players set #confines_minutes timer_second 5
scoreboard players set #confines_secondes timer_second 0
execute at @e[type=marker,name="Lootdrop"] run setblock ~ ~ ~ air