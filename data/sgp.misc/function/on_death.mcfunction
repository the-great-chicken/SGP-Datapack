#> sgp.misc:on_death
# 
# Executed when a players dies: resets things,...

execute store result score #kit_id_victime sgp.dummy run scoreboard players get @s sgp.kit_id
scoreboard players reset @s sgp.kit_id

# Reset ability
scoreboard players set @s sgp.duration_ability 1
execute at @s run function sgp.kits:abilities/route_tick
scoreboard players set @s sgp.cooldown_ability 0
scoreboard players set @s sgp.cooldown_water_trident 0

function sgp.kits:kit_tags/reset
scoreboard players set @s sgp.kills_give_1 0
scoreboard players set @s sgp.kills_give_2 0
scoreboard players set @s sgp.kills_give_3 0
scoreboard players set @s sgp.just_died 0

function sgp.kits:clear

scoreboard players operation $link.to bs.in = @s bs.id
tag @s add sgp.diorama_death_cleanup
function sgp.misc:loop_as_entity/init {list_location:"markers_lists.playable_map", command:"run function sgp.misc:diorama/remove_mannequins with entity @s data"}
tag @s remove sgp.diorama_death_cleanup

function sgp.mineurs:bounty/reward/reset
execute if entity @s[tag=sgp.wanted] run function sgp.mineurs:bounty/leave_wanted