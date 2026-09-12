#> sgp.cosmetics:api/equip_kill_effects
# @dummy
# @environment sgp.ci:cosmetics
#
# Every kill-effect API endpoint returns success and leaves exactly its requested effect equipped.

data modify storage sgp.ci:cosmetics_api equip_kill_effects set value {}
function sgp.cosmetics:particles/disable_type
function sgp.cosmetics:particles/disable_intensity
function sgp.cosmetics:kill_effects/disable
tag @s add sgp.particle.smoke
tag @s add sgp.intensity.light
tag @s add sgp.kill.witch
scoreboard players set @s sgp.kill.anvil_unlocked 1
scoreboard players set @s sgp.kill.cloud_unlocked 1
scoreboard players set @s sgp.kill.explosion_unlocked 1
scoreboard players set @s sgp.kill.firework_unlocked 1
scoreboard players set @s sgp.kill.hurt_unlocked 1
scoreboard players set @s sgp.kill.portal_unlocked 1
scoreboard players set @s sgp.kill.splash_unlocked 1
scoreboard players set @s sgp.kill.witch_unlocked 1

execute store result storage sgp.ci:cosmetics_api equip_kill_effects.anvil int 1 run function sgp.cosmetics:api/equip/kill/anvil
assert entity @s[tag=sgp.kill.anvil,tag=!sgp.kill.cloud,tag=!sgp.kill.explosion,tag=!sgp.kill.firework,tag=!sgp.kill.hurt,tag=!sgp.kill.portal,tag=!sgp.kill.splash,tag=!sgp.kill.witch]

execute store result storage sgp.ci:cosmetics_api equip_kill_effects.cloud int 1 run function sgp.cosmetics:api/equip/kill/cloud
assert entity @s[tag=!sgp.kill.anvil,tag=sgp.kill.cloud,tag=!sgp.kill.explosion,tag=!sgp.kill.firework,tag=!sgp.kill.hurt,tag=!sgp.kill.portal,tag=!sgp.kill.splash,tag=!sgp.kill.witch]

execute store result storage sgp.ci:cosmetics_api equip_kill_effects.explosion int 1 run function sgp.cosmetics:api/equip/kill/explosion
assert entity @s[tag=!sgp.kill.anvil,tag=!sgp.kill.cloud,tag=sgp.kill.explosion,tag=!sgp.kill.firework,tag=!sgp.kill.hurt,tag=!sgp.kill.portal,tag=!sgp.kill.splash,tag=!sgp.kill.witch]

execute store result storage sgp.ci:cosmetics_api equip_kill_effects.firework int 1 run function sgp.cosmetics:api/equip/kill/firework
assert entity @s[tag=!sgp.kill.anvil,tag=!sgp.kill.cloud,tag=!sgp.kill.explosion,tag=sgp.kill.firework,tag=!sgp.kill.hurt,tag=!sgp.kill.portal,tag=!sgp.kill.splash,tag=!sgp.kill.witch]

execute store result storage sgp.ci:cosmetics_api equip_kill_effects.hurt int 1 run function sgp.cosmetics:api/equip/kill/hurt
assert entity @s[tag=!sgp.kill.anvil,tag=!sgp.kill.cloud,tag=!sgp.kill.explosion,tag=!sgp.kill.firework,tag=sgp.kill.hurt,tag=!sgp.kill.portal,tag=!sgp.kill.splash,tag=!sgp.kill.witch]

execute store result storage sgp.ci:cosmetics_api equip_kill_effects.portal int 1 run function sgp.cosmetics:api/equip/kill/portal
assert entity @s[tag=!sgp.kill.anvil,tag=!sgp.kill.cloud,tag=!sgp.kill.explosion,tag=!sgp.kill.firework,tag=!sgp.kill.hurt,tag=sgp.kill.portal,tag=!sgp.kill.splash,tag=!sgp.kill.witch]

execute store result storage sgp.ci:cosmetics_api equip_kill_effects.splash int 1 run function sgp.cosmetics:api/equip/kill/splash
assert entity @s[tag=!sgp.kill.anvil,tag=!sgp.kill.cloud,tag=!sgp.kill.explosion,tag=!sgp.kill.firework,tag=!sgp.kill.hurt,tag=!sgp.kill.portal,tag=sgp.kill.splash,tag=!sgp.kill.witch]

execute store result storage sgp.ci:cosmetics_api equip_kill_effects.witch int 1 run function sgp.cosmetics:api/equip/kill/witch
assert entity @s[tag=!sgp.kill.anvil,tag=!sgp.kill.cloud,tag=!sgp.kill.explosion,tag=!sgp.kill.firework,tag=!sgp.kill.hurt,tag=!sgp.kill.portal,tag=!sgp.kill.splash,tag=sgp.kill.witch]

assert data storage sgp.ci:cosmetics_api equip_kill_effects{anvil:1,cloud:1,explosion:1,firework:1,hurt:1,portal:1,splash:1,witch:1}
assert entity @s[tag=sgp.particle.smoke,tag=sgp.intensity.light]
assert score @s sgp.kill.anvil_unlocked matches 1
assert score @s sgp.kill.cloud_unlocked matches 1
assert score @s sgp.kill.explosion_unlocked matches 1
assert score @s sgp.kill.firework_unlocked matches 1
assert score @s sgp.kill.hurt_unlocked matches 1
assert score @s sgp.kill.portal_unlocked matches 1
assert score @s sgp.kill.splash_unlocked matches 1
assert score @s sgp.kill.witch_unlocked matches 1
data remove storage sgp.ci:cosmetics_api equip_kill_effects
