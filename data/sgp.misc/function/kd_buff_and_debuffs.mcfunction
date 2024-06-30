#> sgp.misc:kd_buff_and_debuffs
# 
# Buff players who got low kd, debuff players who got high kd

scoreboard players operation @s sgp.kd = @s sgp.kills
scoreboard players operation @s sgp.kd *= 100 sgp.dummy
scoreboard players operation @s sgp.kd /= @s morts

execute unless predicate sgp.majeurs:event_in_progress if score @s sgp.kd matches ..50 if score @s morts matches 10.. run effect give @s minecraft:strength 7 0 true
execute if score @s sgp.kd matches 300.. if score @s sgp.kills matches 10.. run effect give @s minecraft:weakness 7 0 true
execute if score @s sgp.kd matches ..50 if score @s morts matches 10.. run effect give @s minecraft:regeneration 7 0 true