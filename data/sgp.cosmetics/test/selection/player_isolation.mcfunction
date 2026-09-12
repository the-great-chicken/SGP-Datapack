#> sgp.cosmetics:selection/player_isolation
# @dummy
# @environment sgp.ci:cosmetics
#
# One player's selections and another player's disable actions leave each other's cosmetics alone.

dummy CosmeticOther spawn
tag CosmeticOther add sgp.particle.smoke
tag CosmeticOther add sgp.intensity.light
tag CosmeticOther add sgp.kill.anvil
scoreboard players set CosmeticOther sgp.particle.cloud_unlocked 0
scoreboard players set @s sgp.particle.cloud_unlocked 1
scoreboard players set @s sgp.intensity.heavy_unlocked 1
scoreboard players set @s sgp.kill.portal_unlocked 1
function sgp.cosmetics:particles/reset_and_replace {particle:"cloud",particle_name:"Cloud",color:"white"}
function sgp.cosmetics:particles/reset_and_replace_intensity {intensity:"heavy",intensity_name:"Heavy",color:"gold"}
function sgp.cosmetics:kill_effects/reset_and_replace {kill:"portal",kill_name:"Portal",color:"dark_purple"}
assert entity @a[name=CosmeticOther,tag=sgp.particle.smoke,tag=sgp.intensity.light,tag=sgp.kill.anvil]
assert not entity @a[name=CosmeticOther,tag=sgp.particle.cloud]
assert not entity @a[name=CosmeticOther,tag=sgp.intensity.heavy]
assert not entity @a[name=CosmeticOther,tag=sgp.kill.portal]
execute as CosmeticOther run function sgp.cosmetics:particles/reset_and_replace {particle:"cloud",particle_name:"Cloud",color:"white"}
assert entity @a[name=CosmeticOther,tag=sgp.particle.smoke]
assert not entity @a[name=CosmeticOther,tag=sgp.particle.cloud]
execute as CosmeticOther run function sgp.cosmetics:particles/manually_disable
execute as CosmeticOther run function sgp.cosmetics:kill_effects/manually_disable
assert entity @s[tag=sgp.particle.cloud,tag=sgp.intensity.heavy,tag=sgp.kill.portal]
assert not entity @a[name=CosmeticOther,tag=sgp.particle.smoke]
assert not entity @a[name=CosmeticOther,tag=sgp.intensity.light]
assert not entity @a[name=CosmeticOther,tag=sgp.kill.anvil]
