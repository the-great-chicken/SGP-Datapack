#> sgp.spawns:spawn
# `{number: int}`
# 
# Tp the player to the spawn

tp @s ~ ~ ~ ~ ~
function sgp.spawns:disable_triggers
trigger sgp.spawn_vers_kits set 0
$scoreboard players set @s sgp.spawn_$(number) 0