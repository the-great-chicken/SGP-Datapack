#> sgp.ci:rays/scenarios/other_linked_displays

function sgp.ci:rays/fixture
summon item_display 20.0 88.0 20.0 {Tags:["sgp.ci.ray_other"]}
summon item_display 20.0 88.0 20.0 {Tags:["sgp.ci.ray_other"]}
summon item_display 20.0 88.0 20.0 {Tags:["sgp.ci.ray_other"]}
summon item_display 20.0 88.0 20.0 {Tags:["sgp.ci.ray_other"]}
summon item_display 20.0 88.0 20.0 {Tags:["sgp.ci.ray_other"]}
summon item_display 20.0 88.0 20.0 {Tags:["sgp.ci.ray_other"]}
summon item_display 20.0 88.0 20.0 {Tags:["sgp.ci.ray_other"]}
summon item_display 20.0 88.0 20.0 {Tags:["sgp.ci.ray_other"]}
scoreboard players operation @e[tag=sgp.ci.ray_other,type=item_display] bs.link.to = @s bs.id
setblock 8 88 12 stone
function sgp.ci:rays/start
function sgp.ci:rays/update
function sgp.ci:rays/beam {direction:south,scale:"6990..7010",center:"1745..1755"}
execute store result score #ci.rays.other sgp.dummy if entity @e[tag=sgp.ci.ray_other,type=item_display]
assert score #ci.rays.other sgp.dummy matches 8
