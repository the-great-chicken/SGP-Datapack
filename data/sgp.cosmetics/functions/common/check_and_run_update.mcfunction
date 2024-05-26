#> sgp.cosmetics:common/check_and_run_update
# 
# Checks if players clicked on a sign to change their cosmetics,
# and runs the appropriate function if so.

execute as @a[scores={sgp.veut_light=1..}] run function sgp.cosmetics:particles/update {particle:light, particule:"Légère", couleur:light_purple}
execute as @a[scores={sgp.veut_medium=1..}] run function sgp.cosmetics:particles/update {particle:medium, particule:Moyenne, couleur:dark_purple}
execute as @a[scores={sgp.veut_heavy=1..}] run function sgp.cosmetics:particles/update {particle:heavy, particule:Lourde, couleur:blue}
execute as @a[scores={sgp.veut_super_heavy=1..}] run function sgp.cosmetics:particles/update {particle:super_heavy, particule:"Super Lourde", couleur:dark_blue}
execute as @a[scores={sgp.veut_flame_crown=1..}] run function sgp.cosmetics:particles/update {particle:flame_crown, particule:"Couronne de Feu", couleur:gold}
execute as @a[scores={sgp.veut_cloud=1..}] run function sgp.cosmetics:particles/update {particle:cloud, particule:Nuage, couleur:white}
execute as @a[scores={sgp.veut_marine=1..}] run function sgp.cosmetics:particles/update {particle:marine, particule:Marine, couleur:blue}
execute as @a[scores={sgp.veut_smoke=1..}] run function sgp.cosmetics:particles/update {particle:smoke, particule:"Fumée", couleur:gray}
execute as @a[scores={sgp.veut_ench=1..}] run function sgp.cosmetics:particles/update {particle:ench, particule:Tranchant, couleur:aqua}

execute as @a[scores={sgp.veut_kill_disabled=1..}] unless score @s disabled_kill_unlocked matches 1 run scoreboard players set @s disabled_kill_unlocked 1 
execute as @a[scores={sgp.veut_kill_disabled=1..}] run function sgp.cosmetics:kill_effects/update {effect:disabled, effet:"Désactivé", couleur:white}
execute as @a[scores={sgp.veut_kill_anvil=1..}] run function sgp.cosmetics:kill_effects/update {effect:anvil, effet:Enclume, couleur:dark_gray}
execute as @a[scores={sgp.veut_kill_portal=1..}] run function sgp.cosmetics:kill_effects/update {effect:portal, effet:Portail, couleur:dark_purple}
execute as @a[scores={sgp.veut_kill_explosion=1..}] run function sgp.cosmetics:kill_effects/update {effect:explosion, effet:Explosion, couleur:gold}
execute as @a[scores={sgp.veut_kill_witch=1..}] run function sgp.cosmetics:kill_effects/update {effect:witch, effet:Magie, couleur:light_purple}
execute as @a[scores={sgp.veut_kill_hurt=1..}] run function sgp.cosmetics:kill_effects/update {effect:hurt, effet:"Blessé", couleur:dark_red}
execute as @a[scores={sgp.veut_kill_cloud=1..}] run function sgp.cosmetics:kill_effects/update {effect:cloud, effet:Nuage, couleur:gray}
execute as @a[scores={sgp.veut_kill_splash=1..}] run function sgp.cosmetics:kill_effects/update {effect:splash, effet:Splash, couleur:blue}
execute as @a[scores={sgp.veut_kill_firework=1..}] run function sgp.cosmetics:kill_effects/update {effect:firework, effet:"Feux d'artifice", couleur:red}
execute as @a[scores={sgp.veut_kill_random=1..}] run function sgp.cosmetics:kill_effects/update {effect:random, effet:"Aléatoire", couleur:green}