#> sgp.diorama:mapping/held_equipment
# @dummy
# @environment sgp.ci:diorama_mapping/held_equipment

gamemode spectator @s
tp @s 8.0 88.0 8.0
function sgp.ci:diorama_mapping/ready
await entity @e[tag=sgp.ci.mapping_ready,x=8,y=88,z=8,distance=..1,type=marker]
function sgp.ci:diorama_mapping/fixture
tp @s 16.0 80.0 16.0 0 0
item replace entity @s weapon.mainhand with diamond_sword[damage=12,enchantments={sharpness:3},custom_data={ci_keep:7}]
item replace entity @s weapon.offhand with shield[damage=4]
scoreboard players set #mannequin_update_time sgp.dummy 4
execute at @s run function sgp.diorama:tick/update_mannequin/update_small_pos {id:94001}
assert entity @e[tag=sgp.ci.mapping_first,nbt={equipment:{mainhand:{id:"minecraft:diamond_sword",components:{"minecraft:damage":12,"minecraft:enchantments":{"minecraft:sharpness":3},"minecraft:custom_data":{ci_keep:7}}},offhand:{id:"minecraft:shield",components:{"minecraft:damage":4}}}},type=mannequin]
item replace entity @s weapon.mainhand with bow
item replace entity @s weapon.offhand with air
execute at @s run function sgp.diorama:tick/update_mannequin/update_small_pos {id:94001}
assert entity @e[tag=sgp.ci.mapping_first,nbt={equipment:{mainhand:{id:"minecraft:bow"}}},type=mannequin]
assert not data entity @n[tag=sgp.ci.mapping_first,type=mannequin] equipment.offhand
item replace entity @s weapon.mainhand with air
execute at @s run function sgp.diorama:tick/update_mannequin/update_small_pos {id:94001}
assert not data entity @n[tag=sgp.ci.mapping_first,type=mannequin] equipment.mainhand
