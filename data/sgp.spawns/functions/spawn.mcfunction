#> sgp.spawns:spawn
# `{x: int, y: int, z: int, pitch: int -180 to 180, yaw: int -180 to 180, number: int}`
# 
# Tp the player to the spawn

$tp @s $(x) $(y) $(z) $(pitch) $(yaw)
execute as @s run function sgp.spawns:disable_triggers
execute as @s run trigger sgp.spawn_vers_kits set 0
$scoreboard players set @s sgp.spawn_$(number) 0