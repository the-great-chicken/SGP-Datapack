#> sgp.misc:kd_buff_and_debuffs/damage_debuff
# 
# Give a gradually increasing reduction in damage the higher the kd of the player is

execute if score @s sgp.kd matches 200.. if score @s sgp.kd matches ..250 \
        run attribute @s minecraft:generic.attack_damage modifier add kd -0.1 add_multiplied_total

execute if score @s sgp.kd matches 250.. if score @s sgp.kd matches ..300 \
        run attribute @s minecraft:generic.attack_damage modifier add kd -0.2 add_multiplied_total

execute if score @s sgp.kd matches 300.. if score @s sgp.kd matches ..350 \
        run attribute @s minecraft:generic.attack_damage modifier add kd -0.3 add_multiplied_total

execute if score @s sgp.kd matches 350.. if score @s sgp.kd matches ..400 \
        run attribute @s minecraft:generic.attack_damage modifier add kd -0.4 add_multiplied_total

execute if score @s sgp.kd matches 400.. \
        run attribute @s minecraft:generic.attack_damage modifier add kd -0.5 add_multiplied_total