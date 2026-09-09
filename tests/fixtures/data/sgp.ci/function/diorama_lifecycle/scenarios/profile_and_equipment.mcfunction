#> sgp.ci:diorama_lifecycle/scenarios/profile_and_equipment

function sgp.ci:diorama_lifecycle/fixture
item replace entity @s armor.head with diamond_helmet[damage=9]
item replace entity @s armor.chest with leather_chestplate[dyed_color=65280]
item replace entity @s armor.legs with iron_leggings
item replace entity @s armor.feet with golden_boots
item replace entity @s weapon.mainhand with diamond_sword[enchantments={sharpness:3}]
item replace entity @s weapon.offhand with shield
# The player and model are far apart; owner resolution must use the player, not the model's nearest viewer.
data modify storage sgp.ci:diorama_lifecycle owner set from entity @s UUID
tag @s add sgp.in_game
tp @s 34.0 81.0 34.0
function sgp.ci:diorama_lifecycle/small_update
function sgp.ci:diorama_lifecycle/count {type:small,count:1}
scoreboard players operation $link.to bs.in = @s bs.id
execute as @n[tag=sgp.small_mannequin_96001,predicate=bs.link:link_equal,type=mannequin] run function sgp.ci:diorama_lifecycle/profile
assert entity @e[tag=sgp.small_mannequin_96001,nbt={equipment:{head:{id:"minecraft:diamond_helmet",components:{"minecraft:damage":9}},chest:{id:"minecraft:leather_chestplate"},legs:{id:"minecraft:iron_leggings"},feet:{id:"minecraft:golden_boots"},mainhand:{id:"minecraft:diamond_sword",components:{"minecraft:enchantments":{"minecraft:sharpness":3}}},offhand:{id:"minecraft:shield"}}},type=mannequin]
execute as @n[tag=sgp.small_mannequin_96001,predicate=bs.link:link_equal,type=mannequin] store result score #ci.lifecycle.scale sgp.dummy run attribute @s minecraft:scale get 10000
assert score #ci.lifecycle.scale sgp.dummy matches 625
assert not entity @s[tag=sgp.mannequin_init]
assert not entity @e[tag=sgp.new,type=mannequin]
