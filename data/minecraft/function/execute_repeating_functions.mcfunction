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



# ---------- KITS ----------
function sgp.kits:unlocking/check_kit_unlock

function sgp.kits:kills_give/check

function sgp.kits:kit_tags/management

# This is the most frequent we can do luckperms prefixes update
execute if score #52_ticks_clock sgp.dummy matches 0 run \
    function sgp.kits:kit_tags/prefixes_check

scoreboard players add #52_ticks_clock sgp.dummy 1

execute if score #52_ticks_clock sgp.dummy matches 52.. run \
    scoreboard players set #52_ticks_clock sgp.dummy 0

function sgp.kits:abilities/tick


# ---------- MISCELLANEOUS ----------
function sgp.misc:kill_counter

execute as @e[type=marker,tag=sgp.marker,name="teleporter"] at @s \
    run function sgp.world:teleporter/run

execute if score #reflexes_ticks sgp.timer matches 1..99 \
    run function sgp.mineurs:reflexes/running

function sgp.misc:128_ticks_functions


execute as @a[tag=sgp.in_game,tag=!sgp.climbing,predicate=sgp.world:is_climbing] \
    run function sgp.world:climbing_boost/add
execute as @a[tag=sgp.climbing,predicate=!sgp.world:is_climbing] \
    run function sgp.world:climbing_boost/remove

execute as @a[tag=sgp.in_game,tag=!sgp.sliding_up,predicate=sgp.world:is_pressing_jump_next_to_honey] at @s \
    run function sgp.world:slide_honey_up/add
execute as @a[tag=sgp.sliding_up,predicate=!sgp.world:is_pressing_jump_next_to_honey] \
    run function sgp.world:slide_honey_up/remove

execute as @a[scores={sgp.share_item=1..}] run function sgp.mineurs:lootdrop/show_item/main



# ---------- COSMETICS ----------
function sgp.cosmetics:tick



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