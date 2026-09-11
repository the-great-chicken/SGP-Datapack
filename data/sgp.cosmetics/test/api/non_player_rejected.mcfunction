#> sgp.cosmetics:api/non_player_rejected
# @dummy
# @environment sgp.ci:cosmetics
#
# Equip and unequip API calls reject non-player executors before reading unlocks or mutating cosmetic tags.

data modify storage sgp.ci:cosmetics_api non_player set value {}
summon marker ~ ~ ~ {Tags:["sgp.ci.cosmetics_api.non_player","sgp.particle.smoke","sgp.intensity.light","sgp.kill.anvil"]}
scoreboard players set @e[tag=sgp.ci.cosmetics_api.non_player,limit=1,type=marker] sgp.particle.cloud_unlocked 1
scoreboard players set @e[tag=sgp.ci.cosmetics_api.non_player,limit=1,type=marker] sgp.intensity.heavy_unlocked 1
scoreboard players set @e[tag=sgp.ci.cosmetics_api.non_player,limit=1,type=marker] sgp.kill.portal_unlocked 1

execute as @e[tag=sgp.ci.cosmetics_api.non_player,limit=1,type=marker] store result storage sgp.ci:cosmetics_api non_player.particle_equip int 1 run function sgp.cosmetics:api/equip/particle/cloud
execute as @e[tag=sgp.ci.cosmetics_api.non_player,limit=1,type=marker] store result storage sgp.ci:cosmetics_api non_player.intensity_equip int 1 run function sgp.cosmetics:api/equip/intensity/heavy
execute as @e[tag=sgp.ci.cosmetics_api.non_player,limit=1,type=marker] store result storage sgp.ci:cosmetics_api non_player.kill_equip int 1 run function sgp.cosmetics:api/equip/kill/portal
execute as @e[tag=sgp.ci.cosmetics_api.non_player,limit=1,type=marker] store result storage sgp.ci:cosmetics_api non_player.particle_unequip int 1 run function sgp.cosmetics:api/unequip/particle
execute as @e[tag=sgp.ci.cosmetics_api.non_player,limit=1,type=marker] store result storage sgp.ci:cosmetics_api non_player.intensity_unequip int 1 run function sgp.cosmetics:api/unequip/intensity
execute as @e[tag=sgp.ci.cosmetics_api.non_player,limit=1,type=marker] store result storage sgp.ci:cosmetics_api non_player.kill_unequip int 1 run function sgp.cosmetics:api/unequip/kill

assert data storage sgp.ci:cosmetics_api non_player{particle_equip:0,intensity_equip:0,kill_equip:0,particle_unequip:0,intensity_unequip:0,kill_unequip:0}
assert entity @e[tag=sgp.ci.cosmetics_api.non_player,tag=sgp.particle.smoke,tag=!sgp.particle.cloud,tag=sgp.intensity.light,tag=!sgp.intensity.heavy,tag=sgp.kill.anvil,tag=!sgp.kill.portal,limit=1,type=marker]
kill @e[tag=sgp.ci.cosmetics_api.non_player,type=marker]
data remove storage sgp.ci:cosmetics_api non_player
