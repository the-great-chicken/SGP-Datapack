#> sgp.cosmetics:kill_effects/death_reaper
# 
# Checks if a player died and summons the kill effect
#
# The kill effect is executed at the position of the death_reaper marker,
# which is summoned at the position the player was 1 tick before dying

advancement revoke @s only sgp.cosmetics:death

execute as @a[tag=sgp.in_game] store result score @s sgp.killer on attacker run data get entity @s UUID.[1]

summon minecraft:marker ~ ~ ~ {CustomName:'"death_reaper"', Tags:["sgp.marker"]}

tag @s add sgp.death

execute as @e[type=marker,tag=sgp.marker,name="death_reaper",limit=1] run data modify entity @s Pos set from entity @p[tag=sgp.death] LastDeathLocation.pos

execute on attacker run function sgp.cosmetics:kill_effects/summon

scoreboard players set @a[tag=sgp.in_game] sgp.death_effect 0

kill @e[type=marker,tag=sgp.marker,name="death_reaper",limit=1]

tag @s remove sgp.death
