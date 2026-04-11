execute as @s run function #bs.view:as_aimed_entity {run:"tag @s add sgp.is_being_pecked", with:{max_distance:4}}

# Stop pecking if not looking at player
execute unless entity @e[tag=sgp.is_being_pecked] run scoreboard players set @s sgp.cooldown_ability 20
execute unless entity @e[tag=sgp.is_being_pecked] run return run tag @s remove sgp.is_pecking

# Only peck every few ticks (modifiable value)
scoreboard players add #pecking_few_ticks sgp.timer 1
execute unless score #pecking_few_ticks sgp.timer matches 4.. run return run tag @e[tag=sgp.is_being_pecked] remove sgp.is_being_pecked

damage @e[tag=sgp.is_being_pecked,limit=1] 1 sgp.kits:pecking by @s
tag @e[tag=sgp.is_being_pecked] remove sgp.is_being_pecked

scoreboard players set #pecking_few_ticks sgp.timer 0