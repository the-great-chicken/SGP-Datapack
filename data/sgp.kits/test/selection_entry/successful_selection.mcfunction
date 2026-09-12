#> sgp.kits:selection_entry/successful_selection
# @dummy
# @environment sgp.ci:kit_selection
#
# Selecting an unlocked ordinary kit clears the old loadout and applies the requested kit contract.

scoreboard players set @s sgp.archer_found 1
scoreboard players set @s sgp.kit_id -1
scoreboard players set @s sgp.reset_tags 0
item replace entity @s weapon.mainhand with minecraft:diamond 7
effect give @s minecraft:strength 60 1 true

function sgp.kits:check_and_give {kit:"archer",kit_name:"Archer",kit_color:"green",hint:"unused",hint_color:"white"}

assert score @s sgp.kit_id matches 2
assert score @s sgp.reset_tags matches 1
assert entity @s[tag=sgp.archer_voulu]
function sgp.ci:inventory/expect_count {item:"minecraft:diamond",count:0}
function sgp.ci:inventory/expect_count {item:"minecraft:wooden_sword",count:1}
function sgp.ci:inventory/expect_count {item:"minecraft:bow",count:1}
function sgp.ci:inventory/expect_count {item:"minecraft:arrow",count:1}
assert entity @s[nbt={active_effects:[{id:"minecraft:speed"}]}]
assert not entity @s[nbt={active_effects:[{id:"minecraft:strength"}]}]
assert chat ".*Tu as obtenu le kit Archer.*" @s
assert chat ".*Escampette.*" @s
