#> sgp.kits:selection_entry/player_isolation
# @dummy
# @environment sgp.ci:kit_selection
#
# Selecting a kit for one player must not mutate another player's kit, inventory, effects, or pending tag state.

scoreboard players set @s sgp.archer_found 1
scoreboard players set @s sgp.kit_id -1

dummy SelectPeer spawn
scoreboard players set SelectPeer sgp.kit_id 5
scoreboard players set SelectPeer sgp.reset_tags 0
tag SelectPeer add sgp.tank
item replace entity SelectPeer weapon.mainhand with minecraft:diamond 7
effect give SelectPeer minecraft:strength 60 1 true

function sgp.kits:check_and_give {kit:"archer",kit_name:"Archer",kit_color:"green",hint:"unused",hint_color:"white"}

assert score @s sgp.kit_id matches 2
assert entity @s[tag=sgp.archer_voulu]
assert score SelectPeer sgp.kit_id matches 5
assert score SelectPeer sgp.reset_tags matches 0
assert entity @a[name=SelectPeer,tag=sgp.tank]
assert not entity @a[name=SelectPeer,tag=sgp.archer_voulu]
execute as SelectPeer run function sgp.ci:inventory/expect_count {item:"minecraft:diamond",count:7}
assert entity @a[name=SelectPeer,nbt={active_effects:[{id:"minecraft:strength"}]}]
