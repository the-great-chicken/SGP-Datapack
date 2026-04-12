#> sgp.kits:abilities/assassinate/trigger

# Honestly idk what's better between the tag check multiple times here + advancement revocation
# Or to check the player's nbt in the advancement for the tag.
execute if entity @s[tag=sgp.assassin] run tag @s add sgp.assassin_triggered

execute if entity @s[tag=sgp.assassin] run execute on attacker at @s rotated as @s run tp @a[tag=sgp.assassin_triggered,limit=1] ^ ^ ^-2

execute if entity @s[tag=sgp.assassin] run tag @s remove sgp.assassin_triggered
advancement revoke @s only sgp.kits:assassinate

execute if entity @s[tag=sgp.assassin] run function sgp.kits:abilities/assassinate/disable