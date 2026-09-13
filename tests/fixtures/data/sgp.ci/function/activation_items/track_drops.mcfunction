#> sgp.ci:activation_items/track_drops
# Mark only each activation actor's fresh drop for cleanup; never claim unrelated world items.

execute as @a[tag=sgp.ci.activation_actor] at @s run function sgp.ci:activation_items/track_drop with entity @s
