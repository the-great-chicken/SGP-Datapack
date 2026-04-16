#> sgp.kits:abilities/smoke_grenade/on_ground

scoreboard players operation #current_smoke sgp.id = @s sgp.id

execute as @a unless score @s sgp.id = #current_smoke sgp.id run particle minecraft:dust{scale:4f,color:[0.3f, 0.3f, 0.3f]} ~ ~1 ~ 2 2 2 0 2000 normal @s
particle minecraft:dust{scale:4f,color:[0.3f, 0.3f, 0.3f]} ~ ~1 ~ 2 2 2 0 250 force
kill @s