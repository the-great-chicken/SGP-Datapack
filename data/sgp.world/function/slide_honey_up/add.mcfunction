#> sgp.world:slide_honey_up/add

# Only execute when we're actually hugging the honey block
execute if block ~ ~ ~ #air if block ~-0.24 ~ ~ #air if block ~0.24 ~ ~ #air if block ~ ~ ~-0.24 #air if block ~ ~ ~0.24 #air \
        if block ~ ~1 ~ #air if block ~-0.24 ~1 ~ #air if block ~0.24 ~1 ~ #air if block ~ ~1 ~-0.24 #air if block ~ ~1 ~0.24 #air \
        run return 1

summon armor_stand ~ ~ ~ {Tags:["sgp.vel_reset"],Invisible:true,Marker:true,Silent:true}
ride @s mount @e[tag=sgp.vel_reset,distance=..1,limit=1,type=armor_stand]
ride @s dismount
kill @e[tag=sgp.vel_reset,distance=..2,limit=1,type=armor_stand]


attribute @s minecraft:gravity modifier add sgp:sliding_up -1.15 add_multiplied_total
tag @s add sgp.sliding_up