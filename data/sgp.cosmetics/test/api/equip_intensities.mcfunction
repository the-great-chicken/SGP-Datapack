#> sgp.cosmetics:api/equip_intensities
# @dummy
# @environment sgp.ci:cosmetics
#
# Every intensity API endpoint returns success and leaves exactly its requested intensity equipped.

data modify storage sgp.ci:cosmetics_api equip_intensities set value {}
function sgp.cosmetics:particles/disable_type
function sgp.cosmetics:particles/disable_intensity
function sgp.cosmetics:kill_effects/disable
tag @s add sgp.particle.smoke
tag @s add sgp.intensity.super_heavy
tag @s add sgp.kill.anvil
scoreboard players set @s sgp.intensity.light_unlocked 1
scoreboard players set @s sgp.intensity.medium_unlocked 1
scoreboard players set @s sgp.intensity.heavy_unlocked 1
scoreboard players set @s sgp.intensity.super_heavy_unlocked 1

execute store result storage sgp.ci:cosmetics_api equip_intensities.light int 1 run function sgp.cosmetics:api/equip/intensity/light
assert entity @s[tag=sgp.intensity.light,tag=!sgp.intensity.medium,tag=!sgp.intensity.heavy,tag=!sgp.intensity.super_heavy]

execute store result storage sgp.ci:cosmetics_api equip_intensities.medium int 1 run function sgp.cosmetics:api/equip/intensity/medium
assert entity @s[tag=!sgp.intensity.light,tag=sgp.intensity.medium,tag=!sgp.intensity.heavy,tag=!sgp.intensity.super_heavy]

execute store result storage sgp.ci:cosmetics_api equip_intensities.heavy int 1 run function sgp.cosmetics:api/equip/intensity/heavy
assert entity @s[tag=!sgp.intensity.light,tag=!sgp.intensity.medium,tag=sgp.intensity.heavy,tag=!sgp.intensity.super_heavy]

execute store result storage sgp.ci:cosmetics_api equip_intensities.super_heavy int 1 run function sgp.cosmetics:api/equip/intensity/super_heavy
assert entity @s[tag=!sgp.intensity.light,tag=!sgp.intensity.medium,tag=!sgp.intensity.heavy,tag=sgp.intensity.super_heavy]

assert data storage sgp.ci:cosmetics_api equip_intensities{light:1,medium:1,heavy:1,super_heavy:1}
assert entity @s[tag=sgp.particle.smoke,tag=sgp.kill.anvil]
assert score @s sgp.intensity.light_unlocked matches 1
assert score @s sgp.intensity.medium_unlocked matches 1
assert score @s sgp.intensity.heavy_unlocked matches 1
assert score @s sgp.intensity.super_heavy_unlocked matches 1
data remove storage sgp.ci:cosmetics_api equip_intensities
