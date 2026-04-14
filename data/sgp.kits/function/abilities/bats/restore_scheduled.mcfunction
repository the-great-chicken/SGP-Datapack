#> sgp.kits:abilities/bats/restore_scheduled
#
# Only restore equipment of players whose ability just ended

# Magic number is cooldown time - invisibility duration + 2
tag @a[tag=sgp.hidden_equipment,scores={sgp.cooldown_ability=..102}] add sgp.processing
execute as @a[tag=sgp.processing] at @s summon armor_stand run function sgp.kits:abilities/bats/restore/equipment
tag @a[tag=sgp.processing] remove sgp.hidden_equipment
tag @a[tag=sgp.processing] remove sgp.processing