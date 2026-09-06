#> sgp.kits:selection_rules/denied_selection
# @dummy
# @environment sgp.ci:kit_selection
#
# Denial of an unlocked kit explains the event restriction and preserves the current kit, equipment, and cooldown.

scoreboard players set @s sgp.peaceful_found 1
scoreboard players set @s sgp.roi_found 1
scoreboard players set @s sgp.kit_id 2
scoreboard players set @s sgp.cooldown_ability 37
tag @s add sgp.archer
item replace entity @s weapon.mainhand with minecraft:diamond 7
dummy KitDenyActor spawn
team join sgp.hider KitDenyActor
function sgp.kits:check_and_give {kit:"peaceful",kit_name:"Paisible",kit_color:"green",hint:"Already unlocked",hint_color:"white"}
execute store result storage sgp:data tests.kit_denied.peaceful_kit int 1 run scoreboard players get @s sgp.kit_id
execute store result storage sgp:data tests.kit_denied.peaceful_items int 1 run clear @s minecraft:diamond 0
execute store result storage sgp:data tests.kit_denied.peaceful_cooldown int 1 run scoreboard players get @s sgp.cooldown_ability
team leave KitDenyActor
tag KitDenyActor add sgp.in_game
tag KitDenyActor add sgp.roi_bleu
function sgp.kits:check_and_give {kit:"roi",kit_name:"Roi",kit_color:"gold",hint:"Already unlocked",hint_color:"white"}
dummy KitDenyActor leave

assert data storage sgp:data tests.kit_denied{peaceful_kit:2,peaceful_items:7,peaceful_cooldown:37}
assert chat ".*Le mode Paisible n'est pas disponible pendant les événements majeurs.*" @s
assert chat ".*Le kit Roi n'est pas disponible pour cet event.*" @s
assert not chat ".*Tu as obtenu le kit.*" @s
assert score @s sgp.kit_id matches 2
assert score @s sgp.cooldown_ability matches 37
assert score @s sgp.peaceful_found matches 1
assert score @s sgp.roi_found matches 1
assert entity @s[tag=sgp.archer]
assert not entity @s[tag=sgp.peaceful]
assert not entity @s[tag=sgp.roi]
function sgp.ci:kills_give/assert_count {item:"minecraft:diamond",count:7}
data remove storage sgp:data tests.kit_denied
