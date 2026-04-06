#> sgp.kits:abilities/water_trident/place_water
#
# This function only runs when the player has passed the cooldown check and is standing in a valid air block.
# It summons the marker, places the water, and applies the cooldown.

execute if block ~ ~ ~ minecraft:air run summon marker ~ ~ ~ {CustomName:"temp_water",Tags:["sgp.was_air","sgp.marker","global.ignore"]}
execute if block ~ ~ ~ minecraft:cave_air run summon marker ~ ~ ~ {CustomName:"temp_water",Tags:["sgp.was_cave_air","sgp.marker","global.ignore"]}
execute if block ~ ~ ~ minecraft:void_air run summon marker ~ ~ ~ {CustomName:"temp_water",Tags:["sgp.was_void_air","sgp.marker","global.ignore"]}

setblock ~ ~ ~ water strict

scoreboard players set @s sgp.cooldown_water_trident 100