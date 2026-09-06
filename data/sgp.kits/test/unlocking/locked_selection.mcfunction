#> sgp.kits:unlocking/locked_selection
# @dummy
# @environment sgp.ci:unlocking
#
# A locked kit gives its discovery hint and leaves the current kit and equipment intact.

scoreboard players set @s sgp.kit_id 2
tag @s add sgp.archer
item replace entity @s weapon.mainhand with minecraft:diamond 7
scoreboard players reset @s sgp.tank_found
function sgp.kits:check_and_give {kit:"tank",kit_name:"Tank",kit_color:"gray",hint:"Search the tower",hint_color:"yellow"}
assert chat ".*Search the tower.*" @s
assert not chat ".*Tu as obtenu le kit.*" @s
assert score @s sgp.kit_id matches 2
assert entity @s[tag=sgp.archer]
assert not entity @s[tag=sgp.tank_voulu]
function sgp.ci:kills_give/assert_count {item:"minecraft:diamond",count:7}

scoreboard players set @s sgp.tank_found 0
function sgp.kits:check_and_give {kit:"tank",kit_name:"Tank",kit_color:"gray",hint:"Search the garden",hint_color:"yellow"}
assert chat ".*Search the garden.*" @s
assert not chat ".*Tu as obtenu le kit.*" @s
assert score @s sgp.tank_found matches 0
assert score @s sgp.kit_id matches 2
assert entity @s[tag=sgp.archer]
assert not entity @s[tag=sgp.tank_voulu]
function sgp.ci:kills_give/assert_count {item:"minecraft:diamond",count:7}
