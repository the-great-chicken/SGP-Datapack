#> sgp.misc:kd_buff_and_debuffs/damage_buff
# 
# Give a gradually increasing increase in damage the lower the kd of the player is

execute if score @s sgp.kd matches 60.. if score @s sgp.kd matches ..80 \
        run attribute @s minecraft:generic.attack_damage modifier add kd 0.1 add_multiplied_total

execute if score @s sgp.kd matches 45.. if score @s sgp.kd matches ..60 \
        run attribute @s minecraft:generic.attack_damage modifier add kd 0.2 add_multiplied_total

execute if score @s sgp.kd matches 35.. if score @s sgp.kd matches ..45 \
        run attribute @s minecraft:generic.attack_damage modifier add kd 0.3 add_multiplied_total

execute if score @s sgp.kd matches ..35 \
        run attribute @s minecraft:generic.attack_damage modifier add kd 0.4 add_multiplied_total