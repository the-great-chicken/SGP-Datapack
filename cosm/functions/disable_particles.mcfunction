execute as @s run function cosm:disable_type_particles
execute as @s run function cosm:disable_weight_particles
tellraw @s [{"text":"Tu as ", "color":"white"},{"text":"désactivé", "color":"red", "bold":true},{"text":" ta Trainée de Particules", "color":"white"}]
scoreboard players enable @s veut_desactiver
scoreboard players set @s veut_desactiver 0