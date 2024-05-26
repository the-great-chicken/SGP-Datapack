#> sgp.kits:kit_tags/management
# 
# Function ran regularly that manages kits tags like <kit>, <kit>_voulu, ...
#
# Also resets the kills_give scoreboards when they should, or sets them to
# a certain value when a specific kit is chosen

execute as @a[scores={sgp.reset_tags=1}] run function sgp.kits:kit_tags/reset
function sgp.kits:kit_tags/voulu
scoreboard players set @a[scores={sgp.reset_tags=1}] sgp.kills_give_1 0
scoreboard players set @a[scores={sgp.reset_tags=1}] sgp.kills_give_2 0
scoreboard players set @a[scores={sgp.reset_tags=1}] sgp.kills_give_3 0
scoreboard players set @a[scores={sgp.reset_tags=1}] sgp.reset_tags 0
scoreboard players set @a[tag=poseidon_a_setup_egapp] sgp.kills_give_2 3
tag @a[tag=poseidon_a_setup_egapp] remove poseidon_a_setup_egapp
scoreboard players set @a[tag=vindicateur_a_setup_egapp] sgp.kills_give_2 4
tag @a[tag=vindicateur_a_setup_egapp] remove vindicateur_a_setup_egapp