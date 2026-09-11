#> sgp.kits:selection_entry/locked_preserves_state
# @dummy
# @environment sgp.ci:kit_selection
#
# A locked selection explains the unlock requirement without disturbing the current player state.

scoreboard players set @s sgp.archer_found 0
scoreboard players set @s sgp.kit_id 5
scoreboard players set @s sgp.cooldown_ability 37
tag @s add sgp.tank
item replace entity @s weapon.mainhand with minecraft:diamond 7
effect give @s minecraft:strength 60 1 true

function sgp.kits:check_and_give {kit:"archer",kit_name:"Archer",kit_color:"green",hint:"Indice CI",hint_color:"yellow"}

assert score @s sgp.kit_id matches 5
assert score @s sgp.cooldown_ability matches 37
assert entity @s[tag=sgp.tank]
assert not entity @s[tag=sgp.archer_voulu]
function sgp.ci:inventory/expect_count {item:"minecraft:diamond",count:7}
assert entity @s[nbt={active_effects:[{id:"minecraft:strength"}]}]
assert chat ".*Débloque le kit archer en le trouvant dans la map.*" @s
assert chat ".*Indice CI.*" @s
assert not chat ".*Tu as obtenu le kit Archer.*" @s
