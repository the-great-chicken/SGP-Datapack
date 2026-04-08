#> sgp.kits:abilities/illusions/trigger
#
# Summons 3 mannequins in the other cardinal directions, with a 10s TTL

scoreboard players set @s sgp.cooldown_ability 200
team join sgp.Illusion @s

# Summon mannequins with the player's profile
data modify storage sgp:data kits.illusion.current_uuid set from entity @s UUID
data modify storage sgp:data kits.illusion.current_direction set value "opposite"
execute positioned ~ ~ ~0.001 run function sgp.kits:abilities/illusions/summon with storage sgp:data kits.illusion
data modify storage sgp:data kits.illusion.current_direction set value "left"
execute positioned ~ ~ ~-0.001 run function sgp.kits:abilities/illusions/summon with storage sgp:data kits.illusion
data modify storage sgp:data kits.illusion.current_direction set value "right"
execute positioned ~0.001 ~ ~ run function sgp.kits:abilities/illusions/summon with storage sgp:data kits.illusion

# Il peut y avoir un bug du nom du sélecteur si 2 alchimistes activent sur le mm tick
summon text_display ~ ~ ~ {Tags:["sgp.temp_name"], text:{selector:"@p[scores={sgp.drop_any=1..},tag=sgp.alchimiste]"}}
data modify entity @e[type=mannequin,tag=sgp.illusion_init,tag=sgp.direction_opposite,limit=1] CustomName set from entity @e[type=text_display,tag=sgp.temp_name,limit=1] text
data modify entity @e[type=mannequin,tag=sgp.illusion_init,tag=sgp.direction_left,limit=1] CustomName set from entity @e[type=text_display,tag=sgp.temp_name,limit=1] text
data modify entity @e[type=mannequin,tag=sgp.illusion_init,tag=sgp.direction_right,limit=1] CustomName set from entity @e[type=text_display,tag=sgp.temp_name,limit=1] text
kill @e[type=text_display,tag=sgp.temp_name]

summon marker ~ ~00.1 ~ {Tags:["sgp.marker", "sgp.illusion_center", "sgp.illusion_init"]}

execute as @e[tag=sgp.illusion_init] run function #bs.link:create_link_ata
execute as @e[tag=sgp.illusion_init] run function #bs.health:time_to_live {with:{time:10,unit:"s",on_death:"tp @s ~ -1000 ~"}}
execute as @e[tag=sgp.illusion_init] run team join sgp.Illusion @s

# Copy the stuff from the player
item replace entity @e[type=mannequin,tag=sgp.illusion_init] armor.head from entity @s armor.head
item replace entity @e[type=mannequin,tag=sgp.illusion_init] armor.chest from entity @s armor.chest
item replace entity @e[type=mannequin,tag=sgp.illusion_init] armor.legs from entity @s armor.legs
item replace entity @e[type=mannequin,tag=sgp.illusion_init] armor.feet from entity @s armor.feet
item replace entity @e[type=mannequin,tag=sgp.illusion_init] weapon.mainhand from entity @s weapon.mainhand
item replace entity @e[type=mannequin,tag=sgp.illusion_init] weapon.offhand from entity @s weapon.offhand

execute as @e[tag=sgp.illusion_init] run tag @s remove sgp.illusion_init
