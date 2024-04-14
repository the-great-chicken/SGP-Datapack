execute as @a[scores={veut_light=1..}] run function cosm:update_particles {particle:light,particule:"Légère",couleur:light_purple}
execute as @a[scores={veut_medium=1..}] run function cosm:update_particles {particle:medium,particule:Moyenne,couleur:dark_purple}
execute as @a[scores={veut_heavy=1..}] run function cosm:update_particles {particle:heavy,particule:Lourde,couleur:blue}
execute as @a[scores={veut_super_heavy=1..}] run function cosm:update_particles {particle:super_heavy,particule:"Super Lourde",couleur:dark_blue}
execute as @a[scores={veut_flame_crown=1..}] run function cosm:update_particles {particle:flame_crown,particule:"Couronne de Feu",couleur:gold}
execute as @a[scores={veut_cloud=1..}] run function cosm:update_particles {particle:cloud,particule:Nuage,couleur:white}
execute as @a[scores={veut_marine=1..}] run function cosm:update_particles {particle:marine,particule:Marine,couleur:blue}
execute as @a[scores={veut_smoke=1..}] run function cosm:update_particles {particle:smoke,particule:"Fumée",couleur:gray}
execute as @a[scores={veut_ench=1..}] run function cosm:update_particles {particle:ench,particule:Tranchant,couleur:aqua}

execute as @a[scores={veut_kill_disabled=1..}] unless score @s disabled_kill_unlocked matches 1 run scoreboard players set @s disabled_kill_unlocked 1 
execute as @a[scores={veut_kill_disabled=1..}] run function cosm:update_death_effect {effect:disabled,effet:"Désactivé",couleur:white}
execute as @a[scores={veut_kill_anvil=1..}] run function cosm:update_death_effect {effect:anvil,effet:Enclume,couleur:dark_gray}
execute as @a[scores={veut_kill_portal=1..}] run function cosm:update_death_effect {effect:portal,effet:Portail,couleur:dark_purple}
execute as @a[scores={veut_kill_explosion=1..}] run function cosm:update_death_effect {effect:explosion,effet:Explosion,couleur:gold}
execute as @a[scores={veut_kill_witch=1..}] run function cosm:update_death_effect {effect:witch,effet:Magie,couleur:light_purple}
execute as @a[scores={veut_kill_hurt=1..}] run function cosm:update_death_effect {effect:hurt,effet:"Blessé",couleur:dark_red}
execute as @a[scores={veut_kill_cloud=1..}] run function cosm:update_death_effect {effect:cloud,effet:Nuage,couleur:gray}
execute as @a[scores={veut_kill_splash=1..}] run function cosm:update_death_effect {effect:splash,effet:Splash,couleur:blue}
execute as @a[scores={veut_kill_firework=1..}] run function cosm:update_death_effect {effect:firework,effet:"Feux d'artifice",couleur:red}
execute as @a[scores={veut_kill_random=1..}] run function cosm:update_death_effect {effect:random,effet:"Aléatoire",couleur:green}