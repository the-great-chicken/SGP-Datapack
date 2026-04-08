#> sgp.kits:abilities/illusions/summon
#
# Summons 3 mannequins in the other cardinal directions, with a 10s TTL

scoreboard players set @s sgp.cooldown_ability 200

summon marker ~ ~ ~ {Tags:["sgp.illusion_center", "sgp.illusion_init"]}
summon mannequin ~ ~ ~0.01 {Tags:["sgp.illusion_init", "sgp.illusion", "sgp.direction_opposite"]}
summon mannequin ~ ~ ~-0.01 {Tags:["sgp.illusion_init", "sgp.illusion", "sgp.direction_left"]}
summon mannequin ~0.01 ~ ~ {Tags:["sgp.illusion_init", "sgp.illusion", "sgp.direction_right"]}
execute as @e[type=mannequin,tag=sgp.illusion_init] run function #bs.link:create_link_ata
execute as @e[type=mannequin,tag=sgp.illusion_init] run function #bs.health:time_to_live {with:{time:10,unit:"s",on_death:"tp @s ~ -1000 ~"}}
execute as @e[type=mannequin,tag=sgp.illusion_init] run tag @s remove sgp.illusion_init
