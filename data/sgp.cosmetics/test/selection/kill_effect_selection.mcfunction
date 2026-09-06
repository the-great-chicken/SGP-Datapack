#> sgp.cosmetics:selection/kill_effect_selection
# @dummy
# @environment sgp.ci:cosmetics
#
# Kill-effect replacement is exclusive and cannot change the particle settings or equip a locked effect.

scoreboard players set @s sgp.kill.anvil_unlocked 1
scoreboard players set @s sgp.kill.portal_unlocked 1
scoreboard players set @s sgp.kill.firework_unlocked 0
tag @s add sgp.particle.ench
tag @s add sgp.intensity.light
function sgp.cosmetics:kill_effects/reset_and_replace {kill:"anvil",kill_name:"Anvil",color:"gray"}
assert entity @s[tag=sgp.kill.anvil]
function sgp.cosmetics:kill_effects/reset_and_replace {kill:"portal",kill_name:"Portal",color:"dark_purple"}
assert entity @s[tag=sgp.kill.portal,tag=sgp.particle.ench,tag=sgp.intensity.light]
assert not entity @s[tag=sgp.kill.anvil]
function sgp.cosmetics:kill_effects/reset_and_replace {kill:"firework",kill_name:"Locked firework",color:"red"}
assert entity @s[tag=sgp.kill.portal,tag=sgp.particle.ench,tag=sgp.intensity.light]
assert not entity @s[tag=sgp.kill.firework]
assert chat ".*pas encore débloqué.*Locked firework.*" @s
assert score @s sgp.kill.firework_unlocked matches 0
assert score @s sgp.kill.anvil_unlocked matches 1
assert score @s sgp.kill.portal_unlocked matches 1
