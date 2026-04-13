#> sgp.kits:abilities/rays/tick

tag @s add sgp.radiator

execute as @n[type=item_display,tag=sgp.ray,tag=sgp.south] run function sgp.kits:abilities/rays/update_ray {direction: "south", rotation: "0"}
execute as @n[type=item_display,tag=sgp.ray,tag=sgp.north] run function sgp.kits:abilities/rays/update_ray {direction: "north", rotation: "180"}
execute as @n[type=item_display,tag=sgp.ray,tag=sgp.east] run function sgp.kits:abilities/rays/update_ray {direction: "east", rotation: "-90"}
execute as @n[type=item_display,tag=sgp.ray,tag=sgp.west] run function sgp.kits:abilities/rays/update_ray {direction: "west", rotation: "90"}
execute as @n[type=item_display,tag=sgp.ray,tag=sgp.south_west] run function sgp.kits:abilities/rays/update_ray {direction: "south_west", rotation: "-45"}
execute as @n[type=item_display,tag=sgp.ray,tag=sgp.north_east] run function sgp.kits:abilities/rays/update_ray {direction: "north_east", rotation: "-135"}
execute as @n[type=item_display,tag=sgp.ray,tag=sgp.south_east] run function sgp.kits:abilities/rays/update_ray {direction: "south_east", rotation: "45"}
execute as @n[type=item_display,tag=sgp.ray,tag=sgp.north_west] run function sgp.kits:abilities/rays/update_ray {direction: "north_west", rotation: "135"}

playsound entity.ender_eye.death master @a ~ ~ ~ 1 0

tag @s remove sgp.radiator

execute if score @s sgp.cooldown_ability matches ..100 run function sgp.kits:abilities/rays/end