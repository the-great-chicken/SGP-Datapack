function even_tick_functions

# Must be in this order
execute if predicate sgp.majeurs:pigeons/ongoing run function sgp.majeurs:pigeons/running

execute as @a[scores={death_reset_tags=1..}] run function sgp.misc:on_death

# Trigger Rewards
function sgp.world:reward/laby
execute as @a unless entity @s[tag=enderman] unless entity @s[tag=pigeon] unless entity @s[tag=eclaireur] unless entity @s[tag=cancer] unless entity @s[tag=archer] run function sgp.world:reward_jump_hardest
execute as @a unless entity @s[tag=enderman] unless entity @s[tag=pigeon] unless entity @s[tag=eclaireur] unless entity @s[tag=cancer] unless entity @s[tag=archer] run function sgp.world:reward_jump_diff_2


# Spawns
function sgp.spawns:check_and_execute_spawn
execute as @p[scores={spawn_random=1..}] run function sgp.spawns:random
execute as @a[scores={kits_vers_spawn=1..}] unless predicate sgp.majeurs:event_in_progress run function sgp.kits:misc/sort_salle
execute as @a[scores={kits_vers_spawn=1..}] if predicate sgp.majeurs:event_in_progress run function sgp.majeurs:common/kits_to_spawn
execute as @a[scores={spawn_vers_kits=1..}] run function sgp.kits:misc/entre_salle


# Kits
function sgp.kits:misc/check_and_run
function sgp.kits:unlocking/check_kit_unlock
execute as @p[scores={veut_random=1..}] run function sgp.kits:misc/random
function sgp.kits:kills_give/check
function sgp.kits:kits_tags/management
execute at @e[type=marker,name="accueil",limit=1] as @a[distance=..1.5] unless score @s entre_kits > 0 dummy run scoreboard players enable @s entre_kits
execute at @e[type=marker,name="accueil",limit=1] as @a[distance=0] run function sgp.kits:misc/sort_salle
execute as @a[scores={entre_kits=1..}] run function sgp.kits:misc/entre_salle
execute as @a[scores={sort_kits=1..}] unless predicate sgp.majeurs:event_in_progress run function sgp.kits:misc/sort_salle
execute as @a[scores={sort_kits=1..}] if predicate sgp.majeurs:event_in_progress run function sgp.majeurs:common/cannot_tp_to_lobby


# Miscellaneous
function sgp.world:run_lieux_trouves
function sgp.misc:kill_counter
function sgp.world:temple_teleporter
execute at @e[type=marker,name="Lootdrop"] if block ~ ~ ~ minecraft:trapped_chest run particle dust 1.000 0.800 0.100 2.5 ~ ~ ~ 0.3 40 0.3 10 30 force
execute as @e[x=2454,y=193,z=2191,dx=12,dy=0,dz=6] run damage @s 6 minecraft:hot_floor
execute if score #128_ticks_clock dummy matches 0 run function sgp.misc:kill_streaks_management
execute if score #128_ticks_clock dummy matches 0 as @a run function sgp.misc:kd_buff_and_debuffs
scoreboard players add #128_ticks_clock dummy 1
execute if score #128_ticks_clock dummy matches 128 run scoreboard players set #128_ticks_clock dummy 0


# Cosmétiques
function sgp.cosmetics:kill_effects/death_reaper
execute as @a[scores={veut_desactiver=1..}] run function sgp.cosmetics:particles/disable
function sgp.cosmetics:particles/ench_cycle
execute as @a[predicate=sgp.cosmetics:veut_particle_type] run function sgp.cosmetics:particles/disable_type
execute as @a[predicate=sgp.cosmetics:veut_particle_weight] run function sgp.cosmetics:particles/disable_weight
function sgp.cosmetics:common/check_and_run_update
execute as @a[scores={sort_cosm=1..}] run function sgp.cosmetics:misc/sort_cosm
execute as @a[scores={entre_cosm=1..}] run function sgp.cosmetics:misc/entre_cosm
execute at @e[type=marker,name="accueil",limit=1] as @a[distance=..1.5] unless score @s entre_cosm > 0 dummy run scoreboard players enable @s entre_cosm


# ------ Events Majeurs ------
# Protéger le Roi
execute if entity @a[scores={devenir_roi_bleu=1..}] run function sgp.majeurs:protect/devenir_roi_bleu
execute if entity @a[scores={devenir_roi_rouge=1..}] run function sgp.majeurs:protect/devenir_roi_rouge
execute if predicate sgp.majeurs:protect/ongoing run function sgp.majeurs:protect/running

# PCO
execute if predicate sgp.majeurs:pco/ongoing run function sgp.majeurs:pco/empower
execute if predicate sgp.majeurs:pco/ongoing run function sgp.majeurs:pco/check_death
execute if predicate sgp.majeurs:pco/ongoing run function sgp.majeurs:pco/running
execute if predicate sgp.majeurs:pco/ongoing run function sgp.majeurs:pco/add_cabane_time
execute if predicate sgp.majeurs:pco/ongoing run function sgp.majeurs:pco/dans_cabane

# Invasion
execute if predicate sgp.majeurs:invasion/ongoing run function sgp.majeurs:invasion/defenders_dying
execute if predicate sgp.majeurs:invasion/ongoing run function sgp.majeurs:invasion/running

# Chasse aux pigeons
execute as @a[scores={devenir_chasseur=1..}] run function sgp.majeurs:pigeons/devenir_chasseur
execute as @a[scores={devenir_pigeon=1..}] run function sgp.majeurs:pigeons/devenir_pigeon
execute if predicate sgp.majeurs:pigeons/ongoing run function sgp.majeurs:pigeons/timer