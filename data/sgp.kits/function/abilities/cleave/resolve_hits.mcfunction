#> sgp.kits:abilities/cleave/resolve_hits
# Apply the sweep from the caster's position and facing.

tag @s add sgp.attacker
execute as @a[tag=sgp.in_game,tag=!sgp.peaceful,distance=0.1..5] at @s run function sgp.kits:abilities/cleave/check
tag @s remove sgp.attacker
