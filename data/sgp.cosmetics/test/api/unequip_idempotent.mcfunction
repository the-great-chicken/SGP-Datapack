#> sgp.cosmetics:api/unequip_idempotent
# @dummy
# @environment sgp.ci:cosmetics
#
# Unequip clears every known tag in its slot, preserves other slots, and still succeeds when repeated on an empty slot.

data modify storage sgp.ci:cosmetics_api unequip set value {}
function sgp.cosmetics:particles/disable_type
function sgp.cosmetics:particles/disable_intensity
function sgp.cosmetics:kill_effects/disable
# Deliberately create inconsistent multi-selection state to verify each API clears the whole slot.
tag @s add sgp.particle.cloud
tag @s add sgp.particle.smoke
tag @s add sgp.intensity.light
tag @s add sgp.intensity.heavy
tag @s add sgp.kill.anvil
tag @s add sgp.kill.portal

execute store result storage sgp.ci:cosmetics_api unequip.particle_first int 1 run function sgp.cosmetics:api/unequip/particle
assert entity @s[tag=!sgp.particle.cloud,tag=!sgp.particle.ench,tag=!sgp.particle.flame_crown,tag=!sgp.particle.marine,tag=!sgp.particle.smoke,tag=sgp.intensity.light,tag=!sgp.intensity.medium,tag=sgp.intensity.heavy,tag=!sgp.intensity.super_heavy,tag=sgp.kill.anvil,tag=!sgp.kill.cloud,tag=!sgp.kill.explosion,tag=!sgp.kill.firework,tag=!sgp.kill.hurt,tag=sgp.kill.portal,tag=!sgp.kill.splash,tag=!sgp.kill.witch]
execute store result storage sgp.ci:cosmetics_api unequip.particle_second int 1 run function sgp.cosmetics:api/unequip/particle

execute store result storage sgp.ci:cosmetics_api unequip.intensity_first int 1 run function sgp.cosmetics:api/unequip/intensity
assert entity @s[tag=!sgp.intensity.light,tag=!sgp.intensity.medium,tag=!sgp.intensity.heavy,tag=!sgp.intensity.super_heavy,tag=sgp.kill.anvil,tag=!sgp.kill.cloud,tag=!sgp.kill.explosion,tag=!sgp.kill.firework,tag=!sgp.kill.hurt,tag=sgp.kill.portal,tag=!sgp.kill.splash,tag=!sgp.kill.witch]
execute store result storage sgp.ci:cosmetics_api unequip.intensity_second int 1 run function sgp.cosmetics:api/unequip/intensity

execute store result storage sgp.ci:cosmetics_api unequip.kill_first int 1 run function sgp.cosmetics:api/unequip/kill
assert entity @s[tag=!sgp.kill.anvil,tag=!sgp.kill.cloud,tag=!sgp.kill.explosion,tag=!sgp.kill.firework,tag=!sgp.kill.hurt,tag=!sgp.kill.portal,tag=!sgp.kill.splash,tag=!sgp.kill.witch]
execute store result storage sgp.ci:cosmetics_api unequip.kill_second int 1 run function sgp.cosmetics:api/unequip/kill

assert data storage sgp.ci:cosmetics_api unequip{particle_first:1,particle_second:1,intensity_first:1,intensity_second:1,kill_first:1,kill_second:1}
data remove storage sgp.ci:cosmetics_api unequip
