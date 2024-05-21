function even_tick_functions

# Must be in this order
execute if predicate majeurs:pigeons_ongoing run function majeurs:pigeons_running

execute as @a[scores={death_reset_tags=1..}] run function world:on_death

# Trigger Rewards
function world:reward_laby
execute as @a unless entity @s[tag=enderman] unless entity @s[tag=pigeon] unless entity @s[tag=eclaireur] unless entity @s[tag=cancer] unless entity @s[tag=archer] run function world:reward_jump_hardest
execute as @a unless entity @s[tag=enderman] unless entity @s[tag=pigeon] unless entity @s[tag=eclaireur] unless entity @s[tag=cancer] unless entity @s[tag=archer] run function world:reward_jump_diff_2


# Spawns
function spawns:check_and_execute_spawn
execute as @p[scores={spawn_random=1..}] run function spawns:random
execute as @a[scores={kits_vers_spawn=1..}] unless predicate majeurs:event_in_progress run function kits:sort_salle_kits
execute as @a[scores={kits_vers_spawn=1..}] if predicate majeurs:event_in_progress run function majeurs:kits_to_spawn
execute as @a[scores={spawn_vers_kits=1..}] run function kits:entre_salle_kits


# Kits
function kits:check_and_run_kits
function kits:check_kit_unlock
execute as @p[scores={veut_random=1..}] run function kits:random
function kits:check_kills_give
function kits:tags_management
execute at @e[type=marker,name="accueil",limit=1] as @a[distance=..1.5] unless score @s entre_kits > 0 dummy run scoreboard players enable @s entre_kits
execute at @e[type=marker,name="accueil",limit=1] as @a[distance=0] run function kits:sort_salle_kits
execute as @a[scores={entre_kits=1..}] run function kits:entre_salle_kits
execute as @a[scores={sort_kits=1..}] unless predicate majeurs:event_in_progress run function kits:sort_salle_kits
execute as @a[scores={sort_kits=1..}] if predicate majeurs:event_in_progress run function majeurs:cannot_tp_to_lobby


# Miscellaneous
function world:run_lieux_trouves
function world:kill_counter
function world:temple_teleporter
execute at @e[type=marker,name="Lootdrop"] if block ~ ~ ~ minecraft:trapped_chest run particle dust 1.000 0.800 0.100 2.5 ~ ~ ~ 0.3 40 0.3 10 30 force
execute as @e[x=2454,y=193,z=2191,dx=12,dy=0,dz=6] run damage @s 6 minecraft:hot_floor
execute if score #128_ticks_clock dummy matches 0 run function world:kill_streaks_management
execute if score #128_ticks_clock dummy matches 0 as @a run function world:kd_buff_and_debuffs
scoreboard players add #128_ticks_clock dummy 1
execute if score #128_ticks_clock dummy matches 128 run scoreboard players set #128_ticks_clock dummy 0


# Cosmétiques
function cosm:death_reaper
execute as @a[scores={veut_desactiver=1..}] run function cosm:disable_particles
function cosm:ench_particle_cycle
execute as @a[predicate=cosm:veut_particle_type] run function cosm:disable_type_particles
execute as @a[predicate=cosm:veut_particle_weight] run function cosm:disable_weight_particles
function cosm:check_and_run_update_cosm
execute as @a[scores={sort_cosm=1..}] run function cosm:sort_cosm
execute as @a[scores={entre_cosm=1..}] run function cosm:entre_cosm
execute at @e[type=marker,name="accueil",limit=1] as @a[distance=..1.5] unless score @s entre_cosm > 0 dummy run scoreboard players enable @s entre_cosm


# ------ Events Majeurs ------
# Protéger le Roi
execute if entity @a[scores={devenir_roi_bleu=1..}] run function majeurs:protect_devenir_roi_bleu
execute if entity @a[scores={devenir_roi_rouge=1..}] run function majeurs:protect_devenir_roi_rouge
execute if predicate majeurs:protect_ongoing run function majeurs:protect_running

# PCO
execute if predicate majeurs:pco_ongoing run function majeurs_pco:empower
execute if predicate majeurs:pco_ongoing run function majeurs_pco:check_death
execute if predicate majeurs:pco_ongoing run function majeurs_pco:running
execute if predicate majeurs:pco_ongoing run function majeurs_pco:add_cabane_time
execute if predicate majeurs:pco_ongoing run function majeurs_pco:dans_cabane

# Invasion
execute if predicate majeurs:invasion_ongoing run function majeurs:invasion_defenders_dying
execute if predicate majeurs:invasion_ongoing run function majeurs:invasion_running

# Chasse aux pigeons
execute as @a[scores={devenir_chasseur=1..}] run function majeurs:pigeons_devenir_chasseur
execute as @a[scores={devenir_pigeon=1..}] run function majeurs:pigeons_devenir_pigeon
execute if predicate majeurs:pigeons_ongoing run function majeurs:pigeons_timer