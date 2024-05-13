execute in minisjeux_crea run function even_tick_functions


# Trigger Rewards
execute in minisjeux_crea run function world:reward_laby
execute in minisjeux_crea as @a unless entity @s[tag=enderman] unless entity @s[tag=pigeon] unless entity @s[tag=eclaireur] unless entity @s[tag=cancer] unless entity @s[tag=archer] run function world:reward_jump_hardest
execute in minisjeux_crea as @a unless entity @s[tag=enderman] unless entity @s[tag=pigeon] unless entity @s[tag=eclaireur] unless entity @s[tag=cancer] unless entity @s[tag=archer] run function world:reward_jump_diff_2


# Spawns
execute in minisjeux_crea run function spawns:check_and_execute_spawn
execute in minisjeux_crea as @p[scores={spawn_random=1..}] run function spawns:random
execute in minisjeux_crea as @a[scores={kits_vers_spawn=1..}] unless predicate majeurs:event_in_progress run function kits:sort_salle_kits
execute in minisjeux_crea as @a[scores={kits_vers_spawn=1..}] if predicate majeurs:event_in_progress run function majeurs:kits_to_spawn
execute in minisjeux_crea as @a[scores={spawn_vers_kits=1..}] run function kits:entre_salle_kits


# Kits
execute in minisjeux_crea run function kits:check_and_run_kits
execute in minisjeux_crea run function kits:check_kit_unlock
execute in minisjeux_crea as @p[scores={veut_random=1..}] run function kits:random
execute in minisjeux_crea run function kits:check_kills_give
execute in minisjeux_crea run function kits:tags_management
execute in minisjeux_crea as @a[x=2422.5,y=251.5,z=2136.5,distance=..1.5] unless score @s entre_kits > 0 test run scoreboard players enable @s entre_kits
execute in minisjeux_crea as @a[nbt={Pos:[2422.5d,251.5d,2136.5d]}] run function kits:sort_salle_kits
execute in minisjeux_crea as @a[scores={entre_kits=1..}] run function kits:entre_salle_kits
execute in minisjeux_crea as @a[scores={sort_kits=1..}] unless predicate majeurs:event_in_progress run function kits:sort_salle_kits
execute in minisjeux_crea as @a[scores={sort_kits=1..}] if predicate majeurs:event_in_progress run function majeurs:cannot_tp_to_lobby


# Miscellaneous
execute in minisjeux_crea run function world:run_lieux_trouves
execute in minisjeux_crea as @a[scores={death_reset_tags=1..}] run function world:on_death
execute in minisjeux_crea run function world:kill_counter
execute in minisjeux_crea run function world:temple_teleporter
execute in minisjeux_crea at @e[type=marker,name="Lootdrop"] if block ~ ~ ~ minecraft:trapped_chest run particle dust 1.000 0.800 0.100 2.5 ~ ~ ~ 0.3 40 0.3 10 30 force
execute in minisjeux_crea as @e[x=2454,y=193,z=2191,dx=12,dy=0,dz=6] run damage @s 6 minecraft:hot_floor
execute if score #128_ticks_clock test matches 0 run function world:kill_streaks_management
execute if score #128_ticks_clock test matches 0 as @a run function world:kd_buff_and_debuffs
scoreboard players add #128_ticks_clock test 1
execute if score #128_ticks_clock test matches 128 run scoreboard players set #128_ticks_clock test 0


# Cosmétiques
execute in minisjeux_crea run function cosm:death_reaper
execute in minisjeux_crea as @a[scores={veut_desactiver=1..}] run function cosm:disable_particles
execute in minisjeux_crea run function cosm:ench_particle_cycle
execute in minisjeux_crea as @a[predicate=cosm:veut_particle_type] run function cosm:disable_type_particles
execute in minisjeux_crea as @a[predicate=cosm:veut_particle_weight] run function cosm:disable_weight_particles
execute in minisjeux_crea run function cosm:check_and_run_update_cosm
execute in minisjeux_crea as @a[scores={sort_cosm=1..}] run function cosm:sort_cosm
execute in minisjeux_crea as @a[scores={entre_cosm=1..}] run function cosm:entre_cosm
execute in minisjeux_crea as @a[x=2422.5,y=251.5,z=2136.5,distance=..1.5] unless score @s entre_cosm > 0 test run scoreboard players enable @s entre_cosm
