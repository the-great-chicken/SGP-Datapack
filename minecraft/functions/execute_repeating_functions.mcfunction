execute in minisjeux_crea run function world:reward_laby
execute in minisjeux_crea as @a unless entity @s[tag=enderman] unless entity @s[tag=pigeon] unless entity @s[tag=eclaireur] unless entity @s[tag=cancer] unless entity @s[tag=archer] run function world:reward_jump_hardest
execute in minisjeux_crea as @a unless entity @s[tag=enderman] unless entity @s[tag=pigeon] unless entity @s[tag=eclaireur] unless entity @s[tag=cancer] unless entity @s[tag=archer] run function world:reward_jump_diff_2
execute in minisjeux_crea run function spawns:check_and_execute_spawn
execute in minisjeux_crea as @p[scores={spawn_random=1..}] run function spawns:random
execute in minisjeux_crea run function kits:check_and_run_kits
execute in minisjeux_crea run function kits:check_kit_unlock
execute in minisjeux_crea as @p[scores={veut_random=1..}] run function kits:random
execute in minisjeux_crea run function kits:check_kills_give
execute in minisjeux_crea run function world:run_lieux_trouves
execute in minisjeux_crea run function cosm:ench_particle_cycle
execute in minisjeux_crea run function world:kill_counter