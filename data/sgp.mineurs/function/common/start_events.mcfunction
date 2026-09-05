#> sgp.mineurs:common/start_events

scoreboard players operation #last_event_1 sgp.dummy = #random_event_roll_1 sgp.dummy
scoreboard players operation #last_event_2 sgp.dummy = #random_event_roll_2 sgp.dummy
scoreboard players operation #last_event_3 sgp.dummy = #random_event_roll_3 sgp.dummy
scoreboard players operation #last_nbr_events sgp.dummy = #random_nbr_events sgp.dummy

# Randomly choose the number of events for this round
data modify storage bs:in random.weighted_choice.options set value [1, 2, 3]
data modify storage bs:in random.weighted_choice.weights set value [11, 3, 1]
function #bs.random:weighted_choice
execute store result score #random_nbr_events sgp.dummy run data get storage bs:out random.weighted_choice

# Choose and start the different events to run
function sgp.mineurs:common/choose_event {nbr:1}
execute if score #random_nbr_events sgp.dummy matches 2.. \
    run function sgp.mineurs:common/choose_event {nbr:2}
execute if score #random_nbr_events sgp.dummy matches 3.. \
    run function sgp.mineurs:common/choose_event {nbr:3}

# Override the title if multiple events at the same time
execute if score #random_nbr_events sgp.dummy matches 2.. \
    run function sgp.mineurs:common/announce_combo

execute at @e[tag=sgp.marker,name="pvp_arena",limit=1,type=marker] \
    run playsound minecraft:entity.experience_orb.pickup master @a[tag=sgp.in_game] ~ ~ ~ 100

function sgp.mineurs:common/roll_time_event

scoreboard players set #events_mineurs_seconds sgp.timer 0
