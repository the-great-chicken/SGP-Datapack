#> sgp.kits:abilities/rays/raycast_fast/cardinal/hit
#
# Apply one confirmed clear-cardinal hit; the caller stops once the piercing budget is spent.

scoreboard players remove #raycast.pe bs.data 1
execute at @s run function sgp.kits:abilities/rays/get_damaged
