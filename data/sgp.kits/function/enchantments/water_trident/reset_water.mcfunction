#> sgp.kits:enchantments/water_trident/reset_water
#
# Check for temp water markers without players on them,
# and replace their water back with the correct air and kill them

execute if entity @s[tag=sgp.was_air] run setblock ~ ~ ~ air strict
execute if entity @s[tag=sgp.was_cave_air] run setblock ~ ~ ~ cave_air strict
execute if entity @s[tag=sgp.was_void_air] run setblock ~ ~ ~ void_air strict

kill @s