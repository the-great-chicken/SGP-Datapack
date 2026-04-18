function sgp.kits:give {kit:roi}
tag @s add tag1
team join sgp.Pigeons @s
tp @s @e[type=marker,tag=sgp.marker,name="spawns",limit=1]
function sgp.spawns:enable_triggers
scoreboard players set @s sgp.devenir_pigeon 0
glow add @a[team=sgp.Chasseurs_pigeon] @a[team=sgp.Pigeons] GRAY