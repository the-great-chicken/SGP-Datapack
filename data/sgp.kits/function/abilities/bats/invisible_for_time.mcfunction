#> sgp.kits:abilities/bats/invisible_for_time
# `{duration: int, seconds}`

$effect give @s invisibility $(duration) 0 true
$effect give @s weakness $(duration) 0 true
$execute positioned ~ ~0.2 ~ run function sgp.misc:summon_multiple {nbr:10, entity:bat, nbt:{Tags:["sgp.bat_grenade"]}, execute:'function sgp.kits:abilities/bats/setup_bat {duration:$(duration)}'}
