#> sgp.misc:kd_buffs_and_debuffs/damage_debuff
# 
# Give a gradually increasing reduction in damage the higher the kd of the player is

# If you change the values, remember to also change them in the sgp.kits:kd_projectile_scaling enchantment!
execute if score @s sgp.kd matches 200..249 \
        run attribute @s minecraft:attack_damage modifier add kd -0.1 add_multiplied_total

execute if score @s sgp.kd matches 250..299 \
        run attribute @s minecraft:attack_damage modifier add kd -0.2 add_multiplied_total

execute if score @s sgp.kd matches 300..349 \
        run attribute @s minecraft:attack_damage modifier add kd -0.3 add_multiplied_total

execute if score @s sgp.kd matches 350..399 \
        run attribute @s minecraft:attack_damage modifier add kd -0.4 add_multiplied_total

execute if score @s sgp.kd matches 400.. \
        run attribute @s minecraft:attack_damage modifier add kd -0.5 add_multiplied_total
