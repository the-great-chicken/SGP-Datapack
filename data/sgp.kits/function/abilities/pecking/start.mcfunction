execute as @s run function #bs.view:at_aimed_entity {run:"tag @s add sgp.is_pecking", with:{max_distance:4}}

execute unless entity @s[tag=sgp.is_pecking] run playsound entity.villager.no master @s ~ ~ ~ 1 1.2