#> sgp.misc:kd_buffs_and_debuffs/main
# 
# Buff players who got low kd, debuff players who got high kd

scoreboard players operation @s sgp.kd = @s sgp.kills
scoreboard players operation @s sgp.kd *= 100 sgp.dummy
# With no deaths yet, keep kills * 100 (equivalent to a divisor of one).
execute if score @s sgp.morts matches 1.. run scoreboard players operation @s sgp.kd /= @s sgp.morts

attribute @s attack_damage modifier remove kd

execute if score @s sgp.kills matches 10.. \
    if score @s sgp.kd matches 100.. \
        run function sgp.misc:kd_buffs_and_debuffs/damage_debuff

execute if score @s sgp.morts matches 10.. \
    if score @s sgp.kd matches ..100 \
        run function sgp.misc:kd_buffs_and_debuffs/damage_buff
