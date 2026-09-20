#> sgp.kits:abilities/rays/raycast_fast/cardinal/check_north

execute if score #raycast.pe bs.data matches ..0 run return 0
execute positioned ~-0.99 ~-0.01 ~-0.99 \
    unless entity @s[dx=0,dy=0,dz=-15.02] run return 0
execute positioned ~-0.01 ~-0.99 ~-0.99 \
    unless entity @s[dx=0,dy=0,dz=-15.02] run return 0

execute in minecraft:overworld positioned as @s as B5-0-0-0-1 \
    run function sgp.kits:abilities/rays/raycast_fast/cardinal/position_z with storage sgp:rays origin
scoreboard players operation #x bs.ctx += #raycast.rz bs.data
scoreboard players operation #w bs.ctx = @s bs.depth
scoreboard players operation #x bs.ctx += #w bs.ctx
scoreboard players operation #x bs.ctx *= -1 bs.const
scoreboard players operation #x bs.ctx /= 10000 bs.const
execute if score #x bs.ctx matches 0..16000 \
    run function sgp.kits:abilities/rays/raycast_fast/cardinal/hit
