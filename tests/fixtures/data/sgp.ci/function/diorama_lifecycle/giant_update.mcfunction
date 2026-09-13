#> sgp.ci:diorama_lifecycle/giant_update
# Run the production giant-mannequin lifecycle check from the fixture model.

execute as @n[tag=sgp.ci.lifecycle_model,type=marker] at @s run function sgp.diorama:tick/check_for_giant_player with entity @s data
