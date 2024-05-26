$tp @s $(x) $(y) $(z) $(pitch) $(yaw)
execute as @s run function sgp.spawns:disable_triggers
execute as @s run trigger sgp.spawn_vers_kits set 0
$scoreboard players set @s sgp.spawn_$(number) 0