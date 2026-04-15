#> sgp.kits:abilities/assassinate/rotate_delayed

execute as @a[tag=sgp.assassin_triggered] at @s on attacker run rotate @a[tag=sgp.assassin_triggered,distance=..0.1,limit=1] facing entity @s feet
tag @a[tag=sgp.assassin_triggered] remove sgp.assassin_triggered