scoreboard players add #events_mineurs timer_second 1

# Passage à la minute supérieure
execute if score #events_mineurs timer_second matches 600 run scoreboard players add #events_mineurs_minutes timer_second 1 
execute if score #events_mineurs timer_second matches 600 run scoreboard players set #events_mineurs timer_second 0

# Event Mineur
execute if score #events_mineurs_minutes timer_second = #random_out random_calc run function mineurs:choose_event
execute if score #events_mineurs_minutes timer_second = #random_out random_calc run playsound minecraft:entity.experience_orb.pickup ambient @a 2429.70 254.00 2132.25 1000
execute if score #events_mineurs_minutes timer_second = #random_out random_calc run function mineurs:lgc_run
execute if score #events_mineurs_minutes timer_second = #random_out random_calc run scoreboard players set #events_mineurs_minutes timer_second 0

# Lootdrop 1 minute avant l'event mineur
execute if score #events_mineurs_minutes timer_second = #random_out_moins_1 random_calc if score #events_mineurs timer_second matches 0 run title @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72] title {"text":"LOOTDROP!","color":"gold","bold":true}
execute if score #events_mineurs_minutes timer_second = #random_out_moins_1 random_calc if score #events_mineurs timer_second matches 0 run tellraw @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72] ["",{"text":"LOOTDROP! ","color":"gold","bold":true},{"text":"Le Grand Poulet a fait apparaitre un coffre contenant du loot précieux quelque part sur la map !","color":"yellow"}]
execute if score #events_mineurs_minutes timer_second = #random_out_moins_1 random_calc if score #events_mineurs timer_second matches 0 as @e[type=minecraft:marker,name="Lootdrop",limit=1,sort=random] at @s run setblock ~ ~ ~ minecraft:trapped_chest{LootTable:"mineurs:lootdrop_chest"} replace