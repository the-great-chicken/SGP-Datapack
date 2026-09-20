#> sgp.ci:pyromane_fire/cleanup
# Remove lingering-fire fixtures, source TNT, linked interactions, and test players.

execute as @a[tag=sgp.ci.fire_actor] run function sgp.kits:abilities/tnt/clear_fire_cooldown

kill @e[tag=sgp.ci.fire,type=marker]
kill @e[tag=sgp.ci.fire,type=tnt]
kill @e[tag=sgp.ci.fire,type=interaction]
function sgp.ci:players/cleanup
