#> sgp.misc:second

execute if score #timed_events_active sgp.dummy matches 1.. run function sgp.mineurs:common/timed_event/tick

execute as @a[tag=sgp.in_game] run experience add @s -1 levels
scoreboard players remove #second sgp.timer 1
execute if score #second sgp.timer matches 1.. run return run schedule function sgp.misc:second 1s

# Keep the shared clock alive across a transition to the next timed minor event.
execute if score #timed_events_active sgp.dummy matches 2.. run schedule function sgp.misc:second 1s

execute as @a[tag=sgp.in_game] run experience set @s 0 levels
execute as @a[tag=sgp.in_game] run experience set @s 0 points
