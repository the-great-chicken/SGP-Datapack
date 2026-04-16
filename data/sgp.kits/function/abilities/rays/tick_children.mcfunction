#> sgp.kits:abilities/rays/tick_children

execute if entity @s[tag=sgp.south] run function sgp.kits:abilities/rays/update_ray {direction: "south", rotation: "0"}
execute if entity @s[tag=sgp.north] run function sgp.kits:abilities/rays/update_ray {direction: "north", rotation: "180"}
execute if entity @s[tag=sgp.east] run function sgp.kits:abilities/rays/update_ray {direction: "east", rotation: "-90"}
execute if entity @s[tag=sgp.west] run function sgp.kits:abilities/rays/update_ray {direction: "west", rotation: "90"}
execute if entity @s[tag=sgp.south_west] run function sgp.kits:abilities/rays/update_ray {direction: "south_west", rotation: "45"}
execute if entity @s[tag=sgp.north_east] run function sgp.kits:abilities/rays/update_ray {direction: "north_east", rotation: "-135"}
execute if entity @s[tag=sgp.south_east] run function sgp.kits:abilities/rays/update_ray {direction: "south_east", rotation: "-45"}
execute if entity @s[tag=sgp.north_west] run function sgp.kits:abilities/rays/update_ray {direction: "north_west", rotation: "135"}