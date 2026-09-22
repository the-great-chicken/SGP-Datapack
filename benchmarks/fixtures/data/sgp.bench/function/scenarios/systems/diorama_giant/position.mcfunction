#> sgp.bench:scenarios/systems/diorama_giant/position
# `{first: int}`
# Spread actors around the 10-by-10 outer perimeter, facing away from the buttons.

scoreboard players operation #diorama_slot sgp.bench = @s sgp.bench
$scoreboard players remove #diorama_slot sgp.bench $(first)
scoreboard players operation #diorama_slot sgp.bench *= #diorama_perimeter sgp.bench
scoreboard players operation #diorama_slot sgp.bench /= #diorama_players sgp.bench
scoreboard players operation #diorama_side sgp.bench = #diorama_slot sgp.bench
scoreboard players operation #diorama_side sgp.bench /= #diorama_edge sgp.bench
scoreboard players operation #diorama_slot sgp.bench %= #diorama_edge sgp.bench
scoreboard players remove #diorama_slot sgp.bench 3000

scoreboard players operation @s bs.pos.x = #diorama_slot sgp.bench
scoreboard players set @s bs.pos.y 121000
scoreboard players set @s bs.pos.z -3000
scoreboard players set @s bs.rot.h 180000
scoreboard players set @s bs.rot.v 0

execute if score #diorama_side sgp.bench matches 1 run scoreboard players set @s bs.pos.x 7000
execute if score #diorama_side sgp.bench matches 1 run scoreboard players operation @s bs.pos.z = #diorama_slot sgp.bench
execute if score #diorama_side sgp.bench matches 1 run scoreboard players set @s bs.rot.h -90000
execute if score #diorama_side sgp.bench matches 2 run scoreboard players set @s bs.pos.x 4000
execute if score #diorama_side sgp.bench matches 2 run scoreboard players operation @s bs.pos.x -= #diorama_slot sgp.bench
execute if score #diorama_side sgp.bench matches 2 run scoreboard players set @s bs.pos.z 7000
execute if score #diorama_side sgp.bench matches 2 run scoreboard players set @s bs.rot.h 0
execute if score #diorama_side sgp.bench matches 3 run scoreboard players set @s bs.pos.x -3000
execute if score #diorama_side sgp.bench matches 3 run scoreboard players set @s bs.pos.z 4000
execute if score #diorama_side sgp.bench matches 3 run scoreboard players operation @s bs.pos.z -= #diorama_slot sgp.bench
execute if score #diorama_side sgp.bench matches 3 run scoreboard players set @s bs.rot.h 90000
function #bs.position:set_pos_and_rot {scale:0.001}
