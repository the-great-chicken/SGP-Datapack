#> sgp.kits:abilities/rays/raycast_fast/cardinal/hit
#
# Apply one confirmed clear-cardinal hit while respecting Rays entity piercing.

execute if score #raycast.pe bs.data matches ..0 run return 0
scoreboard players remove #raycast.pe bs.data 1
scoreboard players operation $raycast.piercing bs.lambda = #raycast.pe bs.data
execute at @s run function sgp.kits:abilities/rays/get_damaged
scoreboard players operation #raycast.pe bs.data = $raycast.piercing bs.lambda
