#> sgp.cosmetics:kill_effects/death_reaper
# 
# Checks if a player died and summons the kill effect
#
# The kill effect is executed at the position of the death_reaper marker,
# which is summoned at the position the player was 1 tick before dying

execute as @a store result score @s sgp.killer on attacker run data get entity @s UUID.[1]

execute as @p[scores={sgp.death_effect=1..}] at @s run summon minecraft:marker ~ ~ ~ {CustomName:'"death_reaper"', Tags:["sgp.marker"]}
execute if entity @p[scores={sgp.death_effect=1..}] as @e[type=marker,tag=sgp.marker,name="death_reaper",limit=1] run function sgp.cosmetics:kill_effects/update_death_reaper_coords
execute if entity @p[scores={sgp.death_effect=1..}] as @a if score @s sgp.UUID = @p[scores={sgp.death_effect=1..}] sgp.killer run function sgp.cosmetics:kill_effects/summon
scoreboard players set @a sgp.death_effect 0
kill @e[type=marker,tag=sgp.marker,name="death_reaper",limit=1]