scoreboard players add #events_mineurs timer 1

# Passage à la minute supérieure
execute if score #events_mineurs timer matches 600 run scoreboard players add #events_mineurs_minutes timer 1 
execute if score #events_mineurs timer matches 600 run scoreboard players set #events_mineurs timer 0

# Event Mineur
execute if score #events_mineurs_minutes timer = #random_out random_calc run function sgp.mineurs:common/choose_event
execute if score #events_mineurs_minutes timer = #random_out random_calc run playsound minecraft:entity.experience_orb.pickup ambient @a 2429.70 254.00 2132.25 1000
execute if score #events_mineurs_minutes timer = #random_out random_calc run function sgp.mineurs:misc/lgc_run
execute if score #events_mineurs_minutes timer = #random_out random_calc run scoreboard players set #events_mineurs_minutes timer 0

# Lootdrop 1 minute avant l'event mineur
execute if score #events_mineurs_minutes timer = #random_out_moins_1 random_calc if score #events_mineurs timer matches 0 run function sgp.mineurs:lootdrop/start