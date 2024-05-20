$tp @s $(x) $(y) $(z) $(pitch) $(yaw)
execute as @s run function spawns:disable_triggers
execute as @s run trigger spawn_vers_kits set 0
$scoreboard players set @s spawn_$(number) 0