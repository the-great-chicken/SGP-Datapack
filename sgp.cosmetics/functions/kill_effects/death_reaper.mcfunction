execute as @a store result score @s sgp.killer on attacker run data get entity @s UUID.[1]

execute as @a[scores={sgp.death_effect=1..}] at @s run summon minecraft:marker ~ ~ ~ {CustomName:'[{"text":"death_reaper"}]'}
execute if entity @a[scores={sgp.death_effect=1..}] store result entity @e[type=minecraft:marker,name="death_reaper",limit=1] Pos[0] double 0.01 run scoreboard players get @a[scores={sgp.death_effect=1..},limit=1] sgp.posx1
execute if entity @a[scores={sgp.death_effect=1..}] store result entity @e[type=minecraft:marker,name="death_reaper",limit=1] Pos[1] double 0.01 run scoreboard players get @a[scores={sgp.death_effect=1..},limit=1] sgp.posy1
execute if entity @a[scores={sgp.death_effect=1..}] store result entity @e[type=minecraft:marker,name="death_reaper",limit=1] Pos[2] double 0.01 run scoreboard players get @a[scores={sgp.death_effect=1..},limit=1] sgp.posz1

execute if entity @a[scores={sgp.death_effect=1..}] as @a[tag=portal_kill] if score @s sgp.UUID = @r[scores={sgp.death_effect=1..}] sgp.killer run function sgp.cosmetics:kill_effects/particle_and_sound {particle:"portal ~ ~0.5 ~ 0.1 0.1 0.1 0.6 500", sound:"block.portal.trigger"}
execute if entity @a[scores={sgp.death_effect=1..}] as @a[tag=anvil_kill] if score @s sgp.UUID = @r[scores={sgp.death_effect=1..}] sgp.killer run function sgp.cosmetics:kill_effects/anvil
execute if entity @a[scores={sgp.death_effect=1..}] as @a[tag=explosion_kill] if score @s sgp.UUID = @r[scores={sgp.death_effect=1..}] sgp.killer run function sgp.cosmetics:kill_effects/particle_and_sound {particle:"explosion_emitter ~ ~ ~ 0 0 0 1 1", sound:"entity.generic.explode"}
execute if entity @a[scores={sgp.death_effect=1..}] as @a[tag=cloud_kill] if score @s sgp.UUID = @r[scores={sgp.death_effect=1..}] sgp.killer run function sgp.cosmetics:kill_effects/particle {particle:"cloud ~ ~1.5 ~ 0 0 0 0.6 250"}
execute if entity @a[scores={sgp.death_effect=1..}] as @a[tag=witch_kill] if score @s sgp.UUID = @r[scores={sgp.death_effect=1..}] sgp.killer run function sgp.cosmetics:kill_effects/particle {particle:"witch ~ ~0.5 ~ 0 0.4 0 1 500"}
execute if entity @a[scores={sgp.death_effect=1..}] as @a[tag=hurt_kill] if score @s sgp.UUID = @r[scores={sgp.death_effect=1..}] sgp.killer run function sgp.cosmetics:kill_effects/particle {particle:"damage_indicator ~ ~0.9 ~ 0 0 0 0.5 50"}
execute if entity @a[scores={sgp.death_effect=1..}] as @a[tag=firework_kill] if score @s sgp.UUID = @r[scores={sgp.death_effect=1..}] sgp.killer run function sgp.cosmetics:kill_effects/firework
execute if entity @a[scores={sgp.death_effect=1..}] as @a[tag=splash_kill] if score @s sgp.UUID = @r[scores={sgp.death_effect=1..}] sgp.killer run function sgp.cosmetics:kill_effects/particle_and_sound {particle:"splash ~ ~1 ~ 0.15 0.3 0.15 0 2000", sound:"entity.player.splash.high_speed"}
scoreboard players set @a sgp.death_effect 0
kill @e[type=minecraft:marker,name="death_reaper",limit=1]