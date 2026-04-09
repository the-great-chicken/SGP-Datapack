# 1. Increment the age of all active sweeps
scoreboard players add @e[type=item_display,tag=sgp.giant_sweep] sgp.timer 1

# 2. Swap the item model based on their exact age
execute as @e[type=item_display,tag=sgp.giant_sweep,scores={sgp.timer=1}] run item replace entity @s container.0 with paper[item_model='sgp.kits:giant_sweep_1']
execute as @e[type=item_display,tag=sgp.giant_sweep,scores={sgp.timer=2}] run item replace entity @s container.0 with paper[item_model='sgp.kits:giant_sweep_2']
execute as @e[type=item_display,tag=sgp.giant_sweep,scores={sgp.timer=3}] run item replace entity @s container.0 with paper[item_model='sgp.kits:giant_sweep_3']
execute as @e[type=item_display,tag=sgp.giant_sweep,scores={sgp.timer=4}] run item replace entity @s container.0 with paper[item_model='sgp.kits:giant_sweep_4']
execute as @e[type=item_display,tag=sgp.giant_sweep,scores={sgp.timer=5}] run item replace entity @s container.0 with paper[item_model='sgp.kits:giant_sweep_5']
execute as @e[type=item_display,tag=sgp.giant_sweep,scores={sgp.timer=6}] run item replace entity @s container.0 with paper[item_model='sgp.kits:giant_sweep_6']
execute as @e[type=item_display,tag=sgp.giant_sweep,scores={sgp.timer=7}] run item replace entity @s container.0 with paper[item_model='sgp.kits:giant_sweep_7']

execute as @e[type=item_display,tag=sgp.giant_sweep,scores={sgp.timer=8..}] run kill @s