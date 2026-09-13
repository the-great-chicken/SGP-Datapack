#> sgp.cosmetics:api/equip_particles
# @dummy
# @environment sgp.ci:cosmetics
#
# Every particle API endpoint returns success and leaves exactly its requested particle equipped.

data modify storage sgp.ci:cosmetics_api equip_particles set value {}
function sgp.cosmetics:particles/disable_type
function sgp.cosmetics:particles/disable_intensity
function sgp.cosmetics:kill_effects/disable
tag @s add sgp.particle.marine
tag @s add sgp.intensity.medium
tag @s add sgp.kill.anvil
scoreboard players set @s sgp.particle.cloud_unlocked 1
scoreboard players set @s sgp.particle.ench_unlocked 1
scoreboard players set @s sgp.particle.flame_crown_unlocked 1
scoreboard players set @s sgp.particle.marine_unlocked 1
scoreboard players set @s sgp.particle.smoke_unlocked 1

execute store result storage sgp.ci:cosmetics_api equip_particles.cloud int 1 run function sgp.cosmetics:api/equip/particle/cloud
assert entity @s[tag=sgp.particle.cloud,tag=!sgp.particle.ench,tag=!sgp.particle.flame_crown,tag=!sgp.particle.marine,tag=!sgp.particle.smoke]

execute store result storage sgp.ci:cosmetics_api equip_particles.ench int 1 run function sgp.cosmetics:api/equip/particle/ench
assert entity @s[tag=!sgp.particle.cloud,tag=sgp.particle.ench,tag=!sgp.particle.flame_crown,tag=!sgp.particle.marine,tag=!sgp.particle.smoke]

execute store result storage sgp.ci:cosmetics_api equip_particles.flame_crown int 1 run function sgp.cosmetics:api/equip/particle/flame_crown
assert entity @s[tag=!sgp.particle.cloud,tag=!sgp.particle.ench,tag=sgp.particle.flame_crown,tag=!sgp.particle.marine,tag=!sgp.particle.smoke]

execute store result storage sgp.ci:cosmetics_api equip_particles.marine int 1 run function sgp.cosmetics:api/equip/particle/marine
assert entity @s[tag=!sgp.particle.cloud,tag=!sgp.particle.ench,tag=!sgp.particle.flame_crown,tag=sgp.particle.marine,tag=!sgp.particle.smoke]

execute store result storage sgp.ci:cosmetics_api equip_particles.smoke int 1 run function sgp.cosmetics:api/equip/particle/smoke
assert entity @s[tag=!sgp.particle.cloud,tag=!sgp.particle.ench,tag=!sgp.particle.flame_crown,tag=!sgp.particle.marine,tag=sgp.particle.smoke]

assert data storage sgp.ci:cosmetics_api equip_particles{cloud:1,ench:1,flame_crown:1,marine:1,smoke:1}
assert entity @s[tag=sgp.intensity.medium,tag=sgp.kill.anvil]
assert score @s sgp.particle.cloud_unlocked matches 1
assert score @s sgp.particle.ench_unlocked matches 1
assert score @s sgp.particle.flame_crown_unlocked matches 1
assert score @s sgp.particle.marine_unlocked matches 1
assert score @s sgp.particle.smoke_unlocked matches 1
data remove storage sgp.ci:cosmetics_api equip_particles
