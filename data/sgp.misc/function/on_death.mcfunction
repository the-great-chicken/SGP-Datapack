#> sgp.misc:on_death
# 
# Executed when a players dies: resets things,...

execute store result score #kit_id_victime sgp.dummy run scoreboard players get @s sgp.kit_id
function sgp.kits:kit_tags/reset
scoreboard players set @s sgp.kills_give_1 0
scoreboard players set @s sgp.kills_give_2 0
scoreboard players set @s sgp.kills_give_3 0
function sgp.cosmetics:common/disable_triggers
function sgp.kits:misc/entre_salle
scoreboard players set @s sgp.death_reset_tags 0

function sgp.kits:clear