execute store result score #kit_id_victime dummy run scoreboard players get @s kit_id
function sgp.kits:kit_tags/reset
scoreboard players set @s kills_give_1 0
scoreboard players set @s kills_give_2 0
scoreboard players set @s kills_give_3 0
function sgp.cosmetics:common/disable_triggers
scoreboard players set @s entre_kits 1
scoreboard players set @s death_reset_tags 0