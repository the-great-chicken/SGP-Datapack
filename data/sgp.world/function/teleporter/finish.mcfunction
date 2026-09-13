#> sgp.world:teleporter/finish
# {x, y, z, yaw, pitch}: complete the executing player's teleport and release their countdown.

$tp @s $(x) $(y) $(z) $(yaw) $(pitch)
execute at @s run particle minecraft:reverse_portal ~ ~1 ~ 0 0 0 1 200 normal
function sgp.world:teleporter/out_of_range
