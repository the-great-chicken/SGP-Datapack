#> minecraft:execute_repeating_functions
# 
# Executes functions at each game tick


# one game tick out of 2
execute if score #even_tick sgp.dummy matches 0 run function even_tick_functions
scoreboard players add #even_tick sgp.dummy 1
execute if score #even_tick sgp.dummy matches 2.. run scoreboard players set #even_tick sgp.dummy 0

# one game tick out of 20
execute if score #20_ticks sgp.dummy matches 0 run function 20_ticks_functions
scoreboard players add #20_ticks sgp.dummy 1
execute if score #20_ticks sgp.dummy matches 10.. run scoreboard players set #20_ticks sgp.dummy 0


# Must be in this order
execute if entity @a[predicate=sgp.majeurs:pigeons/ongoing] run \
    function sgp.majeurs:pigeons/running

execute as @a[tag=sgp.in_game,scores={sgp.death_reset_tags=1..}] \
    if entity @a[predicate=sgp.majeurs:hide_and_seek/ongoing] \
        run function sgp.majeurs:hide_and_seek/delay_death

execute as @a[tag=sgp.in_game,scores={sgp.death_reset_tags=1..}] run \
    function sgp.misc:on_death




# ---------- TRIGGER REWARDS ----------
execute as @a[tag=sgp.in_game] \
    unless entity @s[tag=sgp.enderman] \
    unless entity @s[tag=sgp.pigeon] \
    unless entity @s[tag=sgp.eclaireur] \
    unless entity @s[tag=sgp.cancer] \
    unless entity @s[tag=sgp.archer] run \
        function sgp.world:reward/parkour_rewards

execute as @a[tag=sgp.in_game] unless score @s sgp.reward matches 0 run function sgp.mineurs:bounty/reward/trigger


# ---------- SPAWNS ----------
execute as @e[type=marker,tag=sgp.marker,name="spawn"] \
    run function sgp.spawns:check_and_execute_spawn with entity @s data

execute as @a[scores={sgp.spawn_random=1..}] run \
    function sgp.spawns:random

execute unless entity @a[predicate=sgp.majeurs:event_in_progress] \
    as @a[scores={sgp.kits_vers_spawn=1..}] run \
        function sgp.kits:misc/sort_salle

execute if entity @a[predicate=sgp.majeurs:event_in_progress] \
    as @a[scores={sgp.kits_vers_spawn=1..}] run \
        function sgp.majeurs:common/kits_to_spawn

execute as @a[scores={sgp.spawn_vers_kits=1..}] run \
    function sgp.kits:misc/entre_salle



# ---------- KITS ----------
function sgp.kits:misc/check_and_run

function sgp.kits:unlocking/check_kit_unlock

execute as @p[scores={sgp.veut_random=1..}] run \
    function sgp.kits:misc/random

function sgp.kits:kills_give/check

function sgp.kits:kit_tags/management

execute at @e[type=marker,tag=sgp.marker,name="accueil",limit=1] as @a[distance=..1.5] \
    unless score @s sgp.entre_kits matches 1.. run \
        scoreboard players enable @s sgp.entre_kits

execute at @e[type=marker,tag=sgp.marker,name="accueil",limit=1] as @a[distance=0] run \
    function sgp.kits:misc/sort_salle

execute as @a[scores={sgp.entre_kits=1..}] run \
    function sgp.kits:misc/entre_salle

execute unless entity @a[predicate=sgp.majeurs:event_in_progress] \
    as @a[scores={sgp.sort_kits=1..}] run \
        function sgp.kits:misc/sort_salle

execute if entity @a[predicate=sgp.majeurs:event_in_progress] \
    as @a[scores={sgp.sort_kits=1..}] run \
        function sgp.majeurs:common/cannot_tp_to_lobby

execute if score #52_ticks_clock sgp.dummy matches 0 run \
    function sgp.kits:kit_tags/prefixes_check

scoreboard players add #52_ticks_clock sgp.dummy 1

execute if score #52_ticks_clock sgp.dummy matches 52.. run \
    scoreboard players set #52_ticks_clock sgp.dummy 0



# ---------- MISCELLANEOUS ----------
function sgp.misc:kill_counter

execute as @e[type=marker,tag=sgp.marker,name="teleporter"] at @s \
    run function sgp.world:teleporter/run

execute at @e[type=marker,tag=sgp.marker,name="Lootdrop"] \
    if block ~ ~ ~ minecraft:trapped_chest run \
        particle dust{color:[1.0, 0.8, 0.1],scale:2.5} ~ ~ ~ 0.3 40 0.3 10 30 force

execute if score #reflexes_ticks sgp.timer matches 1..99 \
    run function sgp.mineurs:reflexes/running

execute if score #128_ticks_clock sgp.dummy matches 0 \
    unless entity @a[predicate=sgp.majeurs:event_in_progress] \
        run function sgp.misc:kill_streaks_management

execute if score #128_ticks_clock sgp.dummy matches 0 as @a[tag=sgp.in_game] \
    unless entity @a[predicate=sgp.majeurs:event_in_progress] \
        run function sgp.misc:kd_buff_and_debuffs

scoreboard players add #128_ticks_clock sgp.dummy 1

execute if score #128_ticks_clock sgp.dummy matches 128 \
    run scoreboard players set #128_ticks_clock sgp.dummy 0

execute as @a[tag=sgp.in_game] run function sgp.world:climbing_boost



# ---------- COSMETICS ----------
execute as @a[scores={sgp.veut_desactiver=1..}] run \
    function sgp.cosmetics:particles/disable

function sgp.cosmetics:particles/individual/ench_cycle
function sgp.cosmetics:particles/individual/flame_crown_cycle
function sgp.cosmetics:particles/individual/smoke_spawn
function sgp.cosmetics:particles/individual/cloud_spawn
function sgp.cosmetics:particles/individual/marine_spawn

execute as @a[predicate=sgp.cosmetics:veut_particle_type] run \
    function sgp.cosmetics:particles/disable_type

execute as @a[predicate=sgp.cosmetics:veut_particle_weight] run \
    function sgp.cosmetics:particles/disable_weight

function sgp.cosmetics:common/check_and_run_update

execute as @a[scores={sgp.sort_cosm=1..}] run \
    function sgp.cosmetics:misc/sort_cosm

execute as @a[scores={sgp.entre_cosm=1..}] run \
    function sgp.cosmetics:misc/entre_cosm

execute at @e[type=marker,tag=sgp.marker,name="accueil",limit=1] as @a[distance=..1.5] \
    unless score @s sgp.entre_cosm matches 1.. run \
        scoreboard players enable @s sgp.entre_cosm



# ---------- MAJOR EVENTS ----------
# Protéger le Roi
execute as @a[scores={sgp.devenir_roi_bleu=1..}] run \
    function sgp.majeurs:protect/devenir_roi {side:bleu, team:bleue, name:Bleu, color:dark_blue}

execute as @a[scores={sgp.devenir_roi_rouge=1..}] run \
    function sgp.majeurs:protect/devenir_roi {side:rouge, team:rouge, name:Rouge, color:dark_red}

execute if entity @a[predicate=sgp.majeurs:protect/ongoing] run \
    function sgp.majeurs:protect/running



# PCO
execute as @r[tag=sgp.in_game] if predicate sgp.majeurs:pco/ongoing run function sgp.majeurs:pco/running



# Invasion
execute if entity @a[predicate=sgp.majeurs:invasion/ongoing] run function sgp.majeurs:invasion/defenders_dying
execute if entity @a[predicate=sgp.majeurs:invasion/ongoing] run function sgp.majeurs:invasion/running



# Chasse aux pigeons
execute as @a[scores={sgp.devenir_chasseur=1..}] run \
    function sgp.majeurs:pigeons/devenir_chasseur

execute as @a[scores={sgp.devenir_pigeon=1..}] run \
    function sgp.majeurs:pigeons/devenir_pigeon

execute if entity @a[predicate=sgp.majeurs:pigeons/ongoing] run \
    function sgp.majeurs:pigeons/timer