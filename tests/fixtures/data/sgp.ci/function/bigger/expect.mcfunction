#> sgp.ci:bigger/expect

# {scale, jump, reach, damage}: attribute values multiplied by 100000, with rounding tolerance.
execute store result score #ci.bigger.scale sgp.dummy run attribute @s minecraft:scale get 100000
execute store result score #ci.bigger.jump sgp.dummy run attribute @s minecraft:jump_strength get 100000
execute store result score #ci.bigger.reach sgp.dummy run attribute @s minecraft:entity_interaction_range get 100000
execute store result score #ci.bigger.damage sgp.dummy run attribute @s minecraft:attack_damage get 100000
$assert score #ci.bigger.scale sgp.dummy matches $(scale)
$assert score #ci.bigger.jump sgp.dummy matches $(jump)
$assert score #ci.bigger.reach sgp.dummy matches $(reach)
$assert score #ci.bigger.damage sgp.dummy matches $(damage)
