#> sgp.kits:misc/check_and_run
# 
# Checks if a player wants a kit, running the appropriate function

# Kits débloqués par défaut
execute as @a[scores={sgp.veut_combattant=1..}] run function sgp.kits:collection/combattant
scoreboard players enable @a[tag=sgp.combattant_voulu] sgp.veut_combattant
execute as @a[scores={sgp.veut_vindicateur=1..}] run function sgp.kits:collection/vindicateur
scoreboard players enable @a[tag=sgp.vindicateur_voulu] sgp.veut_vindicateur
execute as @a[scores={sgp.veut_archer=1..}] run function sgp.kits:collection/archer
scoreboard players enable @a[tag=sgp.archer_voulu] sgp.veut_archer

# Kits à trouver dans la map
execute as @a[scores={sgp.veut_eclaireur=1..}] run function sgp.kits:misc/check_and_give {kit:eclaireur, kit_color:aqua, hint:"Zone Noire", hint_color:dark_gray}
execute as @a[scores={sgp.veut_enderman=1..}] run function sgp.kits:misc/check_and_give {kit:enderman, kit_color:dark_purple, hint:"Zone Fun", hint_color:"#C0FF00"}
execute as @a[scores={sgp.veut_pigeon=1..}] run function sgp.kits:misc/check_and_give {kit:pigeon, kit_color:dark_gray, hint:Pigeonnier, hint_color:gray}
execute as @a[scores={sgp.veut_poseidon=1..}] run function sgp.kits:misc/check_and_give {kit:poseidon, kit_color:dark_aqua, hint:Temple, hint_color:dark_blue}
execute as @a[scores={sgp.veut_pyromane=1..}] run function sgp.kits:misc/check_and_give {kit:pyromane, kit_color:gold, hint:Grange, hint_color:gold}
execute as @a[scores={sgp.veut_roi=1..}] run function sgp.kits:misc/check_and_give {kit:roi, kit_color:yellow, hint:"King of the Ladder", hint_color:"#4A5D23"}
execute as @a[scores={sgp.veut_tank=1..}] run function sgp.kits:misc/check_and_give {kit:tank, kit_color:dark_blue, hint:Abri, hint_color:"#5A4022"}
execute as @a[scores={sgp.veut_cancer=1..}] run function sgp.kits:misc/check_and_give {kit:cancer, kit_color:dark_red, hint:Autel, hint_color:"#DFFFFD"}
execute as @a[scores={sgp.veut_alchimiste=1..}] run function sgp.kits:misc/check_and_give {kit:alchimiste, kit_color:light_purple, hint:"Salle de Réunion", hint_color:"#A55D33"}