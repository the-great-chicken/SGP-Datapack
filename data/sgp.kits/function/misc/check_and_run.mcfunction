#> sgp.kits:misc/check_and_run
# 
# Checks if a player wants a kit, running the appropriate function

# Kits débloqués par défaut
execute as @a[scores={sgp.veut_combattant=1..}] run function sgp.kits:give {kit:combattant}
scoreboard players enable @a[tag=sgp.combattant_voulu] sgp.veut_combattant
execute as @a[scores={sgp.veut_vindicateur=1..}] run function sgp.kits:give {kit:vindicateur}
scoreboard players enable @a[tag=sgp.vindicateur_voulu] sgp.veut_vindicateur
execute as @a[scores={sgp.veut_archer=1..}] run function sgp.kits:give {kit:archer}
scoreboard players enable @a[tag=sgp.archer_voulu] sgp.veut_archer

execute as @a[scores={sgp.veut_peaceful=1..}] run function sgp.kits:give {kit:peaceful}
scoreboard players enable @a[tag=sgp.peaceful_voulu] sgp.veut_peaceful

# Kits à trouver dans la map
execute as @a[scores={sgp.veut_eclaireur=1..}] run function sgp.kits:misc/check_and_give with storage sgp:kits eclaireur
execute as @a[scores={sgp.veut_enderman=1..}] run function sgp.kits:misc/check_and_give with storage sgp:kits enderman
execute as @a[scores={sgp.veut_pigeon=1..}] run function sgp.kits:misc/check_and_give with storage sgp:kits pigeon
execute as @a[scores={sgp.veut_poseidon=1..}] run function sgp.kits:misc/check_and_give with storage sgp:kits poseidon
execute as @a[scores={sgp.veut_pyromane=1..}] run function sgp.kits:misc/check_and_give with storage sgp:kits pyromane
execute as @a[scores={sgp.veut_tank=1..}] run function sgp.kits:misc/check_and_give with storage sgp:kits tank
execute as @a[scores={sgp.veut_alchimiste=1..}] run function sgp.kits:misc/check_and_give with storage sgp:kits alchimiste