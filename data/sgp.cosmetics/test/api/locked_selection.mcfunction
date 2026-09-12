#> sgp.cosmetics:api/locked_selection
# @dummy
# @environment sgp.ci:cosmetics
#
# Locked API selections return failure without erasing the player's current choice in any category.

data modify storage sgp.ci:cosmetics_api locked_selection set value {}
function sgp.cosmetics:particles/disable_type
function sgp.cosmetics:particles/disable_intensity
function sgp.cosmetics:kill_effects/disable
tag @s add sgp.particle.smoke
tag @s add sgp.intensity.light
tag @s add sgp.kill.anvil
scoreboard players set @s sgp.particle.ench_unlocked 0
scoreboard players set @s sgp.intensity.medium_unlocked 0
scoreboard players set @s sgp.kill.splash_unlocked 0

execute store result storage sgp.ci:cosmetics_api locked_selection.particle int 1 run function sgp.cosmetics:api/equip/particle/ench
execute store result storage sgp.ci:cosmetics_api locked_selection.intensity int 1 run function sgp.cosmetics:api/equip/intensity/medium
execute store result storage sgp.ci:cosmetics_api locked_selection.kill int 1 run function sgp.cosmetics:api/equip/kill/splash

assert data storage sgp.ci:cosmetics_api locked_selection{particle:0,intensity:0,kill:0}
assert score @s sgp.particle.ench_unlocked matches 0
assert score @s sgp.intensity.medium_unlocked matches 0
assert score @s sgp.kill.splash_unlocked matches 0
assert entity @s[tag=!sgp.particle.cloud,tag=!sgp.particle.ench,tag=!sgp.particle.flame_crown,tag=!sgp.particle.marine,tag=sgp.particle.smoke,tag=sgp.intensity.light,tag=!sgp.intensity.medium,tag=!sgp.intensity.heavy,tag=!sgp.intensity.super_heavy,tag=sgp.kill.anvil,tag=!sgp.kill.cloud,tag=!sgp.kill.explosion,tag=!sgp.kill.firework,tag=!sgp.kill.hurt,tag=!sgp.kill.portal,tag=!sgp.kill.splash,tag=!sgp.kill.witch]
data remove storage sgp.ci:cosmetics_api locked_selection
