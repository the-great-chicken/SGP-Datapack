#> sgp.ci:diorama_mapping/giant_fixture
function sgp.ci:diorama_mapping/fixture
# A rectangular 32-by-16 map; each axis must use its own half-width.
scoreboard players set #map_94001_center_x sgp.dummy 32000
scoreboard players set #map_94001_center_z sgp.dummy 24000
scoreboard players set #map_94001_hw_x sgp.dummy 16000
scoreboard players set #map_94001_hw_z sgp.dummy 8000
scoreboard players set #giant_offset sgp.dummy 8
summon mannequin 8.0 80.0 8.0 {Tags:["sgp.ci.mapping","sgp.ci.mapping_giant","sgp.giant_mannequin_94001"],NoGravity:true,Invulnerable:true,immovable:true}
scoreboard players set @e[tag=sgp.ci.mapping_giant,type=mannequin] bs.link.to 94011
