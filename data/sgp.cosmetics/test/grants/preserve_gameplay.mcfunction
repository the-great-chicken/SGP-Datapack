#> sgp.cosmetics:grants/preserve_gameplay
# @dummy
# @environment sgp.ci:cosmetics
#
# Unlocking cosmetics leaves the current kit, equipment, cooldown, team, and gameplay eligibility unchanged.

scoreboard players set @s sgp.kit_id 2
scoreboard players set @s sgp.cooldown_ability 37
scoreboard players set @s sgp.archer_found 0
tag @s add sgp.archer
tag @s add sgp.in_game
team join sgp.rouge @s
item replace entity @s weapon.mainhand with diamond_sword[damage=17,custom_data={ci_keep:4}]
function sgp.cosmetics:unlock_all_cosmetics
assert score @s sgp.kit_id matches 2
assert score @s sgp.cooldown_ability matches 37
assert score @s sgp.archer_found matches 0
assert entity @s[tag=sgp.archer,tag=sgp.in_game,team=sgp.rouge]
execute store success score #ci.grant.item sgp.dummy if items entity @s weapon.mainhand diamond_sword[damage=17,custom_data~{ci_keep:4}]
assert score #ci.grant.item sgp.dummy matches 1
