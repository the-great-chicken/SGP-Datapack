#> sgp.kits:abilities/cleave/animation_tick

# 1. Increment the age of all active sweeps
scoreboard players add @s sgp.timer 1

# 2. Swap the item model based on their exact age
execute if score @s sgp.timer matches 1 run return run item replace entity @s container.0 with paper[item_model='sgp.kits:giant_sweep_1']
execute if score @s sgp.timer matches 2 run return run item replace entity @s container.0 with paper[item_model='sgp.kits:giant_sweep_2']
execute if score @s sgp.timer matches 3 run return run item replace entity @s container.0 with paper[item_model='sgp.kits:giant_sweep_3']
execute if score @s sgp.timer matches 4 run return run item replace entity @s container.0 with paper[item_model='sgp.kits:giant_sweep_4']
execute if score @s sgp.timer matches 5 run return run item replace entity @s container.0 with paper[item_model='sgp.kits:giant_sweep_5']
execute if score @s sgp.timer matches 6 run return run item replace entity @s container.0 with paper[item_model='sgp.kits:giant_sweep_6']
execute if score @s sgp.timer matches 7 run return run item replace entity @s container.0 with paper[item_model='sgp.kits:giant_sweep_7']

execute if score @s sgp.timer matches 8 run return run kill @s