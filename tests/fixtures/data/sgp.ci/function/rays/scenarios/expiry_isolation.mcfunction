#> sgp.ci:rays/scenarios/expiry_isolation

function sgp.ci:rays/fixture
function sgp.ci:rays/start
dummy RayPeer spawn
gamemode survival RayPeer
tp RayPeer 20.0 88.0 20.0
execute as RayPeer at @s run function sgp.kits:abilities/rays/init
function sgp.ci:rays/count {count:8}
execute as RayPeer run function sgp.ci:rays/count {count:8}
summon item_display 8.0 88.0 9.0 {Tags:["sgp.ci.ray_other"]}
scoreboard players operation @e[tag=sgp.ci.ray_other,limit=1,type=item_display] bs.link.to = @s bs.id
scoreboard players set @s sgp.duration_ability 1
function sgp.ci:rays/update
function sgp.ci:rays/count {count:0}
execute as RayPeer run function sgp.ci:rays/count {count:8}
assert entity @e[tag=sgp.ci.ray_other,type=item_display]
