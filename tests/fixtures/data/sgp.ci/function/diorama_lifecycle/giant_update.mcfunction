#> sgp.ci:diorama_lifecycle/giant_update
execute as @n[tag=sgp.ci.lifecycle_model,type=marker] at @s run function sgp.diorama:tick/check_for_giant_player with entity @s data
