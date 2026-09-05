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

# Allocate stable player ids before any subsystem records player-linked state.
execute as @a unless score @s sgp.id matches 1.. run function sgp.misc:player_id/allocate

# Expire actionbar segments before systems refresh the parts they still need.
function sgp.misc:actionbar/tick

# Keep every statistics collector synchronized with the shared major-event
# predicate before processing this tick's deaths or ability results.
function sgp.kits:stats_collector/tick

# Capture and batch genuine deaths before special modes consume sgp.just_died.
execute as @a[scores={sgp.just_died=1..}] run \
    function sgp.kits:stats_collector/on_real_death
execute as @a[tag=sgp.elo_touched] run \
    function sgp.kits:stats_collector/elo/apply_pending

# Consume delayed synthetic cleanup before a later event's death handler can.
execute as @a[scores={sgp.synthetic_death=1..,sgp.just_died=1..}] run \
    function sgp.misc:on_death


# Must be in this order
execute as @a[tag=sgp.in_game,scores={sgp.just_died=1..}] \
    run function #sgp.majeurs:events/death

execute if score #diorama_enabled sgp.dummy matches 1 \
    run function sgp.diorama:tick/main

execute as @a[tag=sgp.in_game,scores={sgp.just_died=1..}] run \
    function sgp.misc:on_death



# ---------- KITS ----------
function sgp.kits:kills_give/check

function sgp.kits:kit_tags/management

function sgp.kits:abilities/tick



# ---------- MISCELLANEOUS ----------

function minecraft:128_ticks_functions

execute as @a[tag=sgp.in_game,tag=!sgp.climbing,predicate=sgp.world:is_climbing] \
    run function sgp.world:climbing_boost/add
execute as @a[tag=sgp.climbing,predicate=!sgp.world:is_climbing] \
    run function sgp.world:climbing_boost/remove

execute as @a[tag=sgp.in_game,tag=!sgp.sliding_up,predicate=sgp.world:is_pressing_jump_next_to_honey] at @s \
    run function sgp.world:slide_honey_up/add
execute as @a[tag=sgp.sliding_up,predicate=!sgp.world:is_pressing_jump_next_to_honey] \
    run function sgp.world:slide_honey_up/remove

execute as @a[scores={sgp.share_item=1..}] run function sgp.mineurs:lootdrop/show_item/main

function sgp.misc:players_in_game/macro with storage sgp:data markers_lists.pvp_arena[0]

function sgp.misc:loop_as_entity/init {list_location:"markers_lists.lootdrop", command:"if block ~ ~ ~ trapped_chest run data modify block ~ ~ ~ LootTable set value 'sgp.misc:empty'"}

scoreboard players set @a sgp.ab.location 0
scoreboard players set @a sgp.ab.location_width 0

function sgp.misc:loop_as_entity/init {list_location:"markers_lists.location", command:"run function sgp.world:lieu/lieu_trouve with entity @s data"}

function sgp.misc:tab/tick

function sgp.misc:loop_as_entity/init {list_location:"markers_lists.teleporter", command:"run function sgp.world:teleporter/run"}

execute as @a[tag=sgp.in_game,scores={sgp.reward=1..}] \
    run function sgp.mineurs:bounty/reward/trigger

execute as @a[scores={sgp.anim_timer=1..}] at @s \
    run function sgp.diorama:scale_down_anim/step

# @r so that it doesn't cost so much: we don't need the enchants to be up-to-date all the time
# That means some players may get the piercing weapon only after a few seconds if unlucky
execute if score #mannequins_swing_enabled sgp.dummy matches 1 \
    as @r[tag=sgp.in_game] run function sgp.diorama:left_click/add_piercing_weapon

execute if score #mannequins_swing_enabled sgp.dummy matches 1 \
    as @a[tag=sgp.in_game] run function sgp.diorama:left_click/remove_piercing_weapon



# ---------- COSMETICS ----------
function sgp.cosmetics:tick



# ---------- MAJOR EVENTS ----------
function sgp.majeurs:tick
