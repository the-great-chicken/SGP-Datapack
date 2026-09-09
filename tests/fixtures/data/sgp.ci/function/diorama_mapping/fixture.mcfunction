#> sgp.ci:diorama_mapping/fixture
kill @e[tag=sgp.ci.mapping_ready,type=marker]
scoreboard players set #mannequin_update_time sgp.dummy 0
scoreboard players set @s bs.id 94011
scoreboard players set #map_94001_x sgp.dummy 16000
scoreboard players set #map_94001_y sgp.dummy 80000
scoreboard players set #map_94001_z sgp.dummy 16000
scoreboard players set #model_94001_x sgp.dummy 8000
scoreboard players set #model_94001_y sgp.dummy 80000
scoreboard players set #model_94001_z sgp.dummy 8000
summon mannequin 8 80 8 {Tags:["sgp.ci.mapping","sgp.ci.mapping_first","sgp.small_mannequin_94001"],NoGravity:true,Invulnerable:true,immovable:true}
scoreboard players set @e[tag=sgp.ci.mapping_first,type=mannequin] bs.link.to 94011
