#> sgp.kits:abilities/tnt/on_hit
# Executed as the hitter by Bookshelf. Bat the clicked interaction's linked charge using the hitter's aim.

scoreboard players operation #batted_tnt bs.in = @n[tag=bs.interaction.target,type=interaction] bs.link.to
execute at @s rotated as @s as @e[tag=sgp.tnt,distance=..5,type=tnt] if score @s bs.id = #batted_tnt bs.in run function sgp.kits:abilities/tnt/apply_kb
