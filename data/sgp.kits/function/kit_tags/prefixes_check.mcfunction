# We don't use macros as CommandAPI doesn't support macros yet

execute if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.alchimiste] run tag @r[scores={sgp.kit_prefix_set=0},tag=sgp.alchimiste] add sgp.adding_prefix
execute if entity @a[tag=sgp.adding_prefix] run scoreboard players set @a[tag=sgp.adding_prefix,limit=1] sgp.kit_prefix_set 1
execute if entity @a[tag=sgp.adding_prefix] run luckperms user @a[tag=sgp.adding_prefix,limit=1] parent settrack kit alchimiste
execute if entity @a[tag=sgp.adding_prefix] run return run tag @a[tag=sgp.adding_prefix] remove sgp.adding_prefix

execute if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.archer] run tag @r[scores={sgp.kit_prefix_set=0},tag=sgp.archer] add sgp.adding_prefix
execute if entity @a[tag=sgp.adding_prefix] run scoreboard players set @a[tag=sgp.adding_prefix,limit=1] sgp.kit_prefix_set 1
execute if entity @a[tag=sgp.adding_prefix] run luckperms user @a[tag=sgp.adding_prefix,limit=1] parent settrack kit archer
execute if entity @a[tag=sgp.adding_prefix] run return run tag @a[tag=sgp.adding_prefix] remove sgp.adding_prefix

execute if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.cancer] run tag @r[scores={sgp.kit_prefix_set=0},tag=sgp.cancer] add sgp.adding_prefix
execute if entity @a[tag=sgp.adding_prefix] run scoreboard players set @a[tag=sgp.adding_prefix,limit=1] sgp.kit_prefix_set 1
execute if entity @a[tag=sgp.adding_prefix] run luckperms user @a[tag=sgp.adding_prefix,limit=1] parent settrack kit cancer
execute if entity @a[tag=sgp.adding_prefix] run return run tag @a[tag=sgp.adding_prefix] remove sgp.adding_prefix

execute if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.combattant] run tag @r[scores={sgp.kit_prefix_set=0},tag=sgp.combattant] add sgp.adding_prefix
execute if entity @a[tag=sgp.adding_prefix] run scoreboard players set @a[tag=sgp.adding_prefix,limit=1] sgp.kit_prefix_set 1
execute if entity @a[tag=sgp.adding_prefix] run luckperms user @a[tag=sgp.adding_prefix,limit=1] parent settrack kit combattant
execute if entity @a[tag=sgp.adding_prefix] run return run tag @a[tag=sgp.adding_prefix] remove sgp.adding_prefix

execute if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.eclaireur] run tag @r[scores={sgp.kit_prefix_set=0},tag=sgp.eclaireur] add sgp.adding_prefix
execute if entity @a[tag=sgp.adding_prefix] run scoreboard players set @a[tag=sgp.adding_prefix,limit=1] sgp.kit_prefix_set 1
execute if entity @a[tag=sgp.adding_prefix] run luckperms user @a[tag=sgp.adding_prefix,limit=1] parent settrack kit eclaireur
execute if entity @a[tag=sgp.adding_prefix] run return run tag @a[tag=sgp.adding_prefix] remove sgp.adding_prefix

execute if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.enderman] run tag @r[scores={sgp.kit_prefix_set=0},tag=sgp.enderman] add sgp.adding_prefix
execute if entity @a[tag=sgp.adding_prefix] run scoreboard players set @a[tag=sgp.adding_prefix,limit=1] sgp.kit_prefix_set 1
execute if entity @a[tag=sgp.adding_prefix] run luckperms user @a[tag=sgp.adding_prefix,limit=1] parent settrack kit enderman
execute if entity @a[tag=sgp.adding_prefix] run return run tag @a[tag=sgp.adding_prefix] remove sgp.adding_prefix

execute if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.pigeon] run tag @r[scores={sgp.kit_prefix_set=0},tag=sgp.pigeon] add sgp.adding_prefix
execute if entity @a[tag=sgp.adding_prefix] run scoreboard players set @a[tag=sgp.adding_prefix,limit=1] sgp.kit_prefix_set 1
execute if entity @a[tag=sgp.adding_prefix] run luckperms user @a[tag=sgp.adding_prefix,limit=1] parent settrack kit pigeon
execute if entity @a[tag=sgp.adding_prefix] run return run tag @a[tag=sgp.adding_prefix] remove sgp.adding_prefix

execute if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.poseidon] run tag @r[scores={sgp.kit_prefix_set=0},tag=sgp.poseidon] add sgp.adding_prefix
execute if entity @a[tag=sgp.adding_prefix] run scoreboard players set @a[tag=sgp.adding_prefix,limit=1] sgp.kit_prefix_set 1
execute if entity @a[tag=sgp.adding_prefix] run luckperms user @a[tag=sgp.adding_prefix,limit=1] parent settrack kit poseidon
execute if entity @a[tag=sgp.adding_prefix] run return run tag @a[tag=sgp.adding_prefix] remove sgp.adding_prefix

execute if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.pyromane] run tag @r[scores={sgp.kit_prefix_set=0},tag=sgp.pyromane] add sgp.adding_prefix
execute if entity @a[tag=sgp.adding_prefix] run scoreboard players set @a[tag=sgp.adding_prefix,limit=1] sgp.kit_prefix_set 1
execute if entity @a[tag=sgp.adding_prefix] run luckperms user @a[tag=sgp.adding_prefix,limit=1] parent settrack kit pyromane
execute if entity @a[tag=sgp.adding_prefix] run return run tag @a[tag=sgp.adding_prefix] remove sgp.adding_prefix

execute if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.roi] run tag @r[scores={sgp.kit_prefix_set=0},tag=sgp.roi] add sgp.adding_prefix
execute if entity @a[tag=sgp.adding_prefix] run scoreboard players set @a[tag=sgp.adding_prefix,limit=1] sgp.kit_prefix_set 1
execute if entity @a[tag=sgp.adding_prefix] run luckperms user @a[tag=sgp.adding_prefix,limit=1] parent settrack kit roi
execute if entity @a[tag=sgp.adding_prefix] run return run tag @a[tag=sgp.adding_prefix] remove sgp.adding_prefix

execute if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.tank] run tag @r[scores={sgp.kit_prefix_set=0},tag=sgp.tank] add sgp.adding_prefix
execute if entity @a[tag=sgp.adding_prefix] run scoreboard players set @a[tag=sgp.adding_prefix,limit=1] sgp.kit_prefix_set 1
execute if entity @a[tag=sgp.adding_prefix] run luckperms user @a[tag=sgp.adding_prefix,limit=1] parent settrack kit tank
execute if entity @a[tag=sgp.adding_prefix] run return run tag @a[tag=sgp.adding_prefix] remove sgp.adding_prefix

execute if entity @a[scores={sgp.kit_prefix_set=0},tag=sgp.vindicateur] run tag @r[scores={sgp.kit_prefix_set=0},tag=sgp.vindicateur] add sgp.adding_prefix
execute if entity @a[tag=sgp.adding_prefix] run scoreboard players set @a[tag=sgp.adding_prefix,limit=1] sgp.kit_prefix_set 1
execute if entity @a[tag=sgp.adding_prefix] run luckperms user @a[tag=sgp.adding_prefix,limit=1] parent settrack kit vindicateur
execute if entity @a[tag=sgp.adding_prefix] run return run tag @a[tag=sgp.adding_prefix] remove sgp.adding_prefix
