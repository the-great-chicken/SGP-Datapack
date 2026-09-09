#> sgp.ci:protection/health

# {range}: expected health multiplied by 1000.
execute store result score #ci.protection.health sgp.dummy run data get entity @s Health 1000
$assert score #ci.protection.health sgp.dummy matches $(range)
