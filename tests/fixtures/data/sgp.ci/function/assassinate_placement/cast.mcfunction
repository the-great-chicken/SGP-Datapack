#> sgp.ci:assassinate_placement/cast
# Use the target's position and horizontal facing, as the ability's trigger does.

execute as AssTarget at @s rotated ~ 0 run function sgp.kits:abilities/assassinate/check_tp_position
tag @e[distance=..24,type=ender_pearl] add sgp.ci.assassinate
tag @e[distance=..24,type=endermite] add sgp.ci.assassinate
