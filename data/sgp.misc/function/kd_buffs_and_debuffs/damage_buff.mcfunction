#> sgp.misc:kd_buffs_and_debuffs/damage_buff
# 
# Give a gradually increasing increase in damage the lower the kd of the player is

# Keep these ranges aligned with sgp.kits:kd_projectile_scaling.
execute if score @s sgp.kd matches 60..80 \
        run attribute @s minecraft:attack_damage modifier add kd 0.1 add_multiplied_total

execute if score @s sgp.kd matches 45..59 \
        run attribute @s minecraft:attack_damage modifier add kd 0.2 add_multiplied_total

execute if score @s sgp.kd matches 35..44 \
        run attribute @s minecraft:attack_damage modifier add kd 0.3 add_multiplied_total

execute if score @s sgp.kd matches ..34 \
        run attribute @s minecraft:attack_damage modifier add kd 0.4 add_multiplied_total
