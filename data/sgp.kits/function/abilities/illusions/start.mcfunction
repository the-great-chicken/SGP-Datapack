#> sgp.kits:abilities/illusions/start
#
# Summons 3 mannequins in the other cardinal directions

execute store result score @s sgp.cooldown_ability run data get storage sgp:data kits.ability_cooldowns.illusions.cooldown
execute store result score @s sgp.duration_ability run data get storage sgp:data kits.ability_cooldowns.illusions.duration
team join sgp.Illusion @s

# Summon mannequins with the player's profile
data modify storage sgp:data kits.illusion.current_uuid set from entity @s UUID
data modify storage sgp:data kits.illusion.current_direction set value "opposite"
execute positioned ~ ~ ~0.001 run function sgp.kits:abilities/illusions/summon with storage sgp:data kits.illusion

data modify storage sgp:data kits.illusion.current_direction set value "left"
execute positioned ~ ~ ~-0.001 run function sgp.kits:abilities/illusions/summon with storage sgp:data kits.illusion

data modify storage sgp:data kits.illusion.current_direction set value "right"
execute positioned ~0.001 ~ ~ run function sgp.kits:abilities/illusions/summon with storage sgp:data kits.illusion

summon marker ~ ~0.001 ~ {Tags:["sgp.marker", "sgp.illusion_center", "sgp.illusion_init"]}
execute as @e[tag=sgp.illusion_init,tag=sgp.illusion_center,distance=..0.1,limit=1,type=marker] run function sgp.kits:abilities/illusions/link

# Copy the stuff from the player
item replace entity @e[tag=sgp.illusion_init,distance=..0.1,limit=3,type=mannequin] armor.head from entity @s armor.head
item replace entity @e[tag=sgp.illusion_init,distance=..0.1,limit=3,type=mannequin] armor.chest from entity @s armor.chest
item replace entity @e[tag=sgp.illusion_init,distance=..0.1,limit=3,type=mannequin] armor.legs from entity @s armor.legs
item replace entity @e[tag=sgp.illusion_init,distance=..0.1,limit=3,type=mannequin] armor.feet from entity @s armor.feet
item replace entity @e[tag=sgp.illusion_init,distance=..0.1,limit=3,type=mannequin] weapon.mainhand from entity @s weapon.mainhand
item replace entity @e[tag=sgp.illusion_init,distance=..0.1,limit=3,type=mannequin] weapon.offhand from entity @s weapon.offhand

# Make illusions immune to suffocation
data modify entity @e[tag=sgp.illusion_init,tag=sgp.direction_opposite,distance=..0.1,limit=1,type=mannequin] equipment.head.components."minecraft:enchantments"."sgp.kits:suffocation_immunity" set value 1
data modify entity @e[tag=sgp.illusion_init,tag=sgp.direction_left,distance=..0.1,limit=1,type=mannequin] equipment.head.components."minecraft:enchantments"."sgp.kits:suffocation_immunity" set value 1
data modify entity @e[tag=sgp.illusion_init,tag=sgp.direction_right,distance=..0.1,limit=1,type=mannequin] equipment.head.components."minecraft:enchantments"."sgp.kits:suffocation_immunity" set value 1

execute as @e[tag=sgp.illusion_init,distance=..0.1,limit=1,type=marker] run tag @s remove sgp.illusion_init
execute as @e[tag=sgp.illusion_init,distance=..0.1,limit=3,type=mannequin] run tag @s remove sgp.illusion_init