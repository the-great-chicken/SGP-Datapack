#> sgp.kits:abilities/manage_dropped_item

execute at @e[tag=sgp.marker,name="abilities_shulker",limit=1,type=marker] run function sgp.kits:abilities/give_back_item
kill @s