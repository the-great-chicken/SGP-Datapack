#> sgp.kits:bigger/kit_replacement
# @dummy
# @environment sgp.ci:bigger/kit_replacement

function sgp.ci:bigger/fixture
scoreboard players set @s sgp.kit_id 5
tag @s add sgp.in_game
execute at @s run function sgp.kits:abilities/route_ability
function sgp.ci:bigger/expect {scale:"199999..200001",jump:"52499..52501",reach:"449999..450001",damage:"199999..200001"}
function sgp.kits:give {kit:combattant}
function sgp.kits:kit_tags/management
function sgp.kits:abilities/tick
assert entity @s[tag=sgp.combattant,tag=!sgp.tank,tag=!sgp.stats_tank_boost_active]
assert score @s sgp.kit_id matches 1
assert score @s sgp.duration_ability matches 0
# Unequip the new sword before measuring attack damage.
item replace entity @s weapon.mainhand with air
function sgp.ci:bigger/expect {scale:"99999..100001",jump:"41999..42001",reach:"299999..300001",damage:"99999..100001"}
