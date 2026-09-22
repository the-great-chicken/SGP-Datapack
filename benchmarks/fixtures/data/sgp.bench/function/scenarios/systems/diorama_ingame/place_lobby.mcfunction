#> sgp.bench:scenarios/systems/diorama_ingame/place_lobby
# Executed as one lobby actor: x -3.5, z 0.5 + slot, y 121, yaw -90 (east), pitch 8 (down).
team join sgpbenchdio @s
scoreboard players operation #diorama_slot sgp.bench = @s sgp.bench
scoreboard players operation #diorama_slot sgp.bench -= #diorama_lobby_first sgp.bench
scoreboard players operation #diorama_slot sgp.bench *= 1000 sgp.dummy
scoreboard players set @s bs.pos.x -3500
scoreboard players set @s bs.pos.y 121000
scoreboard players operation @s bs.pos.z = #diorama_slot sgp.bench
scoreboard players add @s bs.pos.z 500
scoreboard players set @s bs.rot.h -90000
scoreboard players set @s bs.rot.v 8000
function #bs.position:set_pos_and_rot {scale:0.001}
