execute store result score #kit_id_victime test run scoreboard players get @s kit_id
function kits:reset_tags
scoreboard players set @s kills_give_1 0
scoreboard players set @s kills_give_2 0
scoreboard players set @s kills_give_3 0
function cosm:disable_triggers_cosm
scoreboard players set @s entre_kits 1
scoreboard players set @a death_reset_tags 0